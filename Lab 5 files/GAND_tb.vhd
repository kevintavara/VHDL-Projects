library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity GAND_tb is
end GAND_tb;

architecture Behavioral of GAND_tb is 
Component GAND Port (
    	  A, B  : in  STD_LOGIC;
          F : out  STD_LOGIC );
end Component;

signal A1, B1, D1: std_logic;

begin
uut : GAND
   Port map(
	A => A1,
	B => B1,
	F => D1);
	
Clock : process
begin
	A1 <= '0';
	B1 <= '0';
	wait for 10ns;
	A1 <= '0';
	B1 <= '1';
	wait for 10ns;
	A1 <= '1';
	B1 <= '1';
	wait for 10ns;
end process;
end;