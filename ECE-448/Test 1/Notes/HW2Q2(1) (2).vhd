----------------------------------------------------------------------------------
-- Created by Dr. Tolga Soyata  9/12/2021
-- This program displays a continuously shifting GEORGE MASON message
-- It displays this message on 4 SSEG displays
-- The rotation effect is achieved by displaying GEOR -> EORG -> ORGE -> RGE_ 
-- -> GE_M -> E_MA -> _MAS -> MASO -> ASON and we return back to the beginning
--  
-- All buttons act as the RESET signal. 
-- Pushing any button resets the message back to GEOR 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;


entity HW2Q2 is
    Port ( CLK : in std_logic;
           BTN : in std_logic_vector (4 downto 0);
           SSEG_CA : out std_logic_vector (7 downto 0);
           SSEG_AN : out std_logic_vector (3 downto 0));
end HW2Q2;

architecture Behavioral of HW2Q2 is
    signal ClkDiv: unsigned (30 downto 0);
    -- signal SSEGpattern: std_logic_vector (7 downto 0); -- character on the SSEG data bus
    signal Reset: std_logic;
    signal CurrentState: unsigned (3 downto 0);
    signal CurrentSSEG:  std_logic_vector (3 downto 0);
    
------------------------------------------------------------------
-- character ROM
-- Total 9 characters: space   A   E   G   M   N   O   R   S
-- indexes are:          0     1   2   3   4   5   6   7   8
------------------------------------------------------------------
    -- signal char_index: integer range 0 to 8;
    type GMUchars is (blank, A, E, G, M, n, O, r, S);
    signal CurrentChar: GMUchars; 
    type char_arry is array (GMUchars) of std_logic_vector(7 downto 0);
    constant char_table: char_arry := (
        "11111111",  -- blank
        "10001000",  -- A 
        "10000110",  -- E 
        "10000010",  -- G
        "10101010",  -- M
        "10101011",  -- n
        "11000000",  -- O
        "10101111",  -- r 
        "10010010"   -- S
    ); 

begin
    Reset <= BTN(4) or BTN(3) or BTN(2) or BTN(1) or BTN(0);
    CurrentState <= ClkDiv(30 downto 27);
    SSEG_AN <= CurrentSSEG;
    SSEG_CA <= char_table(CurrentChar);

process (CLK) begin
    if(CLK'event and CLK = '1') then
        ClkDiv <= ClkDiv+1;
        if ((Reset = '1') or (ClkDiv(30 downto 27) = "1001")) then -- 9 is 0
             -- there are a total of 9 states (mod 9)
             -- we go through states 0, 1, 2, ... 8, back to 0
             ClkDiv(30 downto 27) <= "0000";  
        end if;
    end if;
    
    -- SSEG timing
    case ClkDiv(18 downto 17) is
        when "00" =>           CurrentSSEG <= "0111";
        when "01" =>           CurrentSSEG <= "1011";
        when "10" =>           CurrentSSEG <= "1101";
        when "11" =>           CurrentSSEG <= "1110";
    end case;
    
    if (    ((CurrentState=0) and (CurrentSSEG="0111")) or 
            ((CurrentState=1) and (CurrentSSEG="1110")) or
            ((CurrentState=2) and (CurrentSSEG="1101")) or
            ((CurrentState=3) and (CurrentSSEG="1011")) or
            ((CurrentState=4) and (CurrentSSEG="0111"))
        ) then   CurrentChar <= G;
    elsif ( ((CurrentState=0) and (CurrentSSEG="1011")) or 
            ((CurrentState=1) and (CurrentSSEG="0111")) or
            ((CurrentState=2) and (CurrentSSEG="1110")) or
            ((CurrentState=3) and (CurrentSSEG="1101")) or
            ((CurrentState=4) and (CurrentSSEG="1011")) or
            ((CurrentState=5) and (CurrentSSEG="0111"))
        ) then   CurrentChar <= E;
    elsif ( ((CurrentState=0) and (CurrentSSEG="1101")) or 
            ((CurrentState=1) and (CurrentSSEG="1011")) or
            ((CurrentState=2) and (CurrentSSEG="0111")) or
            ((CurrentState=7) and (CurrentSSEG="1110")) or
            ((CurrentState=8) and (CurrentSSEG="1101"))
        ) then   CurrentChar <= O;
    elsif ( ((CurrentState=0) and (CurrentSSEG="1110")) or 
            ((CurrentState=1) and (CurrentSSEG="1101")) or
            ((CurrentState=2) and (CurrentSSEG="1011")) or
            ((CurrentState=3) and (CurrentSSEG="0111"))
        ) then   CurrentChar <= r;
    elsif ( ((CurrentState=4) and (CurrentSSEG="1110")) or
            ((CurrentState=5) and (CurrentSSEG="1101")) or
            ((CurrentState=6) and (CurrentSSEG="1011")) or
            ((CurrentState=7) and (CurrentSSEG="0111"))
        ) then   CurrentChar <= M;
    elsif ( ((CurrentState=3) and (CurrentSSEG="1110")) or
            ((CurrentState=4) and (CurrentSSEG="1101")) or
            ((CurrentState=5) and (CurrentSSEG="1011")) or
            ((CurrentState=6) and (CurrentSSEG="0111"))
        ) then   CurrentChar <= blank;
    elsif ( ((CurrentState=5) and (CurrentSSEG="1110")) or 
            ((CurrentState=6) and (CurrentSSEG="1101")) or
            ((CurrentState=7) and (CurrentSSEG="1011")) or
            ((CurrentState=8) and (CurrentSSEG="0111"))
        ) then   CurrentChar <= A;
    elsif ( ((CurrentState=6) and (CurrentSSEG="1110")) or
            ((CurrentState=7) and (CurrentSSEG="1101")) or
            ((CurrentState=8) and (CurrentSSEG="1011"))
        ) then   CurrentChar <= S;
    elsif ( ((CurrentState=8) and (CurrentSSEG="1110"))
        ) then   CurrentChar <= n;

    end if;
    
end process;



end Behavioral;
