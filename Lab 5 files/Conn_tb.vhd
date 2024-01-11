library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Conn_tb is
end Conn_tb;

architecture Behavioral of Conn_tb is 
Component Conn   
    Port (A    : in   STD_LOGIC_VECTOR(27 downto 0);
	      B    : in   STD_LOGIC_VECTOR(31 downto 0);
          Dout : out  STD_LOGIC_VECTOR(31 downto 0));
end Component;

signal B1, F : std_logic_vector(31 DOWNTO 0);
signal A1 : std_logic_vector(27 DOWNTO 0);

begin
uut : Conn
   Port map(
	A => A1,
	B => B1,
	Dout => F);
	
Test : process
begin
	A1 <= "0001000000111100011110001111";
	B1 <= "11110001000000111100011110001111";
	wait for 10ns;
	A1 <= "0001000000000100011110001111";
	B1 <= "10110001000000111100011110001111";
	wait for 10ns;
	A1 <= "0001001000111100011110001111";
	B1 <= "01110001000000111100011110001111";
	wait for 10ns;
	A1 <= "1110000000111100011110001111";
	B1 <= "11100001000000111100011110001111";
	wait for 10ns;
end process;
end;