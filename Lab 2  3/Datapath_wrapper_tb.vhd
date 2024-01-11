library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SignExt_tb is
end SignExt_tb;

architecture Behavioral of SignExt_tb is 
Component SignExt     
    Port (Din  : in  STD_LOGIC_VECTOR(15 downto 0);
          Dout : out  STD_LOGIC(31 downto 0));
end Component;

signal Di : std_logic(15 DOWNTO 0);
signal Do : std_logic_vector(31 DOWNTO 0);

begin
uut : SignExt
   Port map(
	Din => Di,
	Dout => Do);
	
Test : process
begin
	Di <= x"1234";
	wait for 10ns;
	Di <= x"000F";
	wait for 10ns;
	Di <= x"F000";
	wait for 10ns;
	Di <= x"0000";
	wait for 10ns;
end process;
end;
	