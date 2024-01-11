library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity Conn is
    Port (A : in  STD_LOGIC_VECTOR(27 downto 0);
	      B : in  STD_LOGIC_VECTOR(31 downto 0);
          Dout : out  STD_LOGIC_VECTOR(31 downto 0));
end Conn; 

architecture Behavioral of Conn is
begin
   Dout <= B(31 downto 28)&A;
end Behavioral;