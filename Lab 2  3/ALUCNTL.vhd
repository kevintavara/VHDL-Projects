library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity ALUCNTL is
    Port (Din  : in  STD_LOGIC_VECTOR (5 downto 0);
          Dout : out  STD_LOGIC_VECTOR (3 downto 0) );
end ALUCNTL; 

architecture Behavioral of ALUCNTL is
begin
   with Din select
   Dout <= "0010" when "100000", --Add
	   "0010" when "100001", --Addu
           "0110" when "100010", --sub
	   "0110" when "100011", --subu
           "0000" when "100100", --and
           "0001" when "100101", --or
           "0011" when "100110", --xor
           "1100" when "100111", --nor
	   "0111" when "101010", --slt
           "0111" when "101011", --sltu
           "1111" when others;
end Behavioral;