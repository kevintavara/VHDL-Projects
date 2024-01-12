----------------------------------------------------------------------------
-- Modified by Dr. Tolga Soyata - 12/3/2021
-- This project creates simple background patterns on the VGA screen.
-- Patterns are controlled by the switches as follows:
--
-- Default pattern (when all switches are '0' is a VGA B&W checker board
--
-- SW(15) = '1' alternates the B and W pattern (2 s period) 
-- SW(14) = '1' alternates the colors and the pattern (8s period)
-- SW(13) = '1' creates a colored checker board
-- SW(12) = '1' superimposes the moving HI object on top of the background 
----------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity P220_VGAcheckers is
    Port ( CLK 			: in  STD_LOGIC;
           SW  			: in   std_logic_vector (15 downto 0);
           SSEG_CA 		: out  STD_LOGIC_VECTOR (7 downto 0);
           SSEG_AN 		: out  STD_LOGIC_VECTOR (3 downto 0);
           VGA_RED      : out  STD_LOGIC_VECTOR (3 downto 0);
           VGA_BLUE     : out  STD_LOGIC_VECTOR (3 downto 0);
           VGA_GREEN    : out  STD_LOGIC_VECTOR (3 downto 0);
           VGA_VS       : out  STD_LOGIC;
           VGA_HS       : out  STD_LOGIC
         );
end P220_VGAcheckers;

architecture Behavioral of P220_VGAcheckers is
    signal ClkDiv: unsigned(31 downto 0);
    signal ROTtheta: std_logic_vector (15 downto 0) := X"0000";
    signal MYoptions: std_logic_vector(15 downto 0);                     -- VGA options
    
    
    
    type Segments is array (1 to 4) of std_logic_vector(4 downto 0);
    signal Display: Segments;
    type sseg_digits is array (0 to 16) of std_logic_vector(7 downto 0);
    constant digit_table: sseg_digits := (
        "11000000",  -- 0
        "11111001",  -- 1 
        "10100100",  -- 2 
        "10110000",  -- 3
        "10011001",  -- 4
        "10010010",  -- 5
        "10000010",  -- 6
        "11111000",  -- 7 
        "10000000",  -- 8
        "10011000",  -- 9 
        "10001000",  -- A
        "10000011",  -- b 
        "11000110",  -- C 
        "10100001",  -- d 
        "10000110",  -- E 
        "10001110",  -- F
        "11111111"   -- blank
    ); 


begin

process (clk,ClkDiv) begin
    if(rising_edge(clk)) then
        ClkDiv <= ClkDiv+1;
    end if;
    ROTtheta <= std_logic_vector(ClkDiv(31 downto 16));
    Display(1) <= "0" & std_logic_vector(ClkDiv(31 downto 28));
    Display(2) <= "0" & std_logic_vector(ClkDiv(27 downto 24));
    Display(3) <= "10000";  -- blank
    Display(4) <= "10000";  -- blank
    
    MYoptions <= SW; 
end process;



-- SSEG sequencer. Displays the contents of screen memory
-- Display(1) is the left segment
-- Display(2) is the second segment
-- Display(3) is the third segment
-- Display(4) is the right segment
process (ClkDiv(18 downto 17), Display) begin
    case (ClkDiv(18 downto 17)) is
        when "00" =>
             -- first segment  left
             SSEG_AN <= "0111";
             SSEG_CA <= digit_table(to_integer(unsigned(Display(1))));
             -- Display H or V
             if (SW(15) = '0') then 
                SSEG_CA <= "10001001";
             else
                SSEG_CA <= "11000001";
             end if;
        when "01" =>
             -- second segment
             SSEG_AN <= "1011";
             -- Makes position 2 of SSEG blank
             SSEG_CA <= "11111111";
        when "10" =>
             -- third segment
             SSEG_AN <= "1101";
             SSEG_CA <= digit_table(to_integer(unsigned(Display(3))));
             if (SW(15) = '0' and SW(14) = '0') then 
                SSEG_CA <= "11111111";
             elsif (SW(15) = '0' and SW(14) = '1') then 
                SSEG_CA <= "11111001";
             elsif (SW(15) = '1' and SW(14) = '0') then 
                SSEG_CA <= "11111001";
             elsif (SW(15) = '1' and SW(14) = '1') then 
                SSEG_CA <= "10100100";
             end if;
        when "11" =>
             -- fourth segment    right
             SSEG_AN <= "1110";
             SSEG_CA <= digit_table(to_integer(unsigned(Display(4))));
             if (SW(15) = '0' and SW(14) = '0') then 
                SSEG_CA <= "10000000";
             elsif (SW(15) = '0' and SW(14) = '1') then 
                SSEG_CA <= "10000010";
             elsif (SW(15) = '1') then 
                SSEG_CA <= "11000000";
             end if;
    end case;
end process;


----------------------------------------------------------
------              P200 VGA Control (modified)    -------
----------------------------------------------------------

Inst_P220vga_ctrl: entity work.P220vga_ctrl 
port map(
		CLK_I => CLK,
		SW => SW,
		ROTangle => ROTtheta,
		VGAoptions => MYoptions,
		VGA_HS_O => VGA_HS,
        VGA_VS_O => VGA_VS,
		VGA_RED_O => VGA_RED,
        VGA_BLUE_O => VGA_BLUE,
        VGA_GREEN_O => VGA_GREEN
);


end Behavioral;
