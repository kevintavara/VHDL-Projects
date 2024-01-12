----------------------------------------------------------------------------------
-- Created by Dr. Tolga Soyata  9/21/2021
-- This program displays ABCD on SSEG segments
----------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity P08_ABCD is
    Port ( CLK      : in STD_LOGIC;
           SSEG_AN  : out STD_LOGIC_VECTOR (3 downto 0);   ---   selection
           SSEG_CA  : out STD_LOGIC_VECTOR (7 downto 0));  ---   data to display
end P08_ABCD;

architecture Behavioral of P08_ABCD is
    signal ClkDiv: unsigned (28 downto 0);
begin

process (clk) begin
    if(rising_edge(clk)) then
        ClkDiv <= ClkDiv+1;
    end if;
end process;

process (ClkDiv(18 downto 17)) begin
    case (ClkDiv(18 downto 17)) is
        when "00" =>
             -- first segment
             SSEG_AN <= "0111";
             SSEG_CA <= "10001000";   -- A
        when "01" =>
             -- second segment
             SSEG_AN <= "1011";
             SSEG_CA <= "10000011";   -- b
        when "10" =>
             -- third segment
             SSEG_AN <= "1101";
             SSEG_CA <= "11000110";   -- C
        when "11" =>
             -- fourth segment
             SSEG_AN <= "1110";
             SSEG_CA <= "10100001";   -- d
    end case;
end process;

end Behavioral;
