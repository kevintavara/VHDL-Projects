----------------------------------------------------------------------------------------------------------------
-- Created by Dr. Tolga Soyata           9/12/2021
-- This program creates a bouncing LED pattern in LED(15) ... LED (0)
-- LEDs turn on sequentially in the cycle LED(15) -> LED(14) -> ... LED(0)
-- and when it hits the edge LED(0), it bounces and starts moving to the left
-- When moving left, its pattern is LED(0) -> LED(1) -> ... LED(15)
-- When it his LED(15) it reverses direction and repeats the original pattern
-- 
-- The LED-to-LED transition speed is controlled by two switches SW(1 downto 0)
--   00 turns off all LEDs
--   01 has an approx. 5 second roundtrip speed (left movement and right movement) 
--   10 has an approx. 1 second round trip speed
--   11 has an approx. 0.5 second round trip speed
-----------------------------------------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;


entity HW2Q1 is
    Port ( CLK : in STD_LOGIC;
           SW   : in  std_logic_vector (15 downto 0);
           LED  : out std_logic_vector (15 downto 0));
end HW2Q1;

architecture Behavioral of HW2Q1 is
    signal ClkDiv: unsigned (28 downto 0);
    signal LEDpattern: std_logic_vector (15 downto 0);
    signal TimingBits: std_logic_vector (5 downto 0); -- bit5=0 is blanking
    signal a: std_logic_vector (1 downto 0);
begin

process (CLK) begin
    if(CLK'event and CLK = '1') then
        ClkDiv <= ClkDiv+1;
    end if;
    LED <= LEDpattern;
end process;

process (SW(1 downto 0)) begin
    a <= SW(1 downto 0);
    TimingBits(5) <= '1';     --- some LED will turn ON
    if (a="00") then
        TimingBits(5) <= '0'; --- all LEDs OFF
    elsif (a="01") then
        TimingBits(4 downto 0) <= std_logic_vector(ClkDiv(28 downto 24));
    elsif (a="10") then
        TimingBits(4 downto 0) <= std_logic_vector(ClkDiv(26 downto 22));
    else
        TimingBits(4 downto 0) <= std_logic_vector(ClkDiv(25 downto 21));
    end if;
end process;
    
process (TimingBits) begin
    if(TimingBits(5)='0') then
        LEDpattern <= "0000000000000000";    -- all LEDs are OFF
    else
        case TimingBits(4 downto 0) is
            when "00000" | "11111" =>          LEDPattern <= "1000000000000000";  
            when "00001" | "11110" =>          LEDPattern <= "0100000000000000";  
            when "00010" | "11101" =>          LEDPattern <= "0010000000000000";  
            when "00011" | "11100" =>          LEDPattern <= "0001000000000000";  
            when "00100" | "11011" =>          LEDPattern <= "0000100000000000";  
            when "00101" | "11010" =>          LEDPattern <= "0000010000000000";  
            when "00110" | "11001" =>          LEDPattern <= "0000001000000000";  
            when "00111" | "11000" =>          LEDPattern <= "0000000100000000";  
            when "01000" | "10111" =>          LEDPattern <= "0000000010000000";  
            when "01001" | "10110" =>          LEDPattern <= "0000000001000000";  
            when "01010" | "10101" =>          LEDPattern <= "0000000000100000";  
            when "01011" | "10100" =>          LEDPattern <= "0000000000010000";  
            when "01100" | "10011" =>          LEDPattern <= "0000000000001000";  
            when "01101" | "10010" =>          LEDPattern <= "0000000000000100";  
            when "01110" | "10001" =>          LEDPattern <= "0000000000000010";  
            when "01111" | "10000" =>          LEDPattern <= "0000000000000001";  
        end case;
    end if; 
end process; 

end Behavioral;
