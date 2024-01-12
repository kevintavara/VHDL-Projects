library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity P2_tb is
end P2_tb;

architecture Behavioral of P2_tb is 
  component Lab3P2 Port ( CLK, RST : in STD_LOGIC;
    BTN : in STD_LOGIC_VECTOR(4 downto 0);
             SSEG_CA : out STD_LOGIC_VECTOR (7 downto 0);
             SSEG_AN : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal CLK, RST : std_logic; 
signal BTN : std_logic_vector(4 downto 0);
signal SSEG_CA : STD_LOGIC_VECTOR (7 downto 0);
signal SSEG_AN : STD_LOGIC_VECTOR (3 downto 0);

begin
UUT : Lab3P2
   Port map(
	RST => RST,
	SSEG_CA => SSEG_CA,
	SSEG_AN => SSEG_AN,
	BTN => BTN,
	CLK => CLK);
	
Clock : process
begin
	Clk <= '0';
	RST <= '0';
	wait for 10ns;
	Clk <= '1';
	wait for 10ns;
end process;

Button : process
begin
	BTN <= "00000";
	wait for 1000ns;
	BTN <= "00010";
	wait for 1000ns;
end process;


end;