library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_tb is
end Control_tb;

architecture Behavioral of Control_tb is 
Component Control Port (
	Din              : in  STD_LOGIC_VECTOR (5 downto 0);
        Dout             : out  STD_LOGIC);
end Component;

signal Din1  : std_logic_vector(5 DOWNTO 0);
signal Dout1 : std_logic;

begin
uut : Control
   Port map(
	Din => Din1,
	Dout => Dout1);
	
Clock : process
begin
	Din1 <= "000000";
	wait for 10ns;
	Din1 <= "000001";
	wait for 10ns;
	Din1 <= "111111";
	wait for 10ns;
end process;
end;