library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Shift28_tb is
end Shift28_tb;

architecture Behavioral of Shift28_tb is 
Component Shift28     
    Port (Din  : in   STD_LOGIC_VECTOR(25 downto 0);
          Dout : out  STD_LOGIC_VECTOR(27 downto 0));
end Component;

signal Di : std_logic_vector(25 DOWNTO 0);
signal Do : std_logic_vector(27 DOWNTO 0);

begin
uut : Shift28
   Port map(
	Din => Di,
	Dout => Do);
	
Test : process
begin
	Di <= "01000000111100011110001111";
	wait for 10ns;
	Di <= "01000000000100011110001111";
	wait for 10ns;
	Di <= "01001000111100011110001111";
	wait for 10ns;
	Di <= "11100000111100011110001111";
	wait for 10ns;
end process;
end;