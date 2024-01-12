library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Lab3 is
    Port (
        CLK, SW : in STD_LOGIC;
        BTN : in STD_LOGIC_VECTOR(4 DOWNTO 0);
        LED : out STD_LOGIC_VECTOR(4 DOWNTO 0);
        SSEG_AN : out STD_LOGIC_VECTOR(3 DOWNTO 0);
        SSEG_CA : out STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
end Lab3;

architecture Behavioral of Lab3 is

type state is (start, money, destination, amount, dispense);
signal CurrentState, NextState: state;
signal ClkDiv, counter, fee, tickets: unsigned (31 downto 0);
signal data1, data2, data3, data4: STD_LOGIC_VECTOR(6 downto 0);

begin

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

process (CurrentState) begin
    case (CurrentState) is
        when start =>
            if (BTN(4) = '1') then
                NextState <= money;
            end if;
        when money => 
            if(BTN(4) = '1') then
                NextState <= destination;
            end if;
        when destination => 
            if(BTN(4) = '1') then
                NextState <= amount;
            end if;
        when amount => 
            if(BTN(4) = '1') then
                NextState <= dispense;
            end if;
        when dispense =>
            if (BTN(4) = '1') then 
                NextState <= Start;
            end if;
        when others => 
            NextState <= start;
    end case;
end process;

process (ClkDiv(18 downto 17), data1, data2, data3, data4) begin
    case (ClkDiv(18 downto 17)) is
        when "00" =>
             SSEG_AN <= "0111";
             SSEG_CA <= data1;
        when "01" =>
             SSEG_AN <= "1011";
             SSEG_CA <= data2;
        when "10" =>
             SSEG_AN <= "1101";
             SSEG_CA <= data3;
        when "11" =>
             SSEG_AN <= "1110";
             SSEG_CA <= data4;
    end case;
end process;

process (clk) begin
    if(rising_edge(clk)) then
        case (CurrentState) is
            when start =>
                counter <= x"0000";
                LED <= "00000";
                tickets <= x"0000";
            when money => 
                case BTN(3 downto 0) is
                    when "0001" => counter <= counter + 25;
                    when "0010" => counter <= counter + 100;
                    when "0100" => counter <= counter + 10;
                    when "1000" => counter <= counter + 500;
                end case;
            when destination => 
                if (BTN (4) = '1') then
                    fee <= fee + 1260;
                elsif (BTN(4) = '1' and BTN(3) = '1') then
                    fee <= fee + 2175;
                elsif (BTN(4) = '1' and BTN(2) = '1') then
                    fee <= fee + 930;
                end if;
            when amount => 
                if (BTN(4) = '1' and BTN(3) = '1') then
                    tickets <= tickets + 1;
                end if;
                if (BTN(4) = '1' and BTN(2) = '1') then
                    tickets <= tickets - 1;
                end if;
            when dispense =>
                if (BTN(4) = '1') then
                    counter <= counter - (tickets*fee);
                end if;
        end case;
    end if;
end process;

end Behavioral;