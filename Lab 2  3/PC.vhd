library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PC is 
	Port (Din          : in  STD_LOGIC_VECTOR (31 downto 0);
	      clock, Reset : in STD_LOGIC;
          Dout         : out  STD_LOGIC_VECTOR (31 downto 0) );
end PC;

architecture Behavioral of PC is

begin
process(clock, Reset)
begin
if Reset = '1' then
    Dout <= x"00000000";
elsif clock'event and clock = '1' then
    Dout <= Din;
end if;
end process;
end Behavioral;