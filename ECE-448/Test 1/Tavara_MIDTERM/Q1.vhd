library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Q1 is
    Port ( SW   : in  std_logic_vector (3 downto 0);
           LED  : out std_logic_vector (15 downto 0) );
end Q1;

architecture Behavioral of Q1 is

begin

process (SW) begin
    case SW(3 downto 0) is 
        when "0000" => LED <= "0000000000000000";
        when "0001" => LED <= "0000000100000000";
        when "0010" => LED <= "0000001100000000";
        when "0011" => LED <= "0000001110000000";
        when "0100" => LED <= "0000011110000000";
        when "0101" => LED <= "0000011111000000";
        when "0110" => LED <= "0000011111100000"; 
        when "0111" => LED <= "0000111111100000";
        when "1000" => LED <= "0000111111110000";
        when "1001" => LED <= "0001111111110000";
        when "1010" => LED <= "0001111111111000";
        when "1011" => LED <= "0011111111111000";
        when "1100" => LED <= "0011111111111100";
        when "1101" => LED <= "0111111111111100";
        when "1110" => LED <= "0111111111111110";
        when "1111" => LED <= "1111111111111110";
    end case;
end process;
end Behavioral;