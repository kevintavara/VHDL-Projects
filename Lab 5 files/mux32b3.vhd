library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux32b3 is
    Port( S : in STD_LOGIC_VECTOR (1 downto 0);
          A, B, C : in STD_LOGIC_VECTOR (31 downto 0);
	  F : out STD_LOGIC_VECTOR (31 downto 0)
);
end mux32b3;

architecture Behavioral of mux32b3 is
begin
    with S select 
	F <= A when "00",
	     B when "01",
	     C when "10",
	     A when others;
end Behavioral;