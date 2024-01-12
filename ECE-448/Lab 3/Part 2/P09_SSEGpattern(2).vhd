---------------------------------------------------------------------------------
-- Created by Dr. Tolga Soyata  9/23/2021
-- This program displays a repeating pattern on the SSEG segments
-- The repeating pattern is determined by SW(0)
--   SW(0)='0'  pattern is:   A... ->  .A..  -> ...A  ->  A...  -> .A..    ...
--   SW(0)='1'  pattern is:   b... ->  .AA.  -> ...A  ->  b...  -> .AA.    ...
----------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;


entity P09_SSEGpattern is
    Port ( CLK : in STD_LOGIC;
           SW : in STD_LOGIC_VECTOR (15 downto 0);
           SSEG_CA : out std_logic_vector (7 downto 0);
           SSEG_AN : out std_logic_vector (3 downto 0));
end P09_SSEGpattern;



architecture Behavioral of P09_SSEGpattern is
    type State is (blank, sw0st1, sw0st2, st3, sw1st1, sw1st2);

    signal ClkDiv: unsigned (28 downto 0);
    signal WhatToDisplay:  std_logic_vector(7 downto 0);
    signal WhereToDisplay: std_logic_vector(3 downto 0);
    signal CurrentState, NextState: State := blank;
begin

process (clk) begin
    if(rising_edge(clk)) then
        ClkDiv <= ClkDiv+1;
        if(ClkDiv = X"5F5_E100") then     -- 100,000,000
            ClkDiv <= (others => '0');
            -- state transition every 1 second 
            CurrentState <= NextState;    
        end if; 
        SSEG_CA <= WhatToDisplay;
        SSEG_AN <= WhereToDisplay;
    end if;
end process;


process (SW(0), CurrentState) begin
    NextState <= blank;
    WhatToDisplay <= "11111111";   
    WhereToDisplay <= "1111";
    case (CurrentState) is
        when blank =>
            if(SW(0)='0') then
                NextState <= sw0st1;
            else
                NextState <= sw1st1;
            end if;
        when sw0st1 => 
            if(SW(0)='0') then
                NextState <= sw0st2;
                WhatToDisplay <= "10001000";   -- A...
                WhereToDisplay <= "0111";
            end if;
        when sw0st2 => 
            if(SW(0)='0') then
                NextState <= st3;
                WhatToDisplay <= "10001000";   -- ..A.
                WhereToDisplay <= "1101";
            end if;
        when st3 => 
                NextState <= blank;
                WhatToDisplay <= "10001000";   -- ...A
                WhereToDisplay <= "1110";
        when sw1st1 => 
            if(SW(0)='1') then
                NextState <= sw1st2;
                WhatToDisplay <= "10000011";   -- b...
                WhereToDisplay <= "0111";
            end if;
        when sw1st2 => 
            if(SW(0)='1') then
                NextState <= st3;
                WhatToDisplay <= "10001000";   -- .AA.
                WhereToDisplay <= "1001";
            end if;
         when others => 
    end case;
end process;


end Behavioral;
