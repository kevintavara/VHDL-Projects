library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUXN is
    Generic(N : INTEGER := 8);
    Port( LD : in STD_LOGIC;
          A, B : in STD_LOGIC_VECTOR(N-1 downto 0);
	  F : out STD_LOGIC_VECTOR(N-1 downto 0));
end MUXN;

architecture Behavioral of MUXN is
begin
    with LD select 
	F <= A when '0',
	     B when '1',
	     A when others;
end Behavioral;