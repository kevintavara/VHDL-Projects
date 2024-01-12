library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.MATH_REAL.ALL;

entity Lab1_tb is
end Lab1_tb;

architecture Behavioral of Lab1_tb is 
Component Lab1 Port (
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    A : in STD_LOGIC_VECTOR ( 5 downto 0 );
    B : in STD_LOGIC_VECTOR ( 2 downto 0 );
    start : in STD_LOGIC;
    Mode : in STD_LOGIC;
    Y : out STD_LOGIC_VECTOR ( 5 downto 0 );
    Z : out STD_LOGIC;
    done : out STD_LOGIC );
end Component;

signal A, Y : STD_LOGIC_VECTOR(5 DOWNTO 0);
signal B : STD_LOGIC_VECTOR(2 DOWNTO 0);
signal Z, Z1, rst, clk, mode, start, done : STD_LOGIC;
signal M, Count : integer;
signal E : natural;

Begin
UUT: Lab1
Port Map (
	A => A,
	B => B,
	clk => clk,
	mode => mode,
	rst => rst,
	start => start,
	done => done,
	Y => Y,
	Z => Z );

reset: process 
Begin 
    rst <= '1';
    wait for 5220ns;
    rst <= '0';
    wait;
end process;

starter: process
Begin 
    start <= '0';
    wait for 5200ns;
    start <= '1';
    wait;
end process;

modes: process
Begin
    mode <= '0';
    wait for 5200ns;
    mode <='1';
    wait;
end process;

clock: process
Begin 
    clk <= '0';
    wait for 10ns;
    clk <='1';
    wait for 10ns;
end process;

testing: PROCESS
Begin
    Z1 <= '0';
    Count <= 0;
    A <= "000000";
    B <= "000";
	for j in 0 to 7 loop
		for i in 0 to 64 loop
            if (j = 0 and (i = 2 or i = 3 or i = 5 or i = 7 or i = 11 or i = 13 or i = 17 or i = 19 or i = 23 or i = 29 or i = 31 or i = 37 or i = 41 or i = 43 or i = 47 or i = 53 or i = 59 or i = 61)) then Z1 <= '1'; 
            elsif (j = 1 and (i = 0 or i = 8 or i = 16 or i = 24 or i = 32 or i = 40 or i = 48 or i = 56)) then Z1 <= '1';
            elsif (j = 2 and (i = 0 or i = 13 or i = 26 or i = 39 or i = 52)) then Z1 <= '1';
            elsif (j = 3 and (i = 0 or i = 1 or i = 3 or i = 6 or i = 10 or i = 15 or i = 21 or i = 28 or i = 36 or i = 45 or i = 55)) then Z1 <= '1';
            elsif (j = 4 and (i = 0 or i = 1 or i = 4 or i = 9 or i = 16 or i = 25 or i = 36 or i = 49)) then Z1 <= '1';
            elsif (j = 5 and (i = 1 or i = 5 or i = 12 or i = 22 or i = 35 or i = 51)) then Z1 <= '1';
            elsif (j = 6 and (i = 1 or i = 6 or i = 15 or i = 28 or i = 45)) then Z1 <= '1';
            elsif (j = 7 and (i = 1 or i = 7 or i = 18 or i = 34 or i = 55)) then Z1 <= '1';
            else Z1 <= '0';
            end if;
            if (TO_INTEGER(unsigned(Z)) /= TO_INTEGER(unsigned(Z1))) then Count <= Count + 1; end if;
            assert TO_INTEGER(unsigned(Z)) = TO_INTEGER(unsigned(Z1))
            report "Assertion Failed - Error count: " & integer'image(Count + 1);
		    wait for 10ns;
		    if (i /= 63) then A <= std_logic_vector(unsigned(A) + 1); end if;
        end loop;
        A <= "000000";
        B <= std_logic_vector(unsigned(B) + 1);
	end loop; 

	A <= "000100";
	B <= "001";
	wait for 10ns;
	A <= "000100";
	B <= "001";
	if (TO_INTEGER(unsigned(Y)) /= 0) then 
	   Count <= Count + 1; 
	   assert TO_INTEGER(unsigned(Y)) = 0
	   report "Assertion Failed - Error count: " & integer'image(Count + 1);
	   end if; 
	if Count = 1 then report "Assertion Failed - Error count: 1"; end if;
	wait for 10ns;
	A <= "000000";
	B <= "000";
	for i in 0 to 63 loop
		for j in 0 to 7 loop
			wait for 10ns;
			if (j < 6) then M <= (i ** j) mod 64;
			else E <= i;
			for k in 0 to j loop
			   E <= E*i;
			   if (E > 63) then E <= E mod 64; end if;
			end loop; 
			end if;
			
			if (M /= TO_INTEGER(unsigned(Y))) then Count <= Count + 1; end if;
			assert M = TO_INTEGER(unsigned(Y))
			report "Assertion Failed - Error count: " & integer'image(Count + 1);
			wait for 10ns;
			B <= std_logic_vector(unsigned(B) + 1);
        end loop;
		A <= std_logic_vector(unsigned(A) + 1);
		B <= "000";
	end loop; 
	wait;
end process;
end architecture;