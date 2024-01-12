------------------------------------------------------------------------------------------------------------------------
-- Write a program that shows 10 random numbers on the leftmost SSEG segment one second at a time.
-- Each displayed number is between 0 and 15, displayed as a hex digit.
-- Each time the FPGA shows a number, the user has 1 second to flick the correct switch up. 
-- For example, if the segment shows 7, the user is supposed to turn the SW(7) ON, while all other switches are OFF.
-- When the next number shows up (say A), the user is supposed to turn OFF the previous switch and 
--    turn ON the switch corresponding to the new number - SW(10) in this case, since "A" in hex means 10 decimal.
-- If the user turns ON the correct switch, they get 1 point added to their score. Otherwise, score stays the same.
-- The goal of the game is to get the highest Score.
-- The user score will be tracked by a 4 bit unsigned variable called Score.
-- When the user pushes down BTNC, the Score is reset to 0 and the game begins.
-- The value of the Score will be shown in "gas gauge" style on the LEDs as follows:
--    0 is all blank LEDs                ................
--    1 is one lit LED on the left:      o...............
--    2 is two lit LEDs:                 oo..............
--    3 is three lit LEDs:               ooo............. 
--    4 is four lit LEDs, etc…
--  The computer displays 10 numbers and the game stops after the 10th number. 
--  The Score (between 0 and 10) will stay on the LEDs indefinitely until the RESET button pushed again 
--      and the Score is set back to 0 and the game begins again.

------------------------------------------------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity MIDQ3 is
    Port ( CLK      : in  STD_LOGIC;
           SW       : in  STD_LOGIC_VECTOR (15 downto 0);
           BTN      : in  STD_LOGIC_VECTOR (4 downto 0);
           LED      : out STD_LOGIC_VECTOR (15 downto 0);
           SSEG_CA  : out std_logic_vector (7 downto 0);
           SSEG_AN  : out std_logic_vector (3 downto 0));
end MIDQ3;

architecture Behavioral of MIDQ3 is
    type GameState is (Start, ChkUserGuess, BadPick, GoodPick, GameOver);
    type Chars is (zero, one, two, three, four, five, six, seven, eight, nine, A, b, C, d, E, F);
    
    signal ClkDiv: unsigned (31 downto 0);
    signal StateTransition  : std_logic := '0'; -- will be '1' at the last clock tick of each state
    signal Good, Bad : STD_LOGIC:='0';
    signal Score: integer range 0 to 10:= 0;
    signal CurrentState, NextState: GameState := Start;
    signal SpeedCtr: unsigned (31 downto 0) := X"05F5_E100";
    signal RandomNumber:unsigned(3 downto 0);          -- captured when switches change
    signal FPGApick:unsigned(3 downto 0);              -- the random number picked at transition time
    signal NewSW, OldSW: std_logic_vector(15 downto 0);

    signal NumberOfTries: unsigned(7 downto 0);
    signal UserGuess: std_logic_vector(3 downto 0);       -- user's guess, captured during state transitione

    --signal CurrentSSEGnum: SSEGnumber; 

    type sseg_digits is array (0 to 15) of std_logic_vector(7 downto 0);
    constant digit_table: sseg_digits := (
        "11000000",  -- 0
        "11111001",  -- 1 
        "10100100",  -- 2 
        "10110000",  -- 3
        "10011001",  -- 4
        "10010010",  -- 5
        "10000010",  -- 6
        "11111000",  -- 7 
        "10000000",  -- 8
        "10011000",  -- 9 
        "10001000",  -- A
        "10000011",  -- b 
        "10000110",  -- C 
        "10100001",  -- d 
        "10000110",  -- E 
        "10001110"   -- F
    ); 

    type led_indicators is array (0 to 10) of std_logic_vector(15 downto 0);
    constant led_gauge: led_indicators := (
        B"1000_0000_0000_0000",  -- 0
        B"1100_0000_0000_0000",  -- 1 
        B"1110_0000_0000_0000",  -- 2 
        B"1111_0000_0000_0000",  -- 3
        B"1111_0000_0000_0000",  -- 4
        B"1111_1000_0000_0000",  -- 5
        B"1111_1100_0000_0000",  -- 6
        B"1111_1110_0000_0000",  -- 7 
        B"1111_1111_0000_0000",  -- 8
        B"1111_1111_1000_0000",  -- 9
        B"1111_1111_1100_0000"   -- 10
    ); 

begin

LED <= led_gauge(Score);
SSEG_AN <= "0111";
process (clk) begin
    if(rising_edge(clk)) then
        ClkDiv <= ClkDiv+1;
		if (BTN(4) = '1') then
            CurrentState <= Start;
        else 
            CurrentState <= NextState;
        end if;
    end if;
end process;

-- Calculate NextState combinatorially
process (CurrentState) begin
    case (CurrentState) is
        when start =>
            if (StateTransition = '1') then
                NextState <= ChkUserGuess;
            end if;
        when ChkUserGuess => 
            if(Bad = '1' and StateTransition = '1') then
                NextState <= BadPick;
            end if;
            if(Good = '1' and StateTransition = '1') then
                NextState <= GoodPick;
            end if;
        when BadPick => 
            if(StateTransition = '1') then
                NextState <= Start;
            end if;
        when GoodPick => 
            if(StateTransition = '1') then
                NextState <= Start;
            end if;
        when Gameover =>
            if (BTN(4) = '1') then 
                NextState <= Start;
            end if;
        when others => 
            NextState <= start;
    end case;
end process;



-- Tasks to do in each state (CurrentState)
process (clk) begin
    if(rising_edge(clk)) then
        case (CurrentState) is
            when start =>
                FPGApick <= unsigned(ClkDiv(3 downto 0)); -- random pick
                SSEG_CA <= digit_table(to_integer(FPGApick));
                if (CurrentState = NextState) then
                    StateTransition <= '1';
                else 
                    StateTransition <= '0';
                end if;
                Bad <= '0';
                Good <= '0';
            when ChkUserGuess => 
                case (SW) is
                    when B"0000_0000_0000_0001" => UserGuess <= "0000";
                    when B"0000_0000_0000_0010" => UserGuess <= "0001";
                    when B"0000_0000_0000_0100" => UserGuess <= "0010";
                    when B"0000_0000_0000_1000" => UserGuess <= "0011";
                    when B"0000_0000_0001_0000" => UserGuess <= "0100";
                    when B"0000_0000_0010_0000" => UserGuess <= "0101";
                    when B"0000_0000_0100_0000" => UserGuess <= "0110";
                    when B"0000_0000_1000_0000" => UserGuess <= "0111";
                    when B"0000_0001_0000_0000" => UserGuess <= "1000";
                    when B"0000_0010_0000_0000" => UserGuess <= "1001";
                    when B"0000_0100_0000_0000" => UserGuess <= "1010";
                    when B"0000_1000_0000_0000" => UserGuess <= "1011";
                    when B"0001_0000_0000_0000" => UserGuess <= "1100";
                    when B"0010_0000_0000_0000" => UserGuess <= "1101";
                    when B"0100_0000_0000_0000" => UserGuess <= "1110";
                    when B"1000_0000_0000_0000" => UserGuess <= "1111";
                    when others => UserGuess <= "0000";
                end case;
                if(std_logic_vector(FPGAPick) = std_logic_vector(UserGuess)) then
                    Good <= '1';
                else
                    Bad <= '1';
                end if;
                StateTransition <= '1';
            when BadPick => 
                NumberOfTries <= NumberOfTries + 1;
            when GoodPick => 
                Score <= Score + 1;
            when Gameover =>
                if (BTN(4) = '1') then
                    StateTransition <= '1';
                end if;
            when others => 
                StateTransition <= '0';
        end case;
        if (BTN(4) = '1') then
            Score <= 0;
        end if;
        if (CurrentState = NextState) then
            StateTransition <= '0';
        end if;
    end if;
end process;


end Behavioral;