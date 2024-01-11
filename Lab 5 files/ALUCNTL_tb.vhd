library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALUCNTL_tb is
end ALUCNTL_tb;

architecture Behavioral of ALUCNTL_tb is 
Component ALUCNTL Port (
	Din              : in  STD_LOGIC_VECTOR (5 downto 0);
	Op   		 : in  STD_LOGIC_VECTOR (5 downto 0);
        Dout             : out STD_LOGIC_VECTOR (3 downto 0) );
end Component;

signal Din1, O1  : std_logic_vector(5 DOWNTO 0);
signal Dout1 : std_logic_vector(3 DOWNTO 0);

begin
uut : ALUCNTL
   Port map(
	Din  => Din1,
	Op   => O1,
	Dout => Dout1);
	
Clock : process
begin
	Din1 <= "100000";
	O1   <= "000000";
	wait for 10ns;
	Din1 <= "100001";
	O1   <= "000000";
	wait for 10ns;
	Din1 <= "111111";
	O1   <= "000000";
	wait for 10ns;
	Din1 <= "100011";
	O1   <= "000001";
	wait for 10ns;
	Din1 <= "100111";
	O1   <= "000010";
	wait for 10ns;
	Din1 <= "111111";
	O1   <= "111111";
	wait for 10ns;
end process;
end;