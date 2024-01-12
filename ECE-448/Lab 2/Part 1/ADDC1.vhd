library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ADDC1 is
    Port (A, B  : in  STD_LOGIC_VECTOR(3 downto 0);
	  Cout  : out STD_LOGIC;
          Dout  : out  STD_LOGIC_VECTOR(3 downto 0) );
end ADDC1; 

architecture Behavioral of ADDC1 is
signal S : STD_LOGIC_VECTOR(4 downto 0);
signal S1 : STD_LOGIC_VECTOR(3 downto 0);
begin
	S1 <= not(B);
	S <= STD_LOGIC_VECTOR(unsigned('0'&A) + unsigned('0'&S1) + "00001");
	Cout <= S(4);
	Dout <= S(3 downto 0);
end Behavioral;