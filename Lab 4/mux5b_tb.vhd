library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux5b_tb is
end mux5b_tb;

architecture Behavioral of mux5b_tb is 
Component mux5b Port (
    	  A, B  : in  STD_LOGIC_VECTOR (4 downto 0);
	  S     : in  STD_LOGIC;
          F     : out STD_LOGIC_VECTOR (4 downto 0) );
end Component;

signal A1, B1, D1: std_logic_vector(4 DOWNTO 0);
signal S1: std_logic;
begin
uut : mux5b
   Port map(
	A => A1,
	B => B1,
	S => S1,
	F => D1);
	
Clock : process
begin
	A1 <= "00100";
	B1 <= "10000";
	S1  <= '0';
	wait for 10ns;
	A1 <= "00000";
	B1 <= "00001";
	S1  <= '0';
	wait for 10ns;
	A1 <= "11111";
	B1 <= "00100";
	S1  <= '1';
	wait for 10ns;
end process;
end;