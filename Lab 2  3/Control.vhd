library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity Control is
    Port (Din  : in  STD_LOGIC_VECTOR (5 downto 0);
          Dout : out  STD_LOGIC);
end Control; 

architecture Behavioral of Control is
begin
   with Din select
   Dout <= '1' when "000000",
           '0' when others;
end Behavioral;