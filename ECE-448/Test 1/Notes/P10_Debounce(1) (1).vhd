---------------------------------------------------------------------------------------------------
-- Created by Dr. Tolga Soyata  9/30/2021
-- This program uses BTNC as Reset. Upoon reset, counter is set to 0
-- BTNC (Reset) is not debounced
--
-- BTND counts up
-- BTND is debounced. Debounce period is DebouncePeriod.
--
-- SSEG displays show a 4-digit decimal number
-- BTNC resets the number to 0; the number cycles back to 0000 from 9999
--
--  SW(15)='1' is the "debounce" option
--       SW(15)='0' no debouncing. Use extremely low DebouncePeriod to achieve this
--       SW(15)='1' debounces BTND
--
--      Enabling/Disabling debouncing allows students to demonstrate 
--      the negative impact of not debouncing
--
----------------------------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity P10_Debounce is
    Port ( CLK      : in  STD_LOGIC;
           SW       : in  STD_LOGIC_VECTOR (15 downto 0);
           BTN      : in  STD_LOGIC_VECTOR (4 downto 0);
           SSEG_CA  : out std_logic_vector (7 downto 0);
           SSEG_AN  : out std_logic_vector (3 downto 0));
end P10_Debounce;



architecture Behavioral of P10_Debounce is
    type GameState is (start, wait1, wait0, increase);
    signal CurrentState, NextState: GameState := start;

    type ButtonState is (unknown, dirty1, clean1, dirty0, clean0);
    signal BTNDstate: ButtonState := unknown; -- state of BTND
    signal DebounceTimer: unsigned(21 downto 0); 
    signal DebouncePeriod : unsigned(21 downto 0);
    
    signal ClkDiv: unsigned (31 downto 0);
    signal Reset, BTND:  std_logic;


    type HexDigits is range 0 to 15;
    type Segments is array (1 to 4) of HexDigits;
    signal Display: Segments; 
    type sseg_digits is array (HexDigits) of std_logic_vector(7 downto 0);
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
        "10000110",  -- C 
        "10100001",  -- d 
        "10000110",  -- E 
        "10001110"   -- F
    ); 

begin


BTND  <= BTN(3);  -- dirty BTND
Reset <= BTN(4); -- BTNC

-- SW(15) = '1' is "debounce.   ='0' is "do not debounce"
process(SW(15)) begin
    if(SW(15) = '0') then
        DebouncePeriod <= (0 => '1', others => '0'); -- extremely small debounce period
    else
        DebouncePeriod <= (others => '1'); -- about 30-40 ms. debounce period
    end if;
end process;


process (clk) begin
    if(rising_edge(clk)) then
        ClkDiv <= ClkDiv+1;
        if(Reset = '1') then
            CurrentState <= start;
        else
            CurrentState <= NextState;    
        end if;
    end if;
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
             SSEG_CA <= digit_table(Display(1));
        when "01" =>
             -- second segment
             SSEG_AN <= "1011";
             SSEG_CA <= digit_table(Display(2));
        when "10" =>
             -- third segment
             SSEG_AN <= "1101";
             SSEG_CA <= digit_table(Display(3));
        when "11" =>
             -- fourth segment    right
             SSEG_AN <= "1110";
             SSEG_CA <= digit_table(Display(4));
    end case;
end process;



-- Debouncer for BTND
process (BTND, BTNDstate, clk) begin
    if(rising_edge(clk)) then
    case (BTNDstate) is
            when unknown    =>
                DebounceTimer <= DebouncePeriod;
                if(BTND = '1') then
                    BTNDstate <= dirty1;
                else
                    BTNDstate <= dirty0;
                end if; 
            when dirty1 =>
                DebounceTimer <= DebounceTimer - 1;
                if (DebounceTimer = B"00_0000_0000_0000_0000_0000") then
                    if(BTND = '1') then
                        BTNDstate <= clean1;
                    else
                        BTNDstate <= unknown;
                    end if;
                end if; 
            when clean1     =>
                if(BTND = '1') then
                    BTNDstate <= clean1;
                else
                    BTNDstate <= unknown;
                end if;
            when dirty0 =>
                DebounceTimer <= DebounceTimer - 1;
                if (DebounceTimer = B"00_0000_0000_0000_0000_0000") then
                    if(BTND = '0') then
                        BTNDstate <= clean0;
                    else
                        BTNDstate <= unknown;
                    end if;
                end if; 
            when clean0     => 
                if(BTND = '0') then
                    BTNDstate <= clean0;
                else
                    BTNDstate <= unknown;
                end if;
        end case;
    end if;
end process;




-- Compute NextState combinatorially for BTND
process (CurrentState, BTNDstate) begin
    case (CurrentState) is
        when start      =>
            NextState <= wait1;
        when wait1      => 
            if (BTNDstate /= clean1) then
                NextState <= wait1;
            else
                NextState <= wait0;
            end if;     
        when wait0      => 
            if(BTNDstate /= clean0) then
                NextState <= wait0;
            else
                NextState <= increase;
            end if;
        when increase   => 
            NextState <= wait1;
        when others     => 
            NextState <= start;
    end case;
end process;



-- Tasks to do in each state
process (clk, CurrentState, Display) begin
    if(rising_edge(clk)) then
        case (CurrentState) is
            when start     =>
                Display(1) <= 0;
                Display(2) <= 0;
                Display(3) <= 0;
                Display(4) <= 0;
            when increase  => 
                if(Display(4)=9) then
                    Display(4) <= 0;
                    if(Display(3)=9) then
                        Display(3) <= 0;
                        if(Display(2)=9) then
                            Display(2) <= 0;
                            if(Display(1)=9) then
                                Display(1) <= 0;
                            else
                                Display(1) <= Display(1)+1;
                            end if;
                        else
                            Display(2) <= Display(2)+1;
                        end if;
                    else
                        Display(3) <= Display(3)+1;
                    end if;
                else
                    Display(4) <= Display(4)+1;
                end if; 
            when others    => 
        end case;
    end if;
end process;



end Behavioral;
