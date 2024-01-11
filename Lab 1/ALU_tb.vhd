library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_tb is
end ALU_tb;

architecture Behavioral of ALU_tb is 
Component ALU Port (
	A, B : in STD_LOGIC_VECTOR(31 DOWNTO 0);
	ALUCntl : in STD_LOGIC_VECTOR(3 DOWNTO 0);
	Carryin : in STD_LOGIC; 
	Zero, Overflow, Carryout : out STD_LOGIC;
	ALUout : out STD_LOGIC_VECTOR(31 DOWNTO 0) );
end Component;

signal At, Bt : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal ALUCntlt : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal Carryint : STD_LOGIC; 
signal Zerot, Overflowt, Carryoutt : STD_LOGIC;
signal ALUoutt : STD_LOGIC_VECTOR(31 DOWNTO 0);

Begin
UUT: ALU
Port Map (
	A => At,
	B => Bt,
	ALUCntl => ALUCntlt,
	Carryin => Carryint,
	Zero => Zerot,
	Overflow => Overflowt,
	Carryout => Carryoutt,
	ALUout => ALUoutt );

testing: PROCESS
Begin
	At <= x"FFFFFFFF";
	Bt <= x"00000000";
	ALUCntlt <= "0000";
	wait for 10ns;
	At <= x"98989898";
	Bt <= x"89898989";
	ALUCntlt <= "0001";
	wait for 10ns;
	At <= x"01010101";
	Bt <= x"10101010";
	ALUCntlt <= "0011";
	wait for 10ns;
	At <= x"00000001";
	Bt <= x"FFFFFFFF";
	Carryint <= '0';
	ALUCntlt <= "0010";
	wait for 10ns;
	At <= x"6389754F";
	Bt <= x"AD5624E6";
	Carryint <= '0';
	ALUCntlt <= "0010";
	wait for 10ns;
	At <= x"00000001";
	Bt <= x"FFFFFFFF";
	Carryint <= '1';
	ALUCntlt <= "0010";
	wait for 10ns;
	At <= x"6389754F";
	Bt <= x"AD5624E6";
	Carryint <= '1';
	ALUCntlt <= "0010";
	wait for 10ns;
	At <= x"FFFFFFFF";
	Bt <= x"FFFFFFFF";
	Carryint <= '1';
	ALUCntlt <= "0010";
	wait for 10ns;
	At <= x"00000000";
	Bt <= x"00000001";
	ALUCntlt <= "0110";
	wait for 10ns;
	At <= x"F9684783";
	Bt <= x"F998D562";
	ALUCntlt <= "0110";
	wait for 10ns;
	At <= x"9ABCDEDF";
	Bt <= x"9ABCDEFD";
	ALUCntlt <= "1100";
	wait for 10ns;
	At <= x"89BCDE34";
	Bt <= x"C53BD687";
	ALUCntlt <= "1111";
	wait for 10ns;
end PROCESS;
end;