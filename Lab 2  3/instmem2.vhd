library IEEE;

use IEEE.STD_LOGIC_1164.ALL;

USE ieee.std_logic_arith.all;

USE ieee.std_logic_unsigned.all;



-- Uncomment the following library declaration if using

-- arithmetic functions with Signed or Unsigned values

--use IEEE.NUMERIC_STD.ALL;



-- Uncomment the following library declaration if instantiating

-- any Xilinx primitives in this code.

--library UNISIM;

--use UNISIM.VComponents.all;



entity instmem is

    Port ( read_inst : in  STD_LOGIC_VECTOR (31 downto 0);

           inst_out : out  STD_LOGIC_VECTOR (31 downto 0));

end instmem;



architecture Behavioral of instmem is

type instmem is array (0 to 51) of std_logic_vector (7 downto 0);

signal RAM: instmem:=(x"01",x"28",x"00",x"22",-- 3  1:  sub $zero, $t0, $t1

                      x"00",x"00",x"08",x"20",-- 7  2:  add $at, $zero, $zero

                      x"00",x"20",x"10",x"20",--11  3:  add $v0, $at, $zero

                      x"00",x"42",x"18",x"20",--15  4:  add $v1, $v0, $v0

                      x"00",x"62",x"20",x"20",--19  5:  add $a0, $v1, $v0

                      x"00",x"84",x"28",x"20",--23  6:  add $a1, $a0, $a0

                      x"00",x"a4",x"30",x"20",--27  7:  add $a2, $a1, $a0

                      x"00",x"c6",x"38",x"20",--31  8:  add $a3, $a2, $a2

                      x"00",x"e6",x"40",x"20",--35  9:  add $t0, $a3, $a2

                      x"00",x"00",x"00",x"00",--39  

                      x"00",x"00",x"00",x"00",--43

                      x"00",x"00",x"00",x"00",--47

                      x"00",x"00",x"00",x"00" );--51

begin

inst_out(7 downto 0)<= RAM(conv_integer(unsigned(read_inst+3))) ;

inst_out(15 downto 8)<= RAM(conv_integer(unsigned(read_inst+2))); 

inst_out(23 downto 16)<= RAM(conv_integer(unsigned(read_inst+1)));

inst_out(31 downto 24)<= RAM(conv_integer(unsigned(read_inst)));



end Behavioral;