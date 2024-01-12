library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_tb is
end ALU_tb;

architecture Behavioral of ALU_tb is 
Component ALU Port (
	A, B : in STD_LOGIC_VECTOR(3 DOWNTO 0);
	OPCODE : in STD_LOGIC_VECTOR(2 DOWNTO 0);
	C, V : out STD_LOGIC; 
	X, Y : out STD_LOGIC_VECTOR(3 DOWNTO 0) );
end Component;

signal A : STD_LOGIC_VECTOR(3 DOWNTO 0):="0000";
signal B : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal OPCODE : STD_LOGIC_VECTOR(2 DOWNTO 0):="000";
signal C, V : STD_LOGIC;
signal X, Y : STD_LOGIC_VECTOR(3 DOWNTO 0);

Begin
UUT: ALU
Port Map (
	A => A,
	B => B,
	OPCODE => OPCODE,
	C => C,
	V => V,
	X => X,
	Y => Y );


testing1: PROCESS
Begin
    wait for 10ns;
    A <= std_logic_vector(unsigned(A) + 1);
end PROCESS;

opcode1: PROCESS
Begin
    wait for 20ns;
    OPCODE <= std_logic_vector(unsigned(OPCODE) + 1);
end PROCESS;

testing2: PROCESS
Begin
	B <= x"C";
	wait for 10ns;
	B <= x"4";
	wait for 10ns;
	B <= x"3";
	wait for 10ns;
	B <= x"A";
	wait for 10ns;
	B <= x"7";
	wait for 10ns;
	B <= x"9";
	wait for 10ns;
	B <= x"9";
	wait for 10ns;
	B <= x"A";
	wait for 10ns;
	B <= x"7";
	wait for 10ns;
	B <= x"8";
	wait for 10ns;
	B <= x"B";
	wait for 10ns;
	B <= x"D";
	wait for 10ns;
	B <= x"4";
	wait for 10ns;
	B <= x"2";
	wait for 10ns;
	B <= x"E";
	wait for 10ns;
	B <= x"F";
	wait for 10ns;
	
end PROCESS;
end;