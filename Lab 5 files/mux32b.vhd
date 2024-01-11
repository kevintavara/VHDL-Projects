library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux32b is
    Port( S : in STD_LOGIC;
          A, B : in STD_LOGIC_VECTOR (31 downto 0);
	  F : out STD_LOGIC_VECTOR (31 downto 0)
);
end mux32b;

architecture Behavioral of mux32b is
begin
    with S select 
	F <= A when '0',
	     B when '1',
	     A when others;
end Behavioral;