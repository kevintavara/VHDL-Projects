library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ROM5 is
    Port (Addr1  : in  STD_LOGIC_VECTOR(3 downto 0);
	      Addr2  : in  STD_LOGIC_VECTOR(4 downto 0);
          Dout1  : out  STD_LOGIC_VECTOR(7 downto 0);
	      Dout2  : out  STD_LOGIC_VECTOR(9 downto 0));
end ROM5; 

architecture Behavioral of ROM5 is
signal S : STD_LOGIC_VECTOR(11 downto 0);
type rom_array1 is array (0 to 15) of std_logic_vector(7 downto 0);
signal rom1: rom_array1 := (
	x"00", x"01", x"04", x"09", 
	x"10", x"19", x"24", x"31", 
	x"40", x"51", x"64", x"79", 
	x"90", x"A9", x"C4", x"E1");
type rom_array2 is array (0 to 31) of std_logic_vector(11 downto 0);
signal rom2: rom_array2 := (
	x"000", x"001", x"004", x"009", 
	x"010", x"019", x"024", x"031", 
	x"040", x"051", x"064", x"079", 
	x"090", x"0A9", x"0C4", x"0E1",
	x"100", x"121", x"144", x"169", 
	x"190", x"1B9", x"1E4", x"211", 
	x"240", x"271", x"2A4", x"2D9", 
	x"310", x"349", x"384", x"3C1");
begin
	Dout1 <= rom1(conv_integer(Addr1));
	S <= rom2(conv_integer(Addr2));
	Dout2 <= S(9 downto 0);
end Behavioral;