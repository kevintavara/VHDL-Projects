-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Mon Jan 27 12:48:31 2020
-- Host        : ENGR3204-03 running 64-bit major release  (build 9200)
-- Command     : write_vhdl C:/Users/vselabs/Desktop/Test/ALU1/ALU.vhd
-- Design      : ALU
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ALU is
  port (
    A : in STD_LOGIC_VECTOR ( 3 downto 0 );
    B : in STD_LOGIC_VECTOR ( 3 downto 0 );
    OPCODE : in STD_LOGIC_VECTOR ( 2 downto 0 );
    C : out STD_LOGIC;
    V : out STD_LOGIC;
    X : out STD_LOGIC_VECTOR ( 3 downto 0 );
    Y : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of ALU : entity is true;
end ALU;

architecture STRUCTURE of ALU is
  signal A_IBUF : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal B_IBUF : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal C_OBUF : STD_LOGIC;
  signal OPCODE_IBUF : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal V_OBUF : STD_LOGIC;
  signal V_OBUF_inst_i_2_n_0 : STD_LOGIC;
  signal V_OBUF_inst_i_3_n_0 : STD_LOGIC;
  signal V_OBUF_inst_i_4_n_0 : STD_LOGIC;
  signal X_OBUF : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \X_OBUF[1]_inst_i_2_n_0\ : STD_LOGIC;
  signal \X_OBUF[1]_inst_i_3_n_0\ : STD_LOGIC;
  signal \X_OBUF[2]_inst_i_2_n_0\ : STD_LOGIC;
  signal \X_OBUF[2]_inst_i_3_n_0\ : STD_LOGIC;
  signal \X_OBUF[2]_inst_i_4_n_0\ : STD_LOGIC;
  signal \X_OBUF[2]_inst_i_5_n_0\ : STD_LOGIC;
  signal \X_OBUF[2]_inst_i_6_n_0\ : STD_LOGIC;
  signal \X_OBUF[3]_inst_i_2_n_0\ : STD_LOGIC;
  signal \X_OBUF[3]_inst_i_3_n_0\ : STD_LOGIC;
  signal \X_OBUF[3]_inst_i_4_n_0\ : STD_LOGIC;
  signal Y_OBUF : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \Y_OBUF[1]_inst_i_10_n_0\ : STD_LOGIC;
  signal \Y_OBUF[1]_inst_i_11_n_0\ : STD_LOGIC;
  signal \Y_OBUF[1]_inst_i_12_n_0\ : STD_LOGIC;
  signal \Y_OBUF[1]_inst_i_13_n_0\ : STD_LOGIC;
  signal \Y_OBUF[1]_inst_i_14_n_0\ : STD_LOGIC;
  signal \Y_OBUF[1]_inst_i_15_n_0\ : STD_LOGIC;
  signal \Y_OBUF[1]_inst_i_16_n_0\ : STD_LOGIC;
  signal \Y_OBUF[1]_inst_i_2_n_0\ : STD_LOGIC;
  signal \Y_OBUF[1]_inst_i_2_n_1\ : STD_LOGIC;
  signal \Y_OBUF[1]_inst_i_2_n_2\ : STD_LOGIC;
  signal \Y_OBUF[1]_inst_i_2_n_3\ : STD_LOGIC;
  signal \Y_OBUF[1]_inst_i_2_n_6\ : STD_LOGIC;
  signal \Y_OBUF[1]_inst_i_2_n_7\ : STD_LOGIC;
  signal \Y_OBUF[1]_inst_i_3_n_0\ : STD_LOGIC;
  signal \Y_OBUF[1]_inst_i_4_n_0\ : STD_LOGIC;
  signal \Y_OBUF[1]_inst_i_5_n_0\ : STD_LOGIC;
  signal \Y_OBUF[1]_inst_i_6_n_0\ : STD_LOGIC;
  signal \Y_OBUF[1]_inst_i_7_n_0\ : STD_LOGIC;
  signal \Y_OBUF[1]_inst_i_8_n_0\ : STD_LOGIC;
  signal \Y_OBUF[1]_inst_i_9_n_0\ : STD_LOGIC;
  signal \Y_OBUF[3]_inst_i_2_n_2\ : STD_LOGIC;
  signal \Y_OBUF[3]_inst_i_3_n_0\ : STD_LOGIC;
  signal \Y_OBUF[3]_inst_i_4_n_0\ : STD_LOGIC;
  signal \Y_OBUF[3]_inst_i_5_n_0\ : STD_LOGIC;
  signal \Y_OBUF[3]_inst_i_6_n_0\ : STD_LOGIC;
  signal \Y_OBUF[3]_inst_i_7_n_0\ : STD_LOGIC;
  signal \op8__0\ : STD_LOGIC_VECTOR ( 6 downto 4 );
  signal \NLW_Y_OBUF[3]_inst_i_2_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_Y_OBUF[3]_inst_i_2_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of C_OBUF_inst_i_1 : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of V_OBUF_inst_i_2 : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \X_OBUF[0]_inst_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \X_OBUF[3]_inst_i_4\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \Y_OBUF[0]_inst_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \Y_OBUF[1]_inst_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \Y_OBUF[1]_inst_i_14\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \Y_OBUF[1]_inst_i_16\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \Y_OBUF[2]_inst_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \Y_OBUF[3]_inst_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \Y_OBUF[3]_inst_i_6\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \Y_OBUF[3]_inst_i_7\ : label is "soft_lutpair3";
begin
\A_IBUF[0]_inst\: unisim.vcomponents.IBUF
     port map (
      I => A(0),
      O => A_IBUF(0)
    );
\A_IBUF[1]_inst\: unisim.vcomponents.IBUF
     port map (
      I => A(1),
      O => A_IBUF(1)
    );
\A_IBUF[2]_inst\: unisim.vcomponents.IBUF
     port map (
      I => A(2),
      O => A_IBUF(2)
    );
\A_IBUF[3]_inst\: unisim.vcomponents.IBUF
     port map (
      I => A(3),
      O => A_IBUF(3)
    );
\B_IBUF[0]_inst\: unisim.vcomponents.IBUF
     port map (
      I => B(0),
      O => B_IBUF(0)
    );
\B_IBUF[1]_inst\: unisim.vcomponents.IBUF
     port map (
      I => B(1),
      O => B_IBUF(1)
    );
\B_IBUF[2]_inst\: unisim.vcomponents.IBUF
     port map (
      I => B(2),
      O => B_IBUF(2)
    );
\B_IBUF[3]_inst\: unisim.vcomponents.IBUF
     port map (
      I => B(3),
      O => B_IBUF(3)
    );
C_OBUF_inst: unisim.vcomponents.OBUF
     port map (
      I => C_OBUF,
      O => C
    );
C_OBUF_inst_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => A_IBUF(3),
      I1 => B_IBUF(3),
      O => C_OBUF
    );
\OPCODE_IBUF[0]_inst\: unisim.vcomponents.IBUF
     port map (
      I => OPCODE(0),
      O => OPCODE_IBUF(0)
    );
\OPCODE_IBUF[1]_inst\: unisim.vcomponents.IBUF
     port map (
      I => OPCODE(1),
      O => OPCODE_IBUF(1)
    );
\OPCODE_IBUF[2]_inst\: unisim.vcomponents.IBUF
     port map (
      I => OPCODE(2),
      O => OPCODE_IBUF(2)
    );
V_OBUF_inst: unisim.vcomponents.OBUF
     port map (
      I => V_OBUF,
      O => V
    );
V_OBUF_inst_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0808800220208002"
    )
        port map (
      I0 => V_OBUF_inst_i_2_n_0,
      I1 => B_IBUF(3),
      I2 => A_IBUF(3),
      I3 => V_OBUF_inst_i_3_n_0,
      I4 => OPCODE_IBUF(0),
      I5 => V_OBUF_inst_i_4_n_0,
      O => V_OBUF
    );
V_OBUF_inst_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => OPCODE_IBUF(2),
      I1 => OPCODE_IBUF(1),
      O => V_OBUF_inst_i_2_n_0
    );
V_OBUF_inst_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1117177717771777"
    )
        port map (
      I0 => A_IBUF(2),
      I1 => B_IBUF(2),
      I2 => A_IBUF(1),
      I3 => B_IBUF(1),
      I4 => B_IBUF(0),
      I5 => A_IBUF(0),
      O => V_OBUF_inst_i_3_n_0
    );
V_OBUF_inst_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D4DD0000FFFFD4DD"
    )
        port map (
      I0 => B_IBUF(1),
      I1 => A_IBUF(1),
      I2 => A_IBUF(0),
      I3 => B_IBUF(0),
      I4 => A_IBUF(2),
      I5 => B_IBUF(2),
      O => V_OBUF_inst_i_4_n_0
    );
\X_OBUF[0]_inst\: unisim.vcomponents.OBUF
     port map (
      I => X_OBUF(0),
      O => X(0)
    );
\X_OBUF[0]_inst_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"C03C6917"
    )
        port map (
      I0 => OPCODE_IBUF(0),
      I1 => A_IBUF(0),
      I2 => B_IBUF(0),
      I3 => OPCODE_IBUF(1),
      I4 => OPCODE_IBUF(2),
      O => X_OBUF(0)
    );
\X_OBUF[1]_inst\: unisim.vcomponents.OBUF
     port map (
      I => X_OBUF(1),
      O => X(1)
    );
\X_OBUF[1]_inst_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \X_OBUF[1]_inst_i_2_n_0\,
      I1 => \X_OBUF[1]_inst_i_3_n_0\,
      O => X_OBUF(1),
      S => OPCODE_IBUF(2)
    );
\X_OBUF[1]_inst_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8070708FF00F0FFF"
    )
        port map (
      I0 => B_IBUF(0),
      I1 => A_IBUF(0),
      I2 => OPCODE_IBUF(1),
      I3 => A_IBUF(1),
      I4 => B_IBUF(1),
      I5 => OPCODE_IBUF(0),
      O => \X_OBUF[1]_inst_i_2_n_0\
    );
\X_OBUF[1]_inst_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6869C866A8960866"
    )
        port map (
      I0 => A_IBUF(1),
      I1 => B_IBUF(1),
      I2 => OPCODE_IBUF(0),
      I3 => OPCODE_IBUF(1),
      I4 => B_IBUF(0),
      I5 => A_IBUF(0),
      O => \X_OBUF[1]_inst_i_3_n_0\
    );
\X_OBUF[2]_inst\: unisim.vcomponents.OBUF
     port map (
      I => X_OBUF(2),
      O => X(2)
    );
\X_OBUF[2]_inst_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \X_OBUF[2]_inst_i_2_n_0\,
      I1 => \X_OBUF[2]_inst_i_3_n_0\,
      O => X_OBUF(2),
      S => OPCODE_IBUF(2)
    );
\X_OBUF[2]_inst_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"888BC33F"
    )
        port map (
      I0 => \X_OBUF[2]_inst_i_4_n_0\,
      I1 => OPCODE_IBUF(1),
      I2 => A_IBUF(2),
      I3 => B_IBUF(2),
      I4 => OPCODE_IBUF(0),
      O => \X_OBUF[2]_inst_i_2_n_0\
    );
\X_OBUF[2]_inst_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B888FFFFB8880000"
    )
        port map (
      I0 => \Y_OBUF[1]_inst_i_2_n_7\,
      I1 => OPCODE_IBUF(0),
      I2 => A_IBUF(2),
      I3 => B_IBUF(2),
      I4 => OPCODE_IBUF(1),
      I5 => \X_OBUF[2]_inst_i_5_n_0\,
      O => \X_OBUF[2]_inst_i_3_n_0\
    );
\X_OBUF[2]_inst_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F880077F077FF880"
    )
        port map (
      I0 => A_IBUF(0),
      I1 => B_IBUF(0),
      I2 => B_IBUF(1),
      I3 => A_IBUF(1),
      I4 => B_IBUF(2),
      I5 => A_IBUF(2),
      O => \X_OBUF[2]_inst_i_4_n_0\
    );
\X_OBUF[2]_inst_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8ABF15DF7540EA20"
    )
        port map (
      I0 => OPCODE_IBUF(0),
      I1 => A_IBUF(0),
      I2 => B_IBUF(0),
      I3 => B_IBUF(1),
      I4 => A_IBUF(1),
      I5 => \X_OBUF[2]_inst_i_6_n_0\,
      O => \X_OBUF[2]_inst_i_5_n_0\
    );
\X_OBUF[2]_inst_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => A_IBUF(2),
      I1 => B_IBUF(2),
      O => \X_OBUF[2]_inst_i_6_n_0\
    );
\X_OBUF[3]_inst\: unisim.vcomponents.OBUF
     port map (
      I => X_OBUF(3),
      O => X(3)
    );
\X_OBUF[3]_inst_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \X_OBUF[3]_inst_i_2_n_0\,
      I1 => \X_OBUF[3]_inst_i_3_n_0\,
      O => X_OBUF(3),
      S => OPCODE_IBUF(2)
    );
\X_OBUF[3]_inst_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"4887C33F"
    )
        port map (
      I0 => V_OBUF_inst_i_3_n_0,
      I1 => OPCODE_IBUF(1),
      I2 => B_IBUF(3),
      I3 => A_IBUF(3),
      I4 => OPCODE_IBUF(0),
      O => \X_OBUF[3]_inst_i_2_n_0\
    );
\X_OBUF[3]_inst_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B888FFFFB8880000"
    )
        port map (
      I0 => \Y_OBUF[1]_inst_i_2_n_6\,
      I1 => OPCODE_IBUF(0),
      I2 => B_IBUF(3),
      I3 => A_IBUF(3),
      I4 => OPCODE_IBUF(1),
      I5 => \X_OBUF[3]_inst_i_4_n_0\,
      O => \X_OBUF[3]_inst_i_3_n_0\
    );
\X_OBUF[3]_inst_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"47B8B847"
    )
        port map (
      I0 => V_OBUF_inst_i_4_n_0,
      I1 => OPCODE_IBUF(0),
      I2 => V_OBUF_inst_i_3_n_0,
      I3 => B_IBUF(3),
      I4 => A_IBUF(3),
      O => \X_OBUF[3]_inst_i_4_n_0\
    );
\Y_OBUF[0]_inst\: unisim.vcomponents.OBUF
     port map (
      I => Y_OBUF(0),
      O => Y(0)
    );
\Y_OBUF[0]_inst_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => \op8__0\(4),
      I1 => OPCODE_IBUF(0),
      I2 => OPCODE_IBUF(2),
      I3 => OPCODE_IBUF(1),
      O => Y_OBUF(0)
    );
\Y_OBUF[1]_inst\: unisim.vcomponents.OBUF
     port map (
      I => Y_OBUF(1),
      O => Y(1)
    );
\Y_OBUF[1]_inst_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => \op8__0\(5),
      I1 => OPCODE_IBUF(0),
      I2 => OPCODE_IBUF(2),
      I3 => OPCODE_IBUF(1),
      O => Y_OBUF(1)
    );
\Y_OBUF[1]_inst_i_10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"80000000E8A0C080"
    )
        port map (
      I0 => A_IBUF(0),
      I1 => B_IBUF(0),
      I2 => \Y_OBUF[1]_inst_i_14_n_0\,
      I3 => A_IBUF(2),
      I4 => B_IBUF(2),
      I5 => \Y_OBUF[1]_inst_i_15_n_0\,
      O => \Y_OBUF[1]_inst_i_10_n_0\
    );
\Y_OBUF[1]_inst_i_11\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000EAC0EAC0EAC0"
    )
        port map (
      I0 => B_IBUF(2),
      I1 => A_IBUF(2),
      I2 => B_IBUF(1),
      I3 => A_IBUF(1),
      I4 => A_IBUF(3),
      I5 => B_IBUF(0),
      O => \Y_OBUF[1]_inst_i_11_n_0\
    );
\Y_OBUF[1]_inst_i_12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9A599A9A59599A59"
    )
        port map (
      I0 => \Y_OBUF[1]_inst_i_16_n_0\,
      I1 => \Y_OBUF[3]_inst_i_7_n_0\,
      I2 => \Y_OBUF[1]_inst_i_11_n_0\,
      I3 => \Y_OBUF[1]_inst_i_15_n_0\,
      I4 => \Y_OBUF[3]_inst_i_6_n_0\,
      I5 => \Y_OBUF[1]_inst_i_13_n_0\,
      O => \Y_OBUF[1]_inst_i_12_n_0\
    );
\Y_OBUF[1]_inst_i_13\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3777FFFF3FFF7FFF"
    )
        port map (
      I0 => A_IBUF(0),
      I1 => B_IBUF(0),
      I2 => B_IBUF(1),
      I3 => A_IBUF(1),
      I4 => A_IBUF(2),
      I5 => B_IBUF(2),
      O => \Y_OBUF[1]_inst_i_13_n_0\
    );
\Y_OBUF[1]_inst_i_14\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => A_IBUF(1),
      I1 => B_IBUF(1),
      O => \Y_OBUF[1]_inst_i_14_n_0\
    );
\Y_OBUF[1]_inst_i_15\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8777788878887888"
    )
        port map (
      I0 => B_IBUF(0),
      I1 => A_IBUF(3),
      I2 => A_IBUF(2),
      I3 => B_IBUF(1),
      I4 => A_IBUF(1),
      I5 => B_IBUF(2),
      O => \Y_OBUF[1]_inst_i_15_n_0\
    );
\Y_OBUF[1]_inst_i_16\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4F3F"
    )
        port map (
      I0 => B_IBUF(1),
      I1 => A_IBUF(2),
      I2 => B_IBUF(2),
      I3 => A_IBUF(3),
      O => \Y_OBUF[1]_inst_i_16_n_0\
    );
\Y_OBUF[1]_inst_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \Y_OBUF[1]_inst_i_2_n_0\,
      CO(2) => \Y_OBUF[1]_inst_i_2_n_1\,
      CO(1) => \Y_OBUF[1]_inst_i_2_n_2\,
      CO(0) => \Y_OBUF[1]_inst_i_2_n_3\,
      CYINIT => '0',
      DI(3) => \Y_OBUF[1]_inst_i_3_n_0\,
      DI(2) => \Y_OBUF[1]_inst_i_4_n_0\,
      DI(1) => \Y_OBUF[1]_inst_i_5_n_0\,
      DI(0) => '0',
      O(3 downto 2) => \op8__0\(5 downto 4),
      O(1) => \Y_OBUF[1]_inst_i_2_n_6\,
      O(0) => \Y_OBUF[1]_inst_i_2_n_7\,
      S(3) => \Y_OBUF[1]_inst_i_6_n_0\,
      S(2) => \Y_OBUF[1]_inst_i_7_n_0\,
      S(1) => \Y_OBUF[1]_inst_i_8_n_0\,
      S(0) => \Y_OBUF[1]_inst_i_9_n_0\
    );
\Y_OBUF[1]_inst_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9666699969996999"
    )
        port map (
      I0 => \Y_OBUF[1]_inst_i_10_n_0\,
      I1 => \Y_OBUF[1]_inst_i_11_n_0\,
      I2 => B_IBUF(2),
      I3 => A_IBUF(2),
      I4 => B_IBUF(1),
      I5 => A_IBUF(3),
      O => \Y_OBUF[1]_inst_i_3_n_0\
    );
\Y_OBUF[1]_inst_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \Y_OBUF[1]_inst_i_3_n_0\,
      O => \Y_OBUF[1]_inst_i_4_n_0\
    );
\Y_OBUF[1]_inst_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => B_IBUF(3),
      I1 => A_IBUF(0),
      O => \Y_OBUF[1]_inst_i_5_n_0\
    );
\Y_OBUF[1]_inst_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6999"
    )
        port map (
      I0 => \Y_OBUF[1]_inst_i_3_n_0\,
      I1 => \Y_OBUF[1]_inst_i_12_n_0\,
      I2 => B_IBUF(3),
      I3 => A_IBUF(2),
      O => \Y_OBUF[1]_inst_i_6_n_0\
    );
\Y_OBUF[1]_inst_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => \Y_OBUF[1]_inst_i_3_n_0\,
      I1 => A_IBUF(1),
      I2 => B_IBUF(3),
      O => \Y_OBUF[1]_inst_i_7_n_0\
    );
\Y_OBUF[1]_inst_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6999999996666666"
    )
        port map (
      I0 => \Y_OBUF[1]_inst_i_5_n_0\,
      I1 => \Y_OBUF[1]_inst_i_13_n_0\,
      I2 => \Y_OBUF[1]_inst_i_14_n_0\,
      I3 => A_IBUF(0),
      I4 => B_IBUF(2),
      I5 => \Y_OBUF[1]_inst_i_15_n_0\,
      O => \Y_OBUF[1]_inst_i_8_n_0\
    );
\Y_OBUF[1]_inst_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"66663CCC5AAAF000"
    )
        port map (
      I0 => A_IBUF(2),
      I1 => B_IBUF(2),
      I2 => A_IBUF(1),
      I3 => B_IBUF(1),
      I4 => B_IBUF(0),
      I5 => A_IBUF(0),
      O => \Y_OBUF[1]_inst_i_9_n_0\
    );
\Y_OBUF[2]_inst\: unisim.vcomponents.OBUF
     port map (
      I => Y_OBUF(2),
      O => Y(2)
    );
\Y_OBUF[2]_inst_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => \op8__0\(6),
      I1 => OPCODE_IBUF(0),
      I2 => OPCODE_IBUF(2),
      I3 => OPCODE_IBUF(1),
      O => Y_OBUF(2)
    );
\Y_OBUF[3]_inst\: unisim.vcomponents.OBUF
     port map (
      I => Y_OBUF(3),
      O => Y(3)
    );
\Y_OBUF[3]_inst_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
        port map (
      I0 => \Y_OBUF[3]_inst_i_2_n_2\,
      I1 => OPCODE_IBUF(0),
      I2 => OPCODE_IBUF(2),
      I3 => OPCODE_IBUF(1),
      O => Y_OBUF(3)
    );
\Y_OBUF[3]_inst_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \Y_OBUF[1]_inst_i_2_n_0\,
      CO(3 downto 2) => \NLW_Y_OBUF[3]_inst_i_2_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \Y_OBUF[3]_inst_i_2_n_2\,
      CO(0) => \NLW_Y_OBUF[3]_inst_i_2_CO_UNCONNECTED\(0),
      CYINIT => '0',
      DI(3 downto 1) => B"000",
      DI(0) => \Y_OBUF[3]_inst_i_3_n_0\,
      O(3 downto 1) => \NLW_Y_OBUF[3]_inst_i_2_O_UNCONNECTED\(3 downto 1),
      O(0) => \op8__0\(6),
      S(3 downto 1) => B"001",
      S(0) => \Y_OBUF[3]_inst_i_4_n_0\
    );
\Y_OBUF[3]_inst_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"41CC113344331133"
    )
        port map (
      I0 => B_IBUF(3),
      I1 => \Y_OBUF[3]_inst_i_5_n_0\,
      I2 => B_IBUF(1),
      I3 => A_IBUF(2),
      I4 => B_IBUF(2),
      I5 => A_IBUF(3),
      O => \Y_OBUF[3]_inst_i_3_n_0\
    );
\Y_OBUF[3]_inst_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFFFFFC3B3FF4FFF"
    )
        port map (
      I0 => B_IBUF(1),
      I1 => A_IBUF(2),
      I2 => A_IBUF(3),
      I3 => B_IBUF(2),
      I4 => \Y_OBUF[3]_inst_i_5_n_0\,
      I5 => B_IBUF(3),
      O => \Y_OBUF[3]_inst_i_4_n_0\
    );
\Y_OBUF[3]_inst_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"4D00FF4D"
    )
        port map (
      I0 => \Y_OBUF[1]_inst_i_13_n_0\,
      I1 => \Y_OBUF[3]_inst_i_6_n_0\,
      I2 => \Y_OBUF[1]_inst_i_15_n_0\,
      I3 => \Y_OBUF[1]_inst_i_11_n_0\,
      I4 => \Y_OBUF[3]_inst_i_7_n_0\,
      O => \Y_OBUF[3]_inst_i_5_n_0\
    );
\Y_OBUF[3]_inst_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => B_IBUF(2),
      I1 => A_IBUF(0),
      I2 => B_IBUF(1),
      I3 => A_IBUF(1),
      O => \Y_OBUF[3]_inst_i_6_n_0\
    );
\Y_OBUF[3]_inst_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7888"
    )
        port map (
      I0 => B_IBUF(2),
      I1 => A_IBUF(2),
      I2 => B_IBUF(1),
      I3 => A_IBUF(3),
      O => \Y_OBUF[3]_inst_i_7_n_0\
    );
end STRUCTURE;
