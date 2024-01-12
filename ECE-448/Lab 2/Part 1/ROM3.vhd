library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity ROM3 is
    Port (Addr  : in  STD_LOGIC_VECTOR(4 downto 0);
          Dout  : out  STD_LOGIC_VECTOR(9 downto 0) );
end ROM3; 

architecture Behavioral of ROM3 is
signal S : STD_LOGIC_VECTOR(11 downto 0);
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
	S <= rom2(conv_integer(Addr));
	Dout <= S(9 downto 0);
end Behavioral;