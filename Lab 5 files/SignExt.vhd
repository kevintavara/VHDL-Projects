library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity SignExt is
    Port (Din  : in  STD_LOGIC_VECTOR(15 downto 0);
          Dout : out  STD_LOGIC(31 downto 0));
end SignExt; 

architecture Behavioral of SignExt is
begin
   Dout <= Din(15 downto 12)&Din(15 downto 12)&Din(15 downto 12)&Din(15 downto 12)&Din(15 downto 12)&Din(11 downto 0);
end Behavioral;