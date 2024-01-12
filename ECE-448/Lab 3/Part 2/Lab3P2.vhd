library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Lab3P2 is
     Port (  RST, CLK : in STD_LOGIC;
             BTN : in STD_LOGIC_VECTOR (4 downto 0);
             SSEG_CA : out STD_LOGIC_VECTOR (7 downto 0);
             SSEG_AN : out STD_LOGIC_VECTOR (3 downto 0));
end Lab3P2;

architecture Behavioral of Lab3P2 is
    signal counter : STD_LOGIC_VECTOR(15 downto 0):=x"0000";
    signal CA, AN : STD_LOGIC_VECTOR (3 downto 0);
    signal ClkDiv: STD_LOGIC_VECTOR (18 downto 0):="0000000000000000000";
    signal operation : STD_LOGIC:='0';
    signal TimingBits : STD_LOGIC_VECTOR (1 downto 0);
begin

process (CA) begin
    case CA is
        when "0000" => SSEG_CA <= "11000000";
        when "0001" => SSEG_CA <= "11111001";
        when "0010" => SSEG_CA <= "10100100";
        when "0011" => SSEG_CA <= "10110000";
        when "0100" => SSEG_CA <= "10011001";
        when "0101" => SSEG_CA <= "10010010";
        when "0110" => SSEG_CA <= "10000010";
        when "0111" => SSEG_CA <= "11111000";
        when "1000" => SSEG_CA <= "10000000";
        when "1001" => SSEG_CA <= "10010000";
        when "1010" => SSEG_CA <= "10001000";
        when "1011" => SSEG_CA <= "10000011";
        when "1100" => SSEG_CA <= "11000110";
        when "1101" => SSEG_CA <= "10100001";
        when "1110" => SSEG_CA <= "10000110";
        when "1111" => SSEG_CA <= "10001110";
        when others => SSEG_CA <= "11000000";
    end case;
end process;

process (CLK) begin
    if (CLK'event and CLK ='1') then
        ClkDiv <= ClkDiv+1;
    end if;
end process;

TimingBits <= ClkDiv(18 downto 17);

process (TimingBits, RST) begin
    case (TimingBits) is
        when "00" =>
             SSEG_AN <= "1110";
             CA <= counter(3 downto 0);
        when "01" =>
             SSEG_AN <= "1101";
             CA <= counter(7 downto 4);
        when "10" =>
             SSEG_AN <= "1011";
             CA <= counter(11 downto 8);
        when "11" =>
             SSEG_AN <= "0111";
             CA <= counter(15 downto 12);
        when others => 
             SSEG_AN <= AN;
             CA <= CA;
    end case;
end process;

process (BTN, RST) begin
    if (BTN(4) = '1') then
	   operation <= not(operation);
    end if;
    case operation is 
	   when '0' =>
	       case BTN is 
	           when "01000" =>
		          counter <= std_logic_vector(unsigned(counter) + x"0001");
	           when "00001" =>
		          counter <= std_logic_vector(unsigned(counter) + x"0005");
	           when "00100" =>
		          counter <= std_logic_vector(unsigned(counter) + x"000A");	       
	           when "00010" =>
		          counter <= std_logic_vector(unsigned(counter) + x"0014");	       
	           when others =>
	               counter <= counter;
	       end case;
	   when '1' =>
	       case BTN is 
	           when "01000" =>
		          counter <= std_logic_vector(unsigned(counter) - x"0001");
	           when "00001" =>
		          counter <= std_logic_vector(unsigned(counter) - x"0005");
	           when "00100" =>
		          counter <= std_logic_vector(unsigned(counter) - x"000A");	       
	           when "00010" =>
		          counter <= std_logic_vector(unsigned(counter) - x"0014");	       
	           when others =>
	               counter <= counter;
	       end case;
	   when others => 
	       counter <= counter;
    end case;
    if (RST = '1') then
        counter <= x"0000";
	    operation <= '0';
    end if;
end process;

end Behavioral;