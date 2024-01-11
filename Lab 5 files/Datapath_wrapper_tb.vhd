library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Datapath_tb is
end Datapath_tb;

architecture Behavioral of Datapath_tb is 
Component Datapath_wrapper Port (
	clock : in STD_LOGIC;
	Reset : in STD_LOGIC;
	Zero, Overflow, Carryout : out STD_LOGIC);
end Component;

signal Clk, Rst, Z, O, C : std_logic;

begin
uut : Datapath_wrapper
   Port map(
	Zero => Z,
	Overflow => O,
	Carryout => C,
	clock => Clk,
	Reset => Rst);
	
Clock : process
begin
	Clk <= '0';
	Rst <= '1';
	wait for 10ns;
	Clk <= '1';
	Rst <='1';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns; --5
	Clk <= '0'; 
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns; --15
	Clk <= '0'; 
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns; --25
	Clk <= '0'; 
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
end process;
end;
	