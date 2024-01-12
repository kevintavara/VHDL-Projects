------------------------------------------------------------------------
-- Modified by Dr. Tolga Soyata - 10/31/2021
------------------------------------------------------------------------
-- hcount         - input pin, 11 bits, from vga_module
--                - the horizontal counter from the vga_controller
--                - tells the horizontal position of the current pixel
--                - on the screen from left to right.
-- vcount         - input pin, 11 bits, from vga_module
--                - the vertical counter from the vga_controller
--                - tells the vertical position of the currentl pixel
--                - on the screen from top to bottom.
-- red_out        - output pin, 4 bits, to vga hardware module.
--                - red output channel
-- green_out      - output pin, 4 bits, to vga hardware module.
--                - green output channel
-- blue_out       - output pin, 4 bits, to vga hardware module.
--                - blue output channel
------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity HI_object is
port (
   pixel_clk: in std_logic;
   -- relative position of the object
   xpos     : in std_logic_vector(11 downto 0);
   ypos     : in std_logic_vector(11 downto 0);
   theta    : in std_logic_vector(15 downto 0);
   
   -- VGA position counters
   hcount   : in std_logic_vector(11 downto 0);
   vcount   : in std_logic_vector(11 downto 0);

   enable_HIobj_out : out std_logic;
   
   red_out  : out std_logic_vector(3 downto 0);
   green_out: out std_logic_vector(3 downto 0);
   blue_out : out std_logic_vector(3 downto 0)
);


end HI_object;

architecture Behavioral of HI_object is


-- width and height of the letters 
constant THICK: std_logic_vector(11 downto 0) := B"0000_0010_0000";   -- letter thickness
constant XDIST: std_logic_vector(11 downto 0) := B"0000_0100_0000";   -- distance between I's
constant YSIZE: std_logic_vector(11 downto 0) := B"0001_0000_0000";   -- height of characters
constant YSIZ:  std_logic_vector(11 downto 0) := B"0000_1000_0000";   -- YSIZE/2


-- ObjPixel=0 means that there is no object at that location
signal ObjPixel: std_logic_vector(1 downto 0) := (others => '0');
signal enable_HIobj: std_logic := '0';



signal red_int  : std_logic_vector(3 downto 0);
signal green_int: std_logic_vector(3 downto 0);
signal blue_int : std_logic_vector(3 downto 0);

signal red_int1  : std_logic_vector(3 downto 0);
signal green_int1: std_logic_vector(3 downto 0);
signal blue_int1 : std_logic_vector(3 downto 0);


begin


   -- set enable_HI high if vga counters inside the HI object
   enable_HI: process(pixel_clk, hcount, vcount, xpos, ypos)
   begin
      if(rising_edge(pixel_clk)) then
         if(      ((hcount >= xpos+X"001")              and (hcount < (xpos + THICK - X"001"))             and (vcount >= ypos)      and (vcount < (ypos + YSIZE)))
			or    ((hcount >= xpos+X"001"+XDIST)        and (hcount < (xpos + THICK+XDIST - X"001"))       and (vcount >= ypos)      and (vcount < (ypos + YSIZE)))
		    or    ((hcount >= xpos+X"001"+XDIST+XDIST)  and (hcount < (xpos + THICK+XDIST+XDIST - X"001")) and (vcount >= ypos)      and (vcount < (ypos + YSIZE)))
			or    ((hcount >= xpos+THICK- X"001")       and (hcount < (xpos+THICK+XDIST - X"001"))         and (vcount >= ypos+YSIZ) and (vcount < (ypos + YSIZ+THICK)))
		 ) then
				enable_HIobj <= '1';
		  else
				enable_HIobj <= '0';
         end if;
      end if;
   end process enable_HI;
   
enable_HIobj_out <= enable_HIobj;

   -- if the object is enabled, then, according to pixel
   -- value, set the output color channels.
 process(pixel_clk)
   begin
      if(rising_edge(pixel_clk)) then
            if(enable_HIobj = '1') then
                  red_out <= (others => '1');
                  green_out <= (others => '0');
                  blue_out <= (others => '0');
            else
                  red_out <= (others => '0');
                  green_out <= (others => '0');
                  blue_out <= (others => '0');
            end if;
      end if;
   end process;


end Behavioral;
