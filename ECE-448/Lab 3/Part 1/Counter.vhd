library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Counter is
   port (CLK, UP, DOWN, RST: in STD_LOGIC;
	 DOUT: out STD_LOGIC_VECTOR(0 DOWNTO 15);

end Counter;

architecture Behavioral of Counter is
variable value: integer range 0 to 15;

begin
process (CLK, RST)
begin

if RST = '1' then
	value := 0;
elsif (CLK'event and CLK = '1') then
	if count = '1' then

	if down = '0' then

value := value + 1;

else

value := value - 1;

end if;
end if;
end if;

DOUT <= STD_LOGIC_VECTOR(signed(value));

end process;

end behav;