--========================================================================
---ECE445 Spring 2014
---Instruction Memeory containing the test program for jump instructions
---=======================================================================
--------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

entity instmem is
    Port ( read_inst : in  STD_LOGIC_VECTOR (31 downto 0);
           inst_out : out  STD_LOGIC_VECTOR (31 downto 0));
end instmem;

architecture Behavioral of instmem is 
signal a1,a2,a3,a4:std_logic_vector(7 downto 0);
type instmem is array (0 to (64*4-1) ) of std_logic_vector (7 downto 0);
signal RAM: instmem:=(
							x"20",x"08",x"00",x"01",-- 0x00: addi    $t0,   $zero,    1   --Main
							x"0c",x"00",x"00",x"05",-- 0x04: jal     Even                 --loop
							x"12",x"00",x"00",x"05",-- 0x08: beq     $s0,   $zero,   Odd
							x"01",x"28",x"40",x"20",-- 0x0C: add     $t0,    $t1,    $t0
							x"08",x"00",x"00",x"01",-- 0x10: j       loop		
							x"31",x"10",x"00",x"01",-- 0x14: andi    $s0,    $t0,     1   --Even
							x"2a",x"10",x"00",x"01",-- 0x18: slti    $s0,    $s0,     1
							x"03",x"e0",x"00",x"08",-- 0x1C: jr      $ra
							x"01",x"00",x"48",x"20",-- 0x20: add     $t1,    $t0,    $zero --Odd
							x"01",x"29",x"40",x"20",-- 0x24: add     $t0,    $t1,    $t1	
							x"08",x"00",x"00",x"01",-- 0x28: j       loop	
							x"00",x"00",x"00",x"00",-- 0x2C: 
							x"00",x"00",x"00",x"00",-- 0x30: 
							x"00",x"00",x"00",x"00",-- 0x34: 
							x"00",x"00",x"00",x"00",-- 0x38: 
							x"00",x"00",x"00",x"00",-- 0x3C: 
							x"00",x"00",x"00",x"00",-- 0x40: 
							x"00",x"00",x"00",x"00",-- 0x44: 
							x"00",x"00",x"00",x"00",-- 0x48: (empty location)
							x"00",x"00",x"00",x"00",-- 0x4C: (empty location)
							x"00",x"00",x"00",x"00",-- 0x50: (empty location)
							x"00",x"00",x"00",x"00",-- 0x54: (empty location)
							x"00",x"00",x"00",x"00",-- 0x58: (empty location)
							x"00",x"00",x"00",x"00",-- 0x5C: (empty location)
							x"00",x"00",x"00",x"00",-- 0x60: (empty location)
							x"00",x"00",x"00",x"00",-- 0x64: (empty location)
							x"00",x"00",x"00",x"00",-- 0x68: (empty location)
							x"00",x"00",x"00",x"00",-- 0x6C: (empty location)
							x"00",x"00",x"00",x"00",-- 0x70: (empty location)
							x"00",x"00",x"00",x"00",-- 0x74: (empty location)
							x"00",x"00",x"00",x"00",-- 0x78: (empty location)
							x"00",x"00",x"00",x"00",-- 0x7C: (empty location)
							x"00",x"00",x"00",x"00",-- 0x80: (empty location)
							x"00",x"00",x"00",x"00",-- 0x84: (empty location)
							x"00",x"00",x"00",x"00",-- 0x88: (empty location)
							x"00",x"00",x"00",x"00",-- 0x8C: (empty location)
							x"00",x"00",x"00",x"00",-- 0x90: (empty location)
							x"00",x"00",x"00",x"00",-- 0x94: (empty location)
							x"00",x"00",x"00",x"00",-- 0x98: (empty location)
							x"00",x"00",x"00",x"00",-- 0x9C: (empty location)
							x"00",x"00",x"00",x"00",-- 0xA0: (empty location)
							x"00",x"00",x"00",x"00",-- 0xA4: (empty location)
							x"00",x"00",x"00",x"00",-- 0xA8: (empty location)
							x"00",x"00",x"00",x"00",-- 0xAC: (empty location)
							x"00",x"00",x"00",x"00",-- 0xB0: (empty location)
							x"00",x"00",x"00",x"00",-- 0xB4: (empty location)
							x"00",x"00",x"00",x"00",-- 0xB8: (empty location)
							x"00",x"00",x"00",x"00",-- 0xBC: (empty location)
							x"00",x"00",x"00",x"00",-- 0xC0: (empty location)
							x"00",x"00",x"00",x"00",-- 0xC4: (empty location)
							x"00",x"00",x"00",x"00",-- 0xC8: (empty location)
							x"00",x"00",x"00",x"00",-- 0xCC: (empty location)
							x"00",x"00",x"00",x"00",-- 0xD0: (empty location)
							x"00",x"00",x"00",x"00",-- 0xD4: (empty location)
							x"00",x"00",x"00",x"00",-- 0xD8: (empty location)
							x"00",x"00",x"00",x"00",-- 0xDC: (empty location)
							x"00",x"00",x"00",x"00",-- 0xE0: (empty location)
							x"00",x"00",x"00",x"00",-- 0xE4: (empty location)
							x"00",x"00",x"00",x"00",-- 0xE8: (empty location)
							x"00",x"00",x"00",x"00",-- 0xEC: (empty location)
							x"00",x"00",x"00",x"00",-- 0xF0: (empty location)
							x"00",x"00",x"00",x"00",-- 0xF4: (empty location)
							x"00",x"00",x"00",x"00",-- 0xF8: (empty location)
							x"00",x"00",x"00",x"00" -- 0xFF: (empty location)--255
							);	
begin	
	a1<=read_inst(7 downto 0);
	a2<=read_inst(7 downto 0)+1;
	a3<=read_inst(7 downto 0)+2;
	a4<=read_inst(7 downto 0)+3;
inst_out(7 downto 0)  <= RAM(conv_integer(unsigned(a4)));
inst_out(15 downto 8) <= RAM(conv_integer(unsigned(a3)));
inst_out(23 downto 16)<= RAM(conv_integer(unsigned(a2)));
inst_out(31 downto 24)<= RAM(conv_integer(unsigned(a1)));
end Behavioral;