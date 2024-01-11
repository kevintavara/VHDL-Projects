library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PCADD_tb is
end PCADD_tb;

architecture Behavioral of PCADD_tb is 
Component PCADD Port (
	Din              : in  STD_LOGIC_VECTOR (31 downto 0);
        Dout             : out  STD_LOGIC_VECTOR (31 downto 0) );
end Component;

signal Din1, Dout1: std_logic_vector(31 DOWNTO 0);

begin
uut : PCADD
   Port map(
	Din => Din1,
	Dout => Dout1);
	
Clock : process
begin
	Din1 <= x"00000000";
	wait for 10ns;
	Din1 <= x"00000004";
	wait for 10ns;
	Din1 <= x"FFFFFFF8";
	wait for 10ns;
end process;
end;