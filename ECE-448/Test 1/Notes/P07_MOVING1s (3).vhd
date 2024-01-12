----------------------------------------------------------------------------------
-- Created by Dr. Tolga Soyata  9/14/2021
-- This program moves a pattern of 1s from right to left
-- Switches determine the move speed and the LED pattern as follows:
--   SW(0) means the moving pattern is 11
--   SW(1) means the moving pattern is 111
--   SW(2) means the moving pattern is 1111
--   SW(3) determine the speed:   
--      0 is slow (4-5 seconds per move)
--      1 is fast (1   second  per move)
--   SW(4) freezes the LEDs. Whatever is there stays until SW(4)=0 again
----------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity P07_MOVING1s is
    Port ( CLK  : in std_logic;
           SW   : in std_logic_vector (15 downto 0);
           LED  : out std_logic_vector (15 downto 0));
end P07_MOVING1s;

architecture Behavioral of P07_MOVING1s is
    signal ClkDiv           : unsigned (31 downto 0);
    signal TimingBits       : std_logic_vector (3 downto 0);
    signal DistinctStates   : std_logic_vector (3 downto 0);

    signal LEDpattern       : std_logic_vector (15 downto 0);
    signal RepeatPattern    : std_logic_vector (3 downto 0);
    signal Multiplier       : unsigned (4 downto 0);
    signal a                : unsigned (20 downto 0);
begin


process(SW(2 downto 0)) begin
    case SW(2 downto 0) is
        when "100" =>                   
            DistinctStates <= "0101";   -- 5 distinct states
            RepeatPattern  <= "1111";   -- repeating 1111 pattern
            Multiplier     <= "10000";  -- shift 4 bits (mult=16)   
        when "010" =>                   
            DistinctStates <= "0110";   -- 6 distinct states   
            RepeatPattern  <= "0111";   -- repeating 111 pattern
            Multiplier     <= "01000";  -- shift 3 bits (mult=8)   
        when "001" =>                   
            DistinctStates <= "1001";   -- 9 distinct states   
            RepeatPattern  <= "0011";   -- repeating 11 pattern
            Multiplier     <= "00100";  -- shift 2 bits (mult=4)   
         -- any other option is invalid
         when others =>  
            DistinctStates <= "0000";   -- no distinct states
            RepeatPattern  <= "0000";   -- no repetition. frozen   
            Multiplier     <= "00000";  -- invalid. mult=0   
    end case;
end process;

process(SW(3), ClkDiv) begin
    if(SW(3)='1') then    -- fast
        TimingBits <= std_logic_vector (ClkDiv(29 downto 26));
    else                  -- slow
        TimingBits <= std_logic_vector (ClkDiv(31 downto 28));
    end if;
end process;


process (clk, TimingBits, DistinctStates) begin
    if(clk'event and clk = '1') then
        -- SW(4)=1 freezes the clock (not incremented)
        if(SW(4)='0') then ClkDiv <= ClkDiv+1; end if;
    end if;
    if(TimingBits = DistinctStates) then
        ClkDiv <= X"0000_0000";
    end if;
    -- SW(5) is DEBUG MODE
    if(SW(5)='1') then
        LED <=   TimingBits & DistinctStates & RepeatPattern 
                 & std_logic_vector(Multiplier(4 downto 1));
    else
        LED <= LEDpattern;   -- Take the computed "LEDpattern" and display
    end if;
    

end process;



--process (TimingBits, RepeatPattern, DistinctStates, Multiplier) begin
process (clk) begin
    if (rising_edge(clk)) then
        case TimingBits is
            -- start state is always the same for all patterns
            -- all LEDs OFF in the start state (state 0)
            when "0000" =>
                LEDpattern <= B"0000_0000_0000_0000";
            when "0001" =>
            -- in state=1 the pattern shows on the rightmost LEDs
                LEDpattern <= B"0000_0000_0000" & RepeatPattern;
            when "0010" =>
                a <= unsigned(B"0000_0000_0000"&Repeatpattern) * Multiplier;
                LEDpattern <= std_logic_vector(a(15 downto 0));
            when others => 
                LEDpattern <= B"0000_0000_0000_0000";
        end case;    -- TimingBits
    end if; -- rising_edge
end process;     -- TimingBits


end Behavioral;
