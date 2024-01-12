library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity bcd_to_7seg_tb is
end;

architecture testbench of bcd_to_7seg_tb is
    signal bcd: std_logic_vector(3 downto 0);
    signal seven_seg: std_logic_vector(6 downto 0);
    
    type test_data_type is record
        bcd: std_logic_vector(3 downto 0);
        seven_seg: std_logic_vector(6 downto 0);
    end record;
    
    type test_data_array_type is array(natural range <>) of test_data_type;
    
    constant TEST_DATA: test_data_array_type := (
        (x"0", "0111111"),
        (x"1", "0000110"),
        (x"2", "1011011"),
        (x"3", "1001111"),
        (x"4", "1100110"),
        (x"5", "1101101"),
        (x"6", "1111101"),
        (x"7", "0000111"),
        (x"8", "1111111"),
        (x"9", "1101110"),
        (x"a", "0000000"),
        (x"b", "0000000"),
        (x"c", "0000000"),
        (x"d", "0000000"),
        (x"e", "0000000"),
        (x"f", "0000000")
    );
    
    signal test_vector_index: integer range 0 to TEST_DATA'length-1 := 0;
    constant DUV_DELAY: time := 5 ns;
    constant TEST_INTERVAL: time := 10 ns;
begin
    duv: entity work.bcd_to_7seg
        port map(bcd => bcd, seven_seg => seven_seg);
    stimuli_generator: process
    variable debug_line: line;
    begin
        for i in TEST_DATA'range loop
            bcd <= TEST_DATA(i).bcd;
            test_vector_index <= i;
            write(debug_line, string'("Testing DUV with input "));
            write(debug_line, TEST_DATA(i).bcd);
            writeline(output, debug_line);
            wait for TEST_INTERVAL;
        end loop;
        
        report "End of testbench. All tests passed." ;
        wait;
        
    end process;
    
    response_checker: process
    variable debug_line: line;
    begin
        wait on test_vector_index;
        
        wait for DUV_DELAY;
        
        if seven_seg /= TEST_DATA(test_vector_index).seven_seg then
            write(debug_line, string'("Error -- DUV.seven_seg = "));
            write(debug_line, seven_seg);
            write(debug_line, string'(" -- TEST_DATA.seven_seg = "));
            write(debug_line, TEST_DATA(test_vector_index).seven_seg);
            writeline(output, debug_line);
            
            report "SIMULATION FAILED"
            severity FAILURE;
        end if;
        
        wait for TEST_INTERVAL - DUV_DELAY;
        if seven_seg'stable(TEST_INTERVAL - DUV_DELAY) = false then
            write(debug_line, string'("DUV.seven_seg is NOT stable"));
            writeline(output, debug_line);
            
            report "SIMULATION FAILED"
            severity FAILURE;
        end if;
        
    end process;
end;
