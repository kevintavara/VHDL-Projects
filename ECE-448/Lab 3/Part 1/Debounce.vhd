library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Debounce is
   port (
      CLK, RST, DIN : in  STD_LOGIC;
      DOUT : out STD_LOGIC );
end Debounce;
 
architecture Behavioral of Debounce is
Signal X, Y, Z: STD_LOGIC;
 
begin
Process(CLK,RST)
begin

if(RST = '0') then 
	X <= '0';
	Y <= '0';
	Z <= '0';
elsif rising_edge(CLK) then
	X <= DIN;
	Y <= X;
	Z <= Y;
end if;
end process;
 
DOUT <= X and Y and Z;
 
end Behavioral;