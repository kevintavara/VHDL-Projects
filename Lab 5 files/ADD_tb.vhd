library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ADD_tb is
end ADD_tb;

architecture Behavioral of ADD_tb is 
Component ADD Port (
    	  A, B  : in  STD_LOGIC_VECTOR (31 downto 0);
          Dout : out  STD_LOGIC_VECTOR (31 downto 0) );
end Component;

signal A1, B1, D1: std_logic_vector(31 DOWNTO 0);

begin
uut : ADD
   Port map(
	A => A1,
	B => B1,
	Dout => D1);
	
Clock : process
begin
	A1 <= x"FFFFFFFE";
	B1 <= x"00000001";
	wait for 10ns;
	A1 <= x"00000000";
	B1 <= x"00000001";
	wait for 10ns;
	A1 <= x"D1111111";
	B1 <= x"00000000";
	wait for 10ns;
end process;
end;