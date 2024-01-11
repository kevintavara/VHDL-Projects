library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity PCADD is
    Port (Din  : in  STD_LOGIC_VECTOR (31 downto 0);
          Dout : out  STD_LOGIC_VECTOR (31 downto 0) );
end PCADD; 

architecture Behavioral of PCADD is
signal temp : std_logic_vector (31 downto 0);

begin
temp <= x"00000004";
Dout <= Din + temp;
end Behavioral;