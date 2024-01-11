library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux5b is
    Port( S : in STD_LOGIC_VECTOR (1 downto 0);
          A, B : in STD_LOGIC_VECTOR (4 downto 0);
	  F : out STD_LOGIC_VECTOR (4 downto 0)
);
end mux5b;

architecture Behavioral of mux5b is
begin
    with S select 
	F <= A 		when "00",
	     B 		when "01",
	     "11111" 	when "10",
	     A when others;
end Behavioral;