library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ADDC0 is
    Port (A, B  : in  STD_LOGIC_VECTOR(3 downto 0);
          Dout  : out  STD_LOGIC_VECTOR(4 downto 0) );
end ADDC0; 

architecture Behavioral of ADDC0 is
signal S : STD_LOGIC_VECTOR(4 downto 0);
begin
	S <= STD_LOGIC_VECTOR(unsigned('0'&A) + unsigned('0'&B));
	Dout <= S;
end Behavioral;