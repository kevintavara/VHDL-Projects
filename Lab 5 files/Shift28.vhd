library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity Shift28 is
    Port (Din  : in  STD_LOGIC_VECTOR(25 downto 0);
          Dout : out  STD_LOGIC_VECTOR(27 downto 0));
end Shift28; 

architecture Behavioral of Shift28 is
begin
   Dout <= Din&"00";
end Behavioral;