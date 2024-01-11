library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Shift2_tb is
end Shift2_tb;

architecture Behavioral of Shift2_tb is 
Component Shift2     
    Port (Din  : in   STD_LOGIC_VECTOR(31 downto 0);
          Dout : out  STD_LOGIC_VECTOR(31 downto 0));
end Component;

signal Di : std_logic_vector(31 DOWNTO 0);
signal Do : std_logic_vector(31 DOWNTO 0);

begin
uut : Shift2
   Port map(
	Din => Di,
	Dout => Do);
	
Test : process
begin
	Di <= x"00001234";
	wait for 10ns;
	Di <= x"0000000F";
	wait for 10ns;
	Di <= x"C000F000";
	wait for 10ns;
	Di <= x"00000000";
	wait for 10ns;
end process;
end;