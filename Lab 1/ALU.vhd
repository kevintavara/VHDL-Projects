library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is Port (
	A, B : in STD_LOGIC_VECTOR(31 DOWNTO 0);
	ALUCntl : in STD_LOGIC_VECTOR(3 DOWNTO 0);
	Carryin : in STD_LOGIC; 
	Zero, Overflow, Carryout : out STD_LOGIC;
	ALUout : out STD_LOGIC_VECTOR(31 DOWNTO 0) );
end ALU;

architecture Behavioral of ALU is 
signal temp : STD_LOGIC_VECTOR(32 DOWNTO 0);
begin 
with ALUCntl select temp <= 
	('0'&A) and ('0'&B) when "0000",
	('0'&A) or ('0'&B)  when "0001",
	('0'&A) xor ('0'&B) when "0011",
	('0'&A) + ('0'&B) + ("00000000000000000000000000000000"&Carryin)   when "0010",
	('0'&A) - ('0'&B)   when "0110",
	('0'&A) nor ('0'&B) when "1100",
	"000000000000000000000000000000000" when others;
ALUout <= temp(31 DOWNTO 0);
Carryout <= temp(32);
with temp select Zero <= 
	'1' when "000000000000000000000000000000000",
	'0' when others;
with ALUCntl select Overflow <= 
	(A(31) and B(31) and not(temp(31))) or (not(A(31)) and not(B(31)) and temp(31)) when "0010",
	(A(31) and not(B(31)) and not(temp(31))) or (not(A(31)) and B(31) and temp(31)) when "0110",
	'0' when others;
end Behavioral;