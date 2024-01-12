library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity REGN is
	Generic(N : INTEGER := 8);
	Port( D 	       : in STD_LOGIC_VECTOR(N-1 downto 0);
	      Reset, Clock, En : in STD_LOGIC;
	      Q 	       : out STD_LOGIC_VECTOR(N-1 downto 0) );
end REGN;

architecture Behavioral of REGN is
begin

process(Reset, Clock, En)
begin

if (Reset = '1' or En = '0') then Q <= (others => '0'); 
elsif (rising_edge(Clock) and En = '1') then Q <= D; end if;

end process;
end behavioral;