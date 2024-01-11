library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity Shift2 is
    Port (Din  : in  STD_LOGIC_VECTOR(31 downto 0);
          Dout : out  STD_LOGIC(31 downto 0));
end Shift2; 

architecture Behavioral of Shift2 is
begin
   Dout <= Din(29 downto 0)&"00";
end Behavioral;