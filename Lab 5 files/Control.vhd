library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity Control is
    Port (Din, Jr  : in  STD_LOGIC_VECTOR(5 downto 0);
	  Rd, Mtr, J : out STD_LOGIC_VECTOR(1 downto 0);
          B, Mr, Mw, S, Rw : out  STD_LOGIC;
	  Op : out STD_LOGIC_VECTOR(5 downto 0) );
end Control; 

architecture Behavioral of Control is
signal temp, temp1 : STD_LOGIC_VECTOR(16 downto 0);
begin
   with Din select
   temp1 <= "00010000001000000"  when "000000", --rtype
	   "01100000000000000"	when "000010", --j
	   "01000010000000000"	when "000011", --jal
	   "00000000011000001"  when "001000", --addi
	   "00000000011000001"  when "001001", --addiu
	   "00000000011000010"  when "001100", --andi
	   "00000000011000011"  when "001101", --ori
	   "00000101011000100"  when "100011", --lw
	   "00000000110000101"  when "101011", --sw
	   "00001000000000110"  when "000100", --beq
	   "00001000000000111"  when "000101", --bne
           "00000000011001000"  when "001010", --slti
	   "00000000011001000"  when "001011", --sltiu
           "00000000000000000"  when others;
   temp <=  "10000000000000000"  when (Jr = "001000" and Din = "000000")
   else temp1;
J <= temp(16 downto 15);
Rd <= temp(14 downto 13);
B <= temp(12);
Mr <= temp(11);
Mtr <= temp(10 downto 9);
Mw <= temp(8);
S <= temp(7);
Rw <= temp(6);
Op <= temp(5 downto 0);
end Behavioral;