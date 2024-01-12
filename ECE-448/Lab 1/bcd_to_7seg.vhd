library ieee;
use ieee.std_logic_1164.all;

entity bcd_to_7seg is
    port (
        bcd: in std_logic_vector(3 downto 0);
        seven_seg: out std_logic_vector(6 downto 0)
    );
end;

architecture rtl of bcd_to_7seg is
begin
    with bcd select seven_seg <=
        "0111111" when x"0",
        "0000110" when x"1",
        "1011011" when x"2",
        "1001111" when x"3",
        "1100110" when x"4",
        "1101101" when x"5",
        "1111101" when x"6",
        "0000111" when x"7",
        "1111111" when x"8",
        "1101111" when x"9",
        "0000000" when others;
end;