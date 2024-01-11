library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux32b3_tb is
end mux32b3_tb;

architecture Behavioral of mux32b3_tb is 
Component mux32b3 Port (
    	  A, B, C  : in  STD_LOGIC_VECTOR (31 downto 0);
	  S     : in  STD_LOGIC_VECTOR(1 downto 0);
          F     : out STD_LOGIC_VECTOR (31 downto 0) );
end Component;

signal A1, B1, C1, D1: std_logic_vector(31 DOWNTO 0);
signal S1: std_logic_vector(1 downto 0);
begin
uut : mux32b3
   Port map(
	A => A1,
	B => B1,
	C => C1,
	S => S1,
	F => D1);
	
Clock : process
begin
	A1 <= x"FFFFFFFE";
	B1 <= x"00000001";
	C1 <= x"F0000001";
	S1  <= "00";
	wait for 10ns;
	A1 <= x"00000000";
	B1 <= x"00000001";
	C1 <= x"F0010001";
	S1  <= "01";
	wait for 10ns;
	A1 <= x"D1111111";
	B1 <= x"00000000";
	C1 <= x"F00F0001";
	S1  <= "10";
	wait for 10ns;
end process;
end;