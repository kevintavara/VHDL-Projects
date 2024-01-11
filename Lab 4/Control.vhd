library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity Control is
    Port (Din  : in  STD_LOGIC_VECTOR(5 downto 0);
          Rd, B, Mr, Mtr, Mw, S, Rw : out  STD_LOGIC;
	  Op : out STD_LOGIC_VECTOR(5 downto 0) );
end Control; 

architecture Behavioral of Control is
signal temp : STD_LOGIC_VECTOR(12 downto 0);
begin
   with Din select
   temp <= "1000001000000"  when "000000", --rtype
	   "0000011000001"  when "001000", --addi
	   "0000011000001"  when "001001", --addiu
	   "0000011000010"  when "001100", --andi
	   "0000011000011"  when "001101", --ori
	   "0011011000100"  when "100011", --lw
	   "0000110000101"  when "101011", --sw
	   "0100000000110"  when "000100", --beq
	   "0100000000111"  when "000101", --bne
           "0000011001000"  when "001010", --slti
	   "0000011001000"  when "001011", --sltiu
           "0000000000000" when others;
Rd <= temp(12);
B <= temp(11);
Mr <= temp(10);
Mtr <= temp(9);
Mw <= temp(8);
S <= temp(7);
Rw <= temp(6);
Op <= temp(5 downto 0);
end Behavioral;