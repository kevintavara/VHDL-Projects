----------------------------------------------------------------------------------
-- Modified by Dr. Tolga Soyata - 10/31/2021
-- It uses the ROTangle to change the xpos, ypos, which shifts the HI object.
-- In the next version of the program, ROTangle will be used to rotate the object. 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.math_real.all;



entity P220vga_ctrl is
    Port ( CLK_I :    in STD_LOGIC;
           SW  	 :    in std_logic_vector (15 downto 0);
           ROTangle:  in std_logic_vector(15 downto 0);  
           VGAoptions: in std_logic_vector(15 downto 0);   -- VGA options
           VGA_HS_O : out STD_LOGIC;
           VGA_VS_O : out STD_LOGIC;
           VGA_RED_O : out STD_LOGIC_VECTOR (3 downto 0);
           VGA_BLUE_O : out STD_LOGIC_VECTOR (3 downto 0);
           VGA_GREEN_O : out STD_LOGIC_VECTOR (3 downto 0)
         );
end P220vga_ctrl;

architecture Behavioral of P220vga_ctrl is

  --***1280x1024@60Hz***--
  constant FRAME_WIDTH : natural := 1280;
  constant FRAME_HEIGHT : natural := 1024;
  
  constant H_FP : natural := 48; --H front porch width (pixels)
  constant H_PW : natural := 112; --H sync pulse width (pixels)
  constant H_MAX : natural := 1688; --H total period (pixels)
  
  constant V_FP : natural := 1; --V front porch width (lines)
  constant V_PW : natural := 3; --V sync pulse width (lines)
  constant V_MAX : natural := 1066; --V total period (lines)
  
  constant H_POL : std_logic := '1';
  constant V_POL : std_logic := '1';
  
  -------------------------------------------------------------------------
  
  -- VGA Controller specific signals: Counters, Sync, R, G, B
  
  -------------------------------------------------------------------------
  -- Pixel clock, in this case 108 MHz
  signal pxl_clk : std_logic;
  -- The active signal is used to signal the active region of the screen (when not blank)
  signal active  : std_logic;
  
  -- Horizontal and Vertical counters
  signal h_cntr_reg : std_logic_vector(11 downto 0) := (others =>'0');
  signal v_cntr_reg : std_logic_vector(11 downto 0) := (others =>'0');
  
  -- Pipe Horizontal and Vertical Counters
  signal h_cntr_reg_dly   : std_logic_vector(11 downto 0) := (others => '0');
  signal v_cntr_reg_dly   : std_logic_vector(11 downto 0) := (others => '0');
  
  -- Horizontal and Vertical Sync
  signal h_sync_reg : std_logic := not(H_POL);
  signal v_sync_reg : std_logic := not(V_POL);
  -- Pipe Horizontal and Vertical Sync
  signal h_sync_reg_dly : std_logic := not(H_POL);
  signal v_sync_reg_dly : std_logic :=  not(V_POL);
  
  -- VGA R, G and B signals coming from the main multiplexers
  signal vga_red_cmb   : std_logic_vector(3 downto 0);
  signal vga_green_cmb : std_logic_vector(3 downto 0);
  signal vga_blue_cmb  : std_logic_vector(3 downto 0);
  --The main VGA R, G and B signals, validated by active
  signal vga_red    : std_logic_vector(3 downto 0);
  signal vga_green  : std_logic_vector(3 downto 0);
  signal vga_blue   : std_logic_vector(3 downto 0);
  -- Register VGA R, G and B signals
  signal vga_red_reg   : std_logic_vector(3 downto 0) := (others =>'0');
  signal vga_green_reg : std_logic_vector(3 downto 0) := (others =>'0');
  signal vga_blue_reg  : std_logic_vector(3 downto 0) := (others =>'0');
  
  
    -- HI object related signals
  signal HIobj_red    : std_logic_vector (3 downto 0) := (others => '0');
  signal HIobj_blue   : std_logic_vector (3 downto 0) := (others => '0');
  signal HIobj_green  : std_logic_vector (3 downto 0) := (others => '0');
  -- Registered HI object display signals
  signal HIobj_red_dly   : std_logic_vector (3 downto 0) := (others => '0');
  signal HIobj_blue_dly  : std_logic_vector (3 downto 0) := (others => '0');
  signal HIobj_green_dly : std_logic_vector (3 downto 0) := (others => '0');
-- Registered Hi object enable display signals
  signal enable_HIobj      :  std_logic;
  signal enable_HIobj_dly  :  std_logic;
  signal DispHI            :  std_logic;
  

  signal ObjHI_xpos : std_logic_vector (11 downto 0) := B"0010_0000_0000";--(others => '0');
  signal ObjHI_ypos : std_logic_vector (11 downto 0) := B"0001_1000_0000";--(others => '0');
  
  
    -----------------------------------------------------------
  -- Signals for generating the background (moving colorbar)
  -----------------------------------------------------------
  signal cntDyn                 : integer range 0 to 2**28-1; -- counter for generating the colorbar
  signal intHcnt                : integer range 0 to H_MAX - 1;
  signal intVcnt                : integer range 0 to V_MAX - 1;
  -- Colorbar red, greeen and blue signals
  signal bg_red                 : std_logic_vector(3 downto 0);
  signal bg_blue                : std_logic_vector(3 downto 0);
  signal bg_green               : std_logic_vector(3 downto 0);
  -- Pipe the colorbar red, green and blue signals
  signal bg_red_dly             : std_logic_vector(3 downto 0) := (others => '0');
  signal bg_green_dly           : std_logic_vector(3 downto 0) := (others => '0');
  signal bg_blue_dly            : std_logic_vector(3 downto 0) := (others => '0');
  
  -- VARIABLES FOR THE CHECKER BOARD
  signal bgBW                   : std_logic;                      -- when calculating black/white checker board
  signal bgRGB                  : unsigned(4 downto 0);   -- when calculating color checker board
  signal bgRGB4                 : std_logic_vector(3 downto 0);   -- when calculating color checker board
  signal BOXIDx                 : unsigned(4 downto 0);
  signal BOXIDy                 : unsigned(4 downto 0);
  



begin
  

-- In this demonstration, we will use ROTangle to manipulate the  
-- x,y position of the "HI" object. 
  ObjHI_xpos <= "00"   &   ROTangle(15 downto 12) & "000000";
  ObjHI_ypos <= "000"  &   ROTangle(11 downto 8)  & "00000";
  
            
  clk_wiz_0_inst : entity work.clk_wiz_0
  port map
   (clk_in1 => CLK_I,
    clk_out1 => pxl_clk);
  
       ---------------------------------------------------------------
       
       -- Generate Horizontal, Vertical counters and the Sync signals
       
       ---------------------------------------------------------------
         -- Horizontal counter
         process (pxl_clk)
         begin
           if (rising_edge(pxl_clk)) then
             if (h_cntr_reg = (H_MAX - 1)) then
               h_cntr_reg <= (others =>'0');
             else
               h_cntr_reg <= h_cntr_reg + 1;
             end if;
           end if;
           if (SW(15) = '0' and SW(14) = '0') then
                h_cntr_reg <= "000000001000";
           elsif (SW(15) = '0' and SW(14) = '1') then
                h_cntr_reg <= "000000010000";
           end if;
         end process;
         -- Vertical counter
         process (pxl_clk)
         begin
           if (rising_edge(pxl_clk)) then
             if ((h_cntr_reg = (H_MAX - 1)) and (v_cntr_reg = (V_MAX - 1))) then
               v_cntr_reg <= (others =>'0');
             elsif (h_cntr_reg = (H_MAX - 1)) then
               v_cntr_reg <= v_cntr_reg + 1;
             end if;
           end if;
           if (SW(15) = '1' and SW(14) = '0') then
                v_cntr_reg <= "000000001010";
           elsif (SW(15) = '1' and SW(14) = '1') then
                v_cntr_reg <= "000000010100";
           end if;
         end process;
         -- Horizontal sync
         process (pxl_clk)
         begin
           if (rising_edge(pxl_clk)) then
             if (h_cntr_reg >= (H_FP + FRAME_WIDTH - 1)) and (h_cntr_reg < (H_FP + FRAME_WIDTH + H_PW - 1)) then
               h_sync_reg <= H_POL;
             else
               h_sync_reg <= not(H_POL);
             end if;
           end if;
         end process;
         -- Vertical sync
         process (pxl_clk)
         begin
           if (rising_edge(pxl_clk)) then
             if (v_cntr_reg >= (V_FP + FRAME_HEIGHT - 1)) and (v_cntr_reg < (V_FP + FRAME_HEIGHT + V_PW - 1)) then
               v_sync_reg <= V_POL;
             else
               v_sync_reg <= not(V_POL);
             end if;
           end if;
         end process;
         
       --------------------
       
       -- The active 
       
       --------------------  
         -- active signal
         active <= '1' when h_cntr_reg_dly < FRAME_WIDTH and v_cntr_reg_dly < FRAME_HEIGHT  else '0';
     ----------------------------------
     
     -- HI object display instance
     
     ----------------------------------
        Inst_HIobj: entity work.HI_object
        PORT MAP 
        (
           pixel_clk   => pxl_clk,
           xpos        => ObjHI_xpos, 
           ypos        => ObjHI_ypos,
           theta       => ROTangle,
           hcount      => h_cntr_reg,
           vcount      => v_cntr_reg,
           enable_HIobj_out  => enable_HIobj,
           red_out     => HIobj_red,
           green_out   => HIobj_green,
           blue_out    => HIobj_blue
        );
    
    ---------------------------------------------------------------------------------------------------
    
    -- Register Outputs coming from the displaying components and the horizontal and vertical counters
    
    ---------------------------------------------------------------------------------------------------
      process (pxl_clk)
      begin
        if (rising_edge(pxl_clk)) then
      
            bg_red_dly       <= bg_red;
            bg_green_dly     <= bg_green;
            bg_blue_dly      <= bg_blue;
            
            HIobj_red_dly    <= HIobj_red;
            HIobj_blue_dly   <= HIobj_blue;
            HIobj_green_dly  <= HIobj_green;

            enable_HIobj_dly   <= enable_HIobj;

            h_cntr_reg_dly   <= h_cntr_reg;
            v_cntr_reg_dly   <= v_cntr_reg;

        end if;
      end process;

    ----------------------------------
    
    -- VGA Output Muxing
    
    ----------------------------------

    -- vga_red   <= HIobj_red_dly;
    -- vga_green <= HIobj_green_dly;
    -- vga_blue  <= HIobj_blue_dly;
    
    BOXIDx <= unsigned(h_cntr_reg(11 downto 7));
	BOXIDy <= unsigned(v_cntr_reg(11 downto 7));
	
	 

	
	process(VGAoptions) begin
	    bgBW  <= BOXIDx(0) xor BOXIDy(0);
	    if (SW(13) = '0') then
            bgBW <= '0';
        end if;
   	    bgRGB <=  BOXIDx + BOXIDy;
        bgRGB4 <= std_logic_vector(bgRGB(3 downto 0));
	    --------------------------------------------------------
	    ----------- B&W checker board alternating -------------- 
	    --------------------------------------------------------
        if(VGAoptions(15)='1' or VGAoptions(14)='1') then
	        bgBW  <= BOXIDx(0) xor BOXIDy(0) xor ROTangle(11);
	    end if;
       	bg_red     <= "0000";
	    bg_green   <= "0000";
	    bg_blue    <= "0000";
        if (bgBW = '1') then
       	    bg_red     <= "1111";
	        bg_green   <= "1111";
	        bg_blue    <= "1111";
	    
            -----------------------------------------------------------------------
            ----------- Checker board alternating through W, R, G, B -------------- 
            -----------------------------------------------------------------------
            if(VGAoptions(14) = '1') then
                case (ROTangle(13 downto 12)) is
                    when "00" => 
                    when "01" =>    bg_green <= "0000";        bg_blue  <= "0000";   
                    when "10" =>    bg_red  <= "0000";         bg_blue  <= "0000";
                    when "11" =>    bg_red  <= "0000";         bg_green   <= "0000";
                end case;
             end if;
         end if;  --  bgBW = '1' 
    	
    	
        -----------------------------------------------------------------------
        ----------- Colorful checker board. NOT alternating ------------------- 
        -----------------------------------------------------------------------
    	if(VGAoptions(13) = '1') then
   		    bg_red    <= "0000";
  		    bg_green  <= "0000";
   		    bg_blue   <= "0000";
	        case bgRGB4 is
	           when "0000" | "1110" | "1010"  =>                                                            bg_blue   <= "1111";        
    	       when "0001" | "1111"           =>      bg_red    <= "1111";      bg_green    <= "1111";
	           when "0010"                    =>      bg_red    <= "1111";      bg_green    <= "0111";
    	       when "0011"                    =>      bg_red    <= "1000";    
    	       when "0100"                    =>      bg_red    <= "1111";      bg_green    <= "1111";      bg_blue   <= "1111"; 
    	       when "0101"                    =>               
    	       when "0110" | "1011"           =>      bg_red    <= "1111";                                  bg_blue   <= "1111";
    	       when "0111"                    =>                                                            bg_blue   <= "1100";
    	       when "1000" | "1100"           =>      bg_red    <= "1111";
    	       when "1001" | "1101"           =>                                bg_green    <= "1111";
	       end case;
	    end if;   -- VGAoptions(13) = '1'
    end process;

    
   
    DispHI <= VGAoptions(12) and enable_HIobj_dly;

	vga_red   <= bg_red_dly      when      DispHI = '0'      else        HIobj_red_dly;
    vga_green <= bg_green_dly    when      DispHI = '0'      else        HIobj_green_dly;
    vga_blue  <= bg_blue_dly     when      DispHI = '0'      else        HIobj_blue_dly;


           
--	vga_red   <= bg_red_dly;
--    vga_green <= bg_green_dly;
--    vga_blue  <= bg_blue_dly;


           
    ------------------------------------------------------------
    -- Turn Off VGA RBG Signals if outside of the active screen
    -- Make a 4-bit AND logic with the R, G and B signals
    ------------------------------------------------------------
    vga_red_cmb <= (active & active & active & active) and vga_red;
    vga_green_cmb <= (active & active & active & active) and vga_green;
    vga_blue_cmb <= (active & active & active & active) and vga_blue;
    
    
    -- Register Outputs
     process (pxl_clk)
     begin
       if (rising_edge(pxl_clk)) then
    
         v_sync_reg_dly <= v_sync_reg;
         h_sync_reg_dly <= h_sync_reg;
         vga_red_reg    <= vga_red_cmb;
         vga_green_reg  <= vga_green_cmb;
         vga_blue_reg   <= vga_blue_cmb;      
       end if;
     end process;
    
     -- Assign outputs
     VGA_HS_O     <= h_sync_reg_dly;
     VGA_VS_O     <= v_sync_reg_dly;
     VGA_RED_O    <= vga_red_reg;
     VGA_GREEN_O  <= vga_green_reg;
     VGA_BLUE_O   <= vga_blue_reg;

end Behavioral;

