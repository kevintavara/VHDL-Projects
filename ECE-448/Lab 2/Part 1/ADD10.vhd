library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ADD10 is
    Port (A     : in  STD_LOGIC_VECTOR(9 downto 0);
	      B     : in  STD_LOGIC_VECTOR(7 downto 0);
          Dout  : out  STD_LOGIC_VECTOR(9 downto 0) );
end ADD10; 

architecture Behavioral of ADD10 is
signal B1 : STD_LOGIC_VECTOR(9 downto 0);
begin
	B1 <= STD_LOGIC_VECTOR("11"&(not(B)));
	Dout <= STD_LOGIC_VECTOR(unsigned(A) + unsigned(B1) + "0000000001");
end Behavioral;