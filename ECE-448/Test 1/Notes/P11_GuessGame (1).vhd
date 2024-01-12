---------------------------------------------------------------------------------------------------
-- Created by Dr. Tolga Soyata  9/30/2021
-- This program plays a number guessing game with the user
-- When the user hits RESET, the game starts (BTNC).
--
-- FPGA board picks a random number between 0 and 255 (FPGApicked).
-- The user does not know the number and keeps guessing it.
 
-- The user enters a "guessed number" using SW(7 downto 0) and pushes a BTND 
-- when the number is ready (UserGuess).
-- Note: BTND must be debounced. 
-- The UserGuess is only accepted when BTND clean transitions 0->1 followed by 1->0
-- 
-- If the UserGuess < FPGApicked  the FPGA displays LO on SSEG display
-- If the UserGuess > FPGApicked  the FPGA displays HI on SSEG display
-- If the UserGuess = FPGApicked  the FPGA displays OVER on SSEG display and the game is over
--
-- At any step, the FPGA displays the number of "guesses" on the LEDs in binary (NumberOfTries).
--
-- The goal of the game is to guess the FPGApicked in the least number of tries.
--
-- SW(15) is cheat mode. Displays the FPGApicked on LED(15 downto 8)

----------------------------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity P11_GuessGame is
    Port ( CLK      : in  STD_LOGIC;
           SW       : in  STD_LOGIC_VECTOR (15 downto 0);
           BTN      : in  STD_LOGIC_VECTOR (4 downto 0);
           LED      : out STD_LOGIC_VECTOR (15 downto 0);
           SSEG_CA  : out std_logic_vector (7 downto 0);
           SSEG_AN  : out std_logic_vector (3 downto 0));
end P11_GuessGame;


architecture Behavioral of P11_GuessGame is
    type GameState is (start, wait1, wait0, selected, UserLO, UserHI, GameOver);
    signal CurrentState, NextState: GameState := start;

    type ButtonState is (unknown, debounce01, clean1, debounce10, clean0);
    signal BTNDstate: ButtonState := unknown; -- state of BTND
    signal DebounceTimer: unsigned(21 downto 0); 
    
    signal ClkDiv: unsigned (31 downto 0);
    signal Reset, BTND:  std_logic;
    signal CheatMode:   std_logic;  -- displays FPGApicked on LED(15 downto 8)

    signal NumberOfTries: unsigned(7 downto 0);
    signal UserGuess: unsigned(7 downto 0);
    signal FPGApicked: unsigned(7 downto 0);


------------------------------------------------------------------
-- character ROM
-- Total 9 characters: space   e   H   I   L   ll  o   r   v
-- indexes are:          0     1   2   3   4   5   6   7   8
------------------------------------------------------------------
    type GameChars is (blank, e, H, I, L, ll, O, r, v);
    type Segments is array (1 to 4) of GameChars;
    signal Display: Segments; 
    type char_arry is array (GameChars) of std_logic_vector(7 downto 0);
    constant char_table: char_arry := (
        "11111111",  -- blank
        "10000100",  -- e 
        "10001001",  -- H
        "11001111",  -- I
        "11000111",  -- L
        "11001001",  -- ll
        "10100011",  -- o
        "10101111",  -- r 
        "11100011"   -- v
    ); 


begin


BTND <= BTN(3);  -- dirty BTND
Reset <= BTN(4); -- BTNC
CheatMode <= SW(15);

-- LED display
process (NumberOfTries, CheatMode) begin
    if(CheatMode = '0') then
        LED <= B"0000_0000" & std_logic_vector(NumberOfTries);
    else
        LED <= std_logic_vector(FPGApicked) & std_logic_vector(NumberOfTries);
    end if;
end process; 


process (clk) begin
    if(rising_edge(clk)) then
        ClkDiv <= ClkDiv+1;
        if(Reset = '1') then
            CurrentState <= start;
        else
            CurrentState <= NextState;    
        end if;
    end if;
end process;



-- SSEG sequencer. Displays the contents of screen memory
-- Display(1) is the left segment
-- Display(2) is the second segment
-- Display(3) is the third segment
-- Display(4) is the right segment
process (ClkDiv(18 downto 17), Display) begin
    case (ClkDiv(18 downto 17)) is
        when "00" =>
             -- first segment
             SSEG_AN <= "0111";
             SSEG_CA <= char_table(Display(1));
        when "01" =>
             -- second segment
             SSEG_AN <= "1011";
             SSEG_CA <= char_table(Display(2));
        when "10" =>
             -- third segment
             SSEG_AN <= "1101";
             SSEG_CA <= char_table(Display(3));
        when "11" =>
             -- fourth segment
             SSEG_AN <= "1110";
             SSEG_CA <= char_table(Display(4));
    end case;
end process;



-- Debouncer for BTND
process (BTND, BTNDstate, clk) begin
    if(rising_edge(clk)) then
    case (BTNDstate) is
            when unknown    =>
                DebounceTimer <= (others => '1');
                if(BTND = '1') then
                    BTNDstate <= debounce01;
                else
                    BTNDstate <= debounce10;
                end if; 
            when debounce01 =>
                DebounceTimer <= DebounceTimer - 1;
                if (DebounceTimer = B"00_0000_0000_0000_0000_0000") then
                    if(BTND = '1') then
                        BTNDstate <= clean1;
                    else
                        BTNDstate <= unknown;
                    end if;
                end if; 
            when clean1     =>
                if(BTND = '1') then
                    BTNDstate <= clean1;
                else
                    BTNDstate <= unknown;
                end if;
            when debounce10 =>
                DebounceTimer <= DebounceTimer - 1;
                if (DebounceTimer = B"00_0000_0000_0000_0000_0000") then
                    if(BTND = '0') then
                        BTNDstate <= clean0;
                    else
                        BTNDstate <= unknown;
                    end if;
                end if; 
            when clean0     => 
                if(BTND = '0') then
                    BTNDstate <= clean0;
                else
                    BTNDstate <= unknown;
                end if;
        end case;
    end if;
end process;



-- Compute NextState combinatorially
process (CurrentState, FPGApicked, UserGuess, BTNDstate) begin
    case (CurrentState) is
        when start     =>
            NextState <= wait1;
        when wait1   => 
            if(BTNDstate /= clean1) then
                NextState <= wait1;
            else
                NextState <= wait0;
            end if;
        when wait0   => 
            if(BTNDstate /= clean0) then
                NextState <= wait0;
            else
                NextState <= selected;
            end if;
        when selected  => 
            if (FPGApicked < UserGuess) then
                NextState <= UserLO;
            elsif (FPGApicked > UserGuess) then 
                NextState <= UserHI;
            else  
                NextState <= GameOver;
            end if; 
        when UserLO    => 
            NextState <= wait1;
        when UserHI    => 
            NextState <= wait1;
        when GameOver  => 
            NextState <= GameOver;
        when others    => 
            NextState <= start;
    end case;
end process;



-- Tasks to do in each state
process (clk) begin
    if(rising_edge(clk)) then
        case (CurrentState) is
            when start     =>
                NumberOfTries <= (others => '0');
                FPGApicked <= unsigned(ClkDiv(7 downto 0)); -- random pick
                Display(1) <= H; 
                Display(2) <= e; 
                Display(3) <= ll;
                Display(4) <= o;
            when wait0  =>
                UserGuess <= unsigned(SW(7 downto 0));
            when selected  => 
                NumberOfTries <= NumberOfTries+1;
            when UserLO    => 
                Display(1) <= L; 
                Display(2) <= o; 
                Display(3) <= blank; 
                Display(4) <= blank; 
            when UserHI    => 
                Display(1) <= H; 
                Display(2) <= I; 
                Display(3) <= blank; 
                Display(4) <= blank; 
            when GameOver  => 
                Display(1) <= o; 
                Display(2) <= v; 
                Display(3) <= e; 
                Display(4) <= r; 
            when others    => 
        end case;
    end if;
end process;


end Behavioral;
