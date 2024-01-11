library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity ADD is
    Port (A, B  : in  STD_LOGIC_VECTOR (31 downto 0);
          Dout : out  STD_LOGIC_VECTOR (31 downto 0) );
end ADD; 

architecture Behavioral of ADD is

begin
Dout <= A + B;
end Behavioral;