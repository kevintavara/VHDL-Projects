library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PISO_tb is
  Generic(N : INTEGER := 16);
end PISO_tb;

architecture Behavioral of PISO_tb is 
  component PISO16_wrapper port (
    Clock : in STD_LOGIC;
    D0 : in STD_LOGIC_VECTOR ( N-1 downto 0 );
    D1 : in STD_LOGIC_VECTOR ( N-1 downto 0 );
    D2 : in STD_LOGIC_VECTOR ( N-1 downto 0 );
    D3 : in STD_LOGIC_VECTOR ( N-1 downto 0 );
    En : in STD_LOGIC;
    LD : in STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( N-1 downto 0 );
    Reset : in STD_LOGIC
  );
end component;
signal Clk, Rst, En, Ld : std_logic; 
signal D0, D1, D2, D3, Q : std_logic_vector(N -1 DOWNTO 0);

begin
UUT : PISO16_wrapper
   Port map(
	D0 => D0,
	D1 => D1,
	D2 => D2,
	D3 => D3,
	En => En,
	Reset => Rst,
	LD => Ld,
	Q => Q,
	Clock => Clk);
	
Test : process
begin
    Clk <= '0';
	Rst <= '1';
	En  <= '1';
	Ld  <= '1';
	D0  <= x"0001";
	D1  <= x"0002";
	D2  <= x"0003";
	D3  <= x"0004";
	wait for 10ns;
	Clk <= '1';
	Rst <='1';
	En  <= '1';
	Ld  <= '1';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	En  <= '0';
	Ld  <= '1';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	En  <= '0';
	Ld  <= '1';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	En  <= '1';
	Ld  <= '1';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	Ld <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	
    D0  <= x"0005";
	D1  <= x"0006";
	D2  <= x"0007";
	D3  <= x"0008";
	Clk <= '0';
	Rst <= '0';
	En  <= '1';
	Ld  <= '1';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	Ld <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	
	D0  <= x"0009";
	D1  <= x"000A";
	D2  <= x"000B";
	D3  <= x"000C";
	Clk <= '0';
	Rst <= '0';
	En  <= '1';
	Ld  <= '1';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	Ld <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	
    D0  <= x"000D";
	D1  <= x"000E";
	D2  <= x"000F";
	D3  <= x"0010";
	Clk <= '0';
	Rst <= '0';
	En  <= '1';
	Ld  <= '1';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	Ld <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
	Clk <= '0';
	Rst <= '0';
	wait for 10ns;
	Clk <= '1';
	Rst <='0';
	wait for 10ns;
end process;
end;