library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity GAND is
    Port (A, B  : in  STD_LOGIC;
          F : out  STD_LOGIC);
end GAND; 

architecture Behavioral of GAND is
begin
F <= A and B;
end Behavioral;