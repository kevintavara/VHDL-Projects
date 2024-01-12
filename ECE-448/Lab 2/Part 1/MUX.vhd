library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MUX is
    Port( S : in STD_LOGIC;
          A, B : in STD_LOGIC_VECTOR(3 downto 0);
	  F : out STD_LOGIC_VECTOR(3 downto 0));
end MUX;

architecture Behavioral of MUX is
begin
    with S select 
	F <= A when '0',
	     B when '1',
	     A when others;
end Behavioral;