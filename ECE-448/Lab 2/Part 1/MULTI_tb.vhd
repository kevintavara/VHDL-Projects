library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MULTI_tb is
end MULTI_tb;

architecture Behavioral of MULTI_tb is 
  component MULTI_wrapper port (
    A : in STD_LOGIC_VECTOR ( 3 downto 0 );
    B : in STD_LOGIC_VECTOR ( 3 downto 0 );
    Q : out STD_LOGIC_VECTOR ( 7 downto 0 );
    Z : out STD_LOGIC_VECTOR ( 9 downto 0 )
  );
end component; 
signal A, B : std_logic_vector(3 DOWNTO 0):="0000";
signal Q : std_logic_vector(7 DOWNTO 0);
signal Z : std_logic_vector(9 DOWNTO 0);

begin
UUT : MULTI_wrapper
   Port map(
	A => A,
	B => B,
	Q => Q,
	Z => Z);
	
inputA: PROCESS
Begin
    wait for 10ns;
    A <= std_logic_vector(unsigned(A) + 1);
end process;	

inputB: PROCESS
Begin
    wait for 160ns;
    B <= std_logic_vector(unsigned(B) + 1);
end process;

end;