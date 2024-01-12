----------------------------------------------------------------------------------
-- Created by Dr. Tolga Soyata  8/31/2021
-- This program displays the type of a number on the SSEG displays
-- Number is entered on switches SW(0 to 7) as an unsigned 8b value
-- SW(8 to 11) determines where to display the result; the "AN" vector 
-- L means large number (greater than 100 decimal or 64 hex).
-- E means even number
-- O means odd number 
-- P means prime number
-- SW(12 to 13) determines what to display: 
--    00 is blanking
--    01 displays Odd/Even 
--    10 displays L the "L" attribute (i.e., >100)
--    11 displays P information (prime)
----------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;


entity HW1Q2 is
     Port (  SW : in std_logic_vector (15 downto 0);
             SSEG_CA : out std_logic_vector (7 downto 0);
             SSEG_AN : out std_logic_vector (3 downto 0));
end HW1Q2;

architecture Behavioral of HW1Q2 is
    signal TheNumber: unsigned(7 downto 0);
    signal WhatToDisplay: std_logic_vector(1 downto 0);
    signal WhereToDisplay: std_logic_vector(3 downto 0);
    signal DisplayCode: std_logic_vector(7 downto 0);
    signal ChosenChar:  unsigned(2 downto 0);
    signal IsGr10, IsOdd, IsPrime: std_logic;
    signal LocationErr: std_logic;
    signal a: std_logic_vector(3 downto 0);

begin
    TheNumber <= unsigned(SW(7 downto 0));
    WhatToDisplay <= SW(13 downto 12);
    IsOdd <= SW(0);
    IsGr10 <= '1' when (TheNumber > 100) else '0';

    charROM: entity work.CHAR_ROM        -- "IsPrime" will be true for prime numbers 
        port map( Number => TheNumber,
                  IsPrime => IsPrime,
                  CharCode => DisplayCode,
                  WhichChar => ChosenChar
                );

    -- determine the 4b display selection vector 
    process(SW(13 downto 8)) begin
        a <= SW(11 downto 8);
        if (a="0111" or a="1011" or a="1101" or a="1110") then 
            WhereToDisplay <= a; 
            LocationErr <= '0';
        else
            LocationErr <= '1';
            if (WhatToDisplay = "00") then
                WhereToDisplay <= "1111";   -- blanking selection. nothing will be displayed
            else
                WhereToDisplay <= "0000";   -- will display "EEEE" so all segments are ON
            end if;
        end if;
    end process;
    SSEG_AN <= WhereToDisplay;
 
    -- process(WhatToDisplay, IsGr10, IsPrime, IsOdd, TheNumber) begin
    process begin
        if (LocationErr = '1') then 
            ChosenChar<="001";          -- E
        else 
            case WhatToDisplay is
                -- screen blanking
                when "00" => 
                    ChosenChar <= "000";      -- blank
                -- O/E   odd/even information
                when "01" => 
                    if (IsOdd='1') then ChosenChar <= "011"; else ChosenChar <= "001"; end if;      -- O/E
                -- large number information
                when "10" => 
                    if (IsGr10='1') then ChosenChar <= "010"; else ChosenChar <= "000"; end if;      -- L/blank
                -- prime number information
                when "11" => 
                    if (IsPrime='1') then ChosenChar <= "100"; else ChosenChar <= "000"; end if;      -- P/blank
                when others => 
                    ChosenChar <= "000"; -- blank
            end case;
         end if;
    end process;
    SSEG_CA <= DisplayCode;
    
end Behavioral;
