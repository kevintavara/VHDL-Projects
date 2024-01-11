library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC_tb is
end PC_tb;

architecture Behavioral of PC_tb is 
Component PC Port (
	Din              : in  STD_LOGIC_VECTOR (31 downto 0);
	clock, Reset : in STD_LOGIC;
        Dout             : out  STD_LOGIC_VECTOR (31 downto 0) );
end Component;

signal Clk, Rst : std_logic;
signal Din1, Dout1: std_logic_vector(31 DOWNTO 0);

begin
uut : PC
   Port map(
	Din => Din1,
	Dout => Dout1,
	clock => Clk,
	Reset => Rst);
	
Clock : process
begin
	Clk <= '0';
	Rst <= '1';
	Din1 <= x"00000001";
	wait for 10ns;
	Clk <= '1';
	Rst <='1';
	Din1 <= x"FFFFFFF1";
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	Din1 <= x"FFFFFFF1";
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	Din1 <= x"FFFFFFF1";
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	Din1 <= x"AAAAAAAA";
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	Din1 <= x"AAAAAAAA";
	wait for 10ns;
end process;
end;