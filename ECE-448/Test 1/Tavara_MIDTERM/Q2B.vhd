library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity Q2 is
    Port ( CLK : in STD_LOGIC;
           SSEG_AN : out STD_LOGIC_VECTOR(3 downto 0);
           SSEG_CA : out STD_LOGIC_VECTOR(6 downto 0) );
end Q2;

architecture Behavioral of Q2 is
signal ClkDiv : unsigned (31 downto 0);
signal TimingBits : std_logic_vector (3 downto 0);
begin
TimingBits <= STD_LOGIC_VECTOR(ClkDiv(29 downto 26));
process (CLK) begin
    if(CLK'event and CLK = '1') then
        ClkDiv <= ClkDiv+1;
    end if;
end process;

process (clk) begin
    if (rising_edge(clk)) then
        case TimingBits is
            when "0000" =>
                SSEG_CA <= "1111110";
                SSEG_AN <= "0111";
            when "0100" =>
                SSEG_CA <= "1111110";
                SSEG_AN <= "1011";
            when "1000" =>
                SSEG_CA <= "1111110";
                SSEG_AN <= "1101";
            when "1100" =>
                SSEG_CA <= "1111110";
                SSEG_AN <= "1110";
            when "0001" =>
                SSEG_CA <= "1111001";
                SSEG_AN <= "0111";
            when "0101" =>
                SSEG_CA <= "1111001";
                SSEG_AN <= "1011";
            when "1001" =>
                SSEG_CA <= "1111001";
                SSEG_AN <= "1101";
            when "1101" =>
                SSEG_CA <= "1111001";
                SSEG_AN <= "1110";
            when "0010" =>
                SSEG_CA <= "1110111";
                SSEG_AN <= "0111";
            when "0110" =>
                SSEG_CA <= "1110111";
                SSEG_AN <= "1011";
            when "1010" =>
                SSEG_CA <= "1110111";
                SSEG_AN <= "1101";
            when "1110" =>
                SSEG_CA <= "1110111";
                SSEG_AN <= "1110";
            when "0011" =>
                SSEG_CA <= "1001111";
                SSEG_AN <= "0111";
            when "0111" =>
                SSEG_CA <= "1001111";
                SSEG_AN <= "1011";
            when "1011" =>
                SSEG_CA <= "1001111";
                SSEG_AN <= "1101";
            when "1111" =>
                SSEG_CA <= "1001111";
                SSEG_AN <= "1110";
            when others => 
                SSEG_CA <= "1111111";
                SSEG_AN <= "1111";
        end case;
    end if;
end process;
end Behavioral;