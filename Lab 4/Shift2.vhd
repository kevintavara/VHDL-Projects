library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity Shift2 is
    Port (Din  : in  STD_LOGIC_VECTOR(9 downto 0);
	  Q    : out  STD_LOGIC(7 downto 0);
          Dout : out  STD_LOGIC(9 downto 0));
end Shift2; 

architecture Behavioral of Shift2 is
begin
   Dout <= "00"&Din(9 downto 2);
   Q <= Din(9 downto 2);
end Behavioral;