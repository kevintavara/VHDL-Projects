library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_tb is
end Control_tb;

architecture Behavioral of Control_tb is 
Component Control Port (
	Din  : in  STD_LOGIC_VECTOR(5 downto 0);
        Rd, B, Mr, Mtr, Mw, S, Rw : out  STD_LOGIC;
	Op : out STD_LOGIC_VECTOR(5 downto 0) );
end Component;

signal D1, O1  : std_logic_vector(5 DOWNTO 0);
signal Rd1, B1, Mr1, Mtr1, Mw1, S1, Rw1 : std_logic;

begin
uut : ALUCNTL
   Port map(
	Din => D1,
	Rd  => Rd1,
	B   => B1,
	Mr  => Mr1,
	Mtr => Mtr1,
	Mw  => Mw1,
	S   => S1,
	Rw  => Rw1,
	Op  => O1);
	
Clock : process
begin
	D1 <= "000000";
	wait for 10ns;
	D1 <= "001000";
	wait for 10ns;
	D1 <= "001010";
	wait for 10ns;
	D1 <= "100011";
	wait for 10ns;
end process;
end;