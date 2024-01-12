----------------------------------------------------------------------------------------------------------------
-- Created by Dr. Tolga Soyata           9/11/2021
-- SW(7 downto 0) are the first 8 bit number; call it number1.
-- SW(15 downto 8) are the second 8 bit number; call it number2.
-- Note that I have not specified whether these numbers are signed or unsigned yet. 
-- They are simply meaningless 8 bit vectors, until you push some of the buttons.
--
-- Five buttons (BTNC, BTNU, BTNL, BTNR, BTND) specify an operation;
-- BTNC (center) performs logical XOR (number 1 xor number 2),
-- BTNU (up) performs unsigned multiplication (number 1 umul number 2),
-- BTNL (left) performs signed multiplication (number 1 smul number 2),
-- BTNR (right) performs signed addition (number 1 sadd number 2),
-- BTND (down) performs unsigned addition (number 1 uadd number 2).
-- Even if the result has fewer than 16 bits, 
--   it still must be displayed as a 16 bit value (by sign-extending)
-----------------------------------------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;


entity HW1Q1 is
    Port ( BTN : in  std_logic_vector(4 downto 0);
           SW   : in  std_logic_vector (15 downto 0);
           LED  : out std_logic_vector (15 downto 0));
end HW1Q1;

architecture Behavioral of HW1Q1 is

    signal number1    : std_logic_vector (7 downto 0);
    signal number2    : std_logic_vector (7 downto 0);
    signal xor12      :  std_logic_vector (7 downto 0);
    signal unum1      :  unsigned (7 downto 0);
    signal unum2      :  unsigned (7 downto 0);
    signal snum1      :  signed   (7 downto 0);
    signal snum2      :  signed   (7 downto 0);
    signal snum1ext   :  signed   (15 downto 0);
    signal snum2ext   :  signed   (15 downto 0);
    signal mulu       :  unsigned (15 downto 0);
    signal muls       :  signed   (15 downto 0);        
    signal addu       :  unsigned (15 downto 0);
    signal adds       :  signed   (15 downto 0);
    signal BTNC, BTNU, BTNL, BTNR, BTND: std_logic;         
    
begin
    BTNC <= BTN(4);
    BTNU <= BTN(0);
    BTNL <= BTN(1);
    BTNR <= BTN(2);
    BTND <= BTN(3);

    number1 <= SW(7 downto 0);
    number2 <= SW(15 downto 8);
    xor12 <= number1 xor number2;
    unum1 <= unsigned(number1);
    unum2 <= unsigned(number2);
    snum1 <= signed(number1);
    snum2 <= signed(number2);
    -- sign extend snum1, snum2
    process (snum1,snum2) begin
        snum1ext(7 downto 0) <= snum1;
        if(snum1(7)='1') then
            snum1ext(15 downto 8) <= "11111111";
         else
            snum1ext(15 downto 8) <= "00000000";
        end if;
        snum2ext(7 downto 0) <= snum2;
        if(snum2(7)='1') then
            snum2ext(15 downto 8) <= "11111111"; 
         else
            snum2ext(15 downto 8) <= "00000000";
        end if;
    end process;
    addu <=  ("00000000" & unum1) + ("00000000" & unum2);
    adds <=  snum1ext + snum2ext;
    mulu <=  unum1 * unum2;
    muls <=  snum1 * snum2;
    
    process begin
        if(BTNC='1') then
            LED <= "00000000" & xor12;
        elsif(BTNU='1') then
            LED <= std_logic_vector(mulu);
        elsif(BTNL='1') then
            LED <= std_logic_vector(muls);
        elsif(BTNR='1') then
            LED <= std_logic_vector(adds);
        elsif(BTND='1') then
            LED <= std_logic_vector(addu);
        else
            LED <= X"0000";
        end if;
    end process;
end Behavioral;
