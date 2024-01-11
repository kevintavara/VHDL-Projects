library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity TopLevel_comp is port( 
	clock   : in  std_logic;						-- middle button (button-driven clock)
	clock1  : in  std_logic;						-- BASYS-3 onboard clock
	reset   : in  std_logic;						-- left button
	MSB     : in  std_logic;						-- upper button
	overflow: out std_logic;						-- LED 7
	zero    : out std_logic;						-- LED 5
	carryout: out std_logic;						-- LED 6
	pcout   : out std_logic_vector (4 downto 0);	-- LEDs 4-0 (Program Counter)
	enout   : out std_logic_vector (3 downto 0);	-- 7SD anodes
	dout    : out std_logic_vector (7 downto 0)		-- 7SD cathodes
	);
end TopLevel_comp;

architecture Behavioral of TopLevel_comp is

-- signal declarations
	signal dout1  : std_logic_vector(31 downto 0);
	signal qtemp1 : std_logic_vector(31 downto 0):= (others =>'0');
	signal qtemp  : std_logic_vector(18 downto 0):= (others =>'0');
	signal count  : std_logic_vector(1  downto 0);
	signal mout   : std_logic_vector(3  downto 0);
	signal moutlsb: std_logic_vector(3  downto 0);
	signal moutmsb: std_logic_vector(3  downto 0);
	signal temp   : std_logic_vector(7  downto 0);
	signal pcout1 : std_logic_vector(4  downto 0);
	--signal cnt1 : std_logic_vector(31  downto 0);
	signal zero_sig : std_logic := '0';
	signal clock_sig, clock1_sig, reset_sig : std_logic;

-- component declarations
--declare your block design wrapper here!
------------------------------------------------------------------------------
  component Datapath is
  port (
    Reset : in STD_LOGIC;
    clock : in STD_LOGIC;
    Overflow : out STD_LOGIC;
    Zero : out STD_LOGIC;
    ALUOut : out STD_LOGIC_VECTOR ( 31 downto 0 );
    Carryout : out STD_LOGIC
  );
  end component Datapath;
component Datapath_ALUCNTL_0_0 is
  port (
    Din : in STD_LOGIC_VECTOR ( 5 downto 0 );
    Dout : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  end component Datapath_ALUCNTL_0_0;
  component Datapath_Control_0_0 is
  port (
    Din : in STD_LOGIC_VECTOR ( 5 downto 0 );
    Dout : out STD_LOGIC
  );
  end component Datapath_Control_0_0;
  component Datapath_instmem_0_0 is
  port (
    read_inst : in STD_LOGIC_VECTOR ( 31 downto 0 );
    inst_out : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component Datapath_instmem_0_0;
  component Datapath_regfile_0_0 is
  port (
    clock : in STD_LOGIC;
    RegWrite : in STD_LOGIC;
    read_reg1 : in STD_LOGIC_VECTOR ( 4 downto 0 );
    read_reg2 : in STD_LOGIC_VECTOR ( 4 downto 0 );
    write_reg : in STD_LOGIC_VECTOR ( 4 downto 0 );
    write_data : in STD_LOGIC_VECTOR ( 31 downto 0 );
    read_data1 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    read_data2 : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component Datapath_regfile_0_0;
  component Datapath_xlslice_0_0 is
  port (
    Din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Dout : out STD_LOGIC_VECTOR ( 5 downto 0 )
  );
  end component Datapath_xlslice_0_0;
  component Datapath_xlslice_0_1 is
  port (
    Din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Dout : out STD_LOGIC_VECTOR ( 4 downto 0 )
  );
  end component Datapath_xlslice_0_1;
  component Datapath_xlslice_0_2 is
  port (
    Din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Dout : out STD_LOGIC_VECTOR ( 4 downto 0 )
  );
  end component Datapath_xlslice_0_2;
  component Datapath_xlslice_0_3 is
  port (
    Din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Dout : out STD_LOGIC_VECTOR ( 4 downto 0 )
  );
  end component Datapath_xlslice_0_3;
  component Datapath_xlslice_0_4 is
  port (
    Din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Dout : out STD_LOGIC_VECTOR ( 5 downto 0 )
  );
  end component Datapath_xlslice_0_4;
  component Datapath_ALU_0_0 is
  port (
    A : in STD_LOGIC_VECTOR ( 31 downto 0 );
    B : in STD_LOGIC_VECTOR ( 31 downto 0 );
    ALUCntl : in STD_LOGIC_VECTOR ( 3 downto 0 );
    ALUOut : out STD_LOGIC_VECTOR ( 31 downto 0 );
    Zero : out STD_LOGIC;
    Carryout : out STD_LOGIC;
    Overflow : out STD_LOGIC
  );
  end component Datapath_ALU_0_0;
  component Datapath_PC_0_0 is
  port (
    Din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    clock_0 : in STD_LOGIC;
    Reset_0 : in STD_LOGIC;
    Dout : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component Datapath_PC_0_0;
  component Datapath_PCADD_0_0 is
  port (
    Din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Dout : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component Datapath_PCADD_0_0;
------------------------------------------------------------------------------

	begin
	
-- Instantiate your block design wrapper here!
------------------------------------------------------------------------------
Datapath_i: component Datapath
     port map (
      ALUOut(31 downto 0) => dout1(31 downto 0),
      Carryout => carryout,
      Overflow => overflow,
      Reset => reset,
      Zero => zero,
      clock => clock
    );
------------------------------------------------------------------------------
	   

	----COUNTER FOR DISPLAY CIRCUIT-------------
cnt : process(clock1, reset)
		begin
		 	if reset='1' then
				qtemp <= (others=>'0');
			elsif (clock1'event and clock1='1') then
			 	qtemp <= qtemp + 1;
		   end if;
		end process;
cnt1 : process(clock, reset)
		begin
		 	if reset='1' then
				qtemp1 <= (others=>'0');
			elsif (clock'event and clock='1') then
			 	qtemp1 <= qtemp1 + 1;
		   end if;
		end process;
	--count <= qtemp(10 downto 9);		--uncomment this line during simulation
	count <= qtemp( 18 downto 17);		--comment this line during simulation
----2 TO 4 DECODER FOR 7-SEG ENABLE--------
with count select
	enout <= 
		"0111" when "00",
		"1011" when "01",
		"1101" when "10",
		"1110" when "11",
		"1111" when others;
		  
---LSB 4x1 MULTIPLEXER---------------------
with count select
	moutlsb <= 
		dout1(15 downto 12) when "00",
		dout1(11 downto  8) when "01",
		dout1(7  downto  4) when "10",
		dout1(3  downto  0) when "11",
		"0000" 				when others;
			
---MSB 4x1 MULTIPLEXER---------------------
with count select
	moutmsb <= 
		dout1(31 downto 28) when "00",
		dout1(27 downto 24) when "01",
		dout1(23 downto 20) when "10",
		dout1(19 downto 16) when "11",
		"0000" 				when others;
			
---2X1 MULTIPLEXER inPUT TO 7-SEGMENT CONVENTOR	
mout <= moutmsb when msb='1' else moutlsb;
--mout <= "0101";
--mout <= moutlsb;

----Hexto7seg------------------------
with mout select
	temp <= 
-- 7SD:	".gfedcba"
        "11000000" when "0000", -- 0
        "11111001" when "0001", -- 1
        "10100100" when "0010", -- 2
        "10110000" when "0011", -- 3
        "10011001" when "0100", -- 4
        "10010010" when "0101", -- 5
        "10000010" when "0110", -- 6
        "11111000" when "0111", -- 7
        "10000000" when "1000", -- 8
        "10010000" when "1001", -- 9
		"10001000" when "1010", -- A
		"10000011" when "1011", -- B
		"11000110" when "1100", -- C
		"10100001" when "1101", -- D
		"10000110" when "1110", -- E
		"10001110" when "1111", -- F
        "11111111" when others;
dout <=  (NOT msb) & temp( 6 downto 0);
--dout <= "10010010";
clock_sig <= clock;
clock1_sig <= clock1;
pcout <= qtemp1(4 downto 0);



	--count <= qtemp(10 downto 9);		--uncomment this line during simulation
	--dout1 <= x"000000" & cnt1(31 downto 24);		--comment this line during simulation
	
end Behavioral;

 
