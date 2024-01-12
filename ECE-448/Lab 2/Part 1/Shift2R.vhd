library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Shift2R is
    Port (Din  : in  STD_LOGIC_VECTOR(9 downto 0);
	      Q    : out  STD_LOGIC_VECTOR(7 downto 0);
          Z    : out  STD_LOGIC_VECTOR(9 downto 0));
end Shift2R; 

architecture Behavioral of Shift2R is
begin
   Z <= "00"&Din(9 downto 2);
   Q <= Din(9 downto 2);
end Behavioral;