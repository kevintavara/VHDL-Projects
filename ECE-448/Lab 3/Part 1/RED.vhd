library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RED is
   port (
      CLK, RST, DIN : in  STD_LOGIC;
      DOUT : out STD_LOGIC );
end RED;

architecture Behavioral of RED is
signal X, Y : STD_LOGIC;

begin
Process(CLK, RST)
begin

if(RST = '0') then 
	X <= '0';
	Y <= '0';
elsif rising_edge(CLK) then
	X  <= DIN;
	Y  <= X;
end if;
end process;

DOUT <= X and (not Y);

end Behavioral;