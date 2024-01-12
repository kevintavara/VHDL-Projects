library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ADDA0 is
    Port (B  : in  STD_LOGIC_VECTOR(3 downto 0);
          Dout  : out  STD_LOGIC_VECTOR(3 downto 0) );
end ADDA0; 

architecture Behavioral of ADDA0 is
signal S1 : STD_LOGIC_VECTOR(3 downto 0);
begin
	S1 <= not(B);
	Dout <= STD_LOGIC_VECTOR(unsigned(S1) + "0001");
end Behavioral;