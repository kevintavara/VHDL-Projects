library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity ROM4 is
    Port (Addr  : in  STD_LOGIC_VECTOR(3 downto 0);
          Dout  : out  STD_LOGIC_VECTOR(7 downto 0) );
end ROM4; 

architecture Behavioral of ROM4 is
type rom_type is array (0 to 15) of std_logic_vector(7 downto 0);
signal rom: rom_type := (
	x"00", x"01", x"04", x"09", 
	x"10", x"19", x"24", x"31", 
	x"40", x"51", x"64", x"79", 
	x"90", x"A9", x"C4", x"E1");
begin
	Dout <= rom(conv_integer(Addr));
end Behavioral;