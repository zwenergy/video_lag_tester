--Copyright (C)2014-2022 Gowin Semiconductor Corporation.
--All rights reserved.
--File Title: IP file
--GOWIN Version: V1.9.8.05
--Part Number: GW1NSR-LV4CQN48PC6/I5
--Device: GW1NSR-4C
--Created Time: Fri Jan 06 11:19:04 2023

library IEEE;
use IEEE.std_logic_1164.all;

entity Gowin_PLLVR_dyn_r is
    port (
        clkout: out std_logic;
        reset: in std_logic;
        clkin: in std_logic;
        fbdsel: in std_logic_vector(5 downto 0);
        idsel: in std_logic_vector(5 downto 0);
        odsel: in std_logic_vector(5 downto 0)
    );
end Gowin_PLLVR_dyn_r;

architecture Behavioral of Gowin_PLLVR_dyn_r is

    signal lock_o: std_logic;
    signal clkoutp_o: std_logic;
    signal clkoutd_o: std_logic;
    signal clkoutd3_o: std_logic;
    signal gw_vcc: std_logic;
    signal gw_gnd: std_logic;
    signal PSDA_i: std_logic_vector(3 downto 0);
    signal DUTYDA_i: std_logic_vector(3 downto 0);
    signal FDLY_i: std_logic_vector(3 downto 0);

    --component declaration
    component PLLVR
        generic (
            FCLKIN: in string := "100.0";
            DEVICE: in string := "GW1NS-4";
            DYN_IDIV_SEL: in string := "false";
            IDIV_SEL: in integer := 0;
            DYN_FBDIV_SEL: in string := "false";
            FBDIV_SEL: in integer := 0;
            DYN_ODIV_SEL: in string := "false";
            ODIV_SEL: in integer := 8;
            PSDA_SEL: in string := "0000";
            DYN_DA_EN: in string := "false";
            DUTYDA_SEL: in string := "1000";
            CLKOUT_FT_DIR: in bit := '1';
            CLKOUTP_FT_DIR: in bit := '1';
            CLKOUT_DLY_STEP: in integer := 0;
            CLKOUTP_DLY_STEP: in integer := 0;
            CLKOUTD3_SRC: in string := "CLKOUT";
            CLKFB_SEL: in string := "internal";
            CLKOUT_BYPASS: in string := "false";
            CLKOUTP_BYPASS: in string := "false";
            CLKOUTD_BYPASS: in string := "false";
            CLKOUTD_SRC: in string := "CLKOUT";
            DYN_SDIV_SEL: in integer := 2
        );
        port (
            CLKOUT: out std_logic;
            LOCK: out std_logic;
            CLKOUTP: out std_logic;
            CLKOUTD: out std_logic;
            CLKOUTD3: out std_logic;
            RESET: in std_logic;
            RESET_P: in std_logic;
            CLKIN: in std_logic;
            CLKFB: in std_logic;
            FBDSEL: in std_logic_vector(5 downto 0);
            IDSEL: in std_logic_vector(5 downto 0);
            ODSEL: in std_logic_vector(5 downto 0);
            PSDA: in std_logic_vector(3 downto 0);
            DUTYDA: in std_logic_vector(3 downto 0);
            FDLY: in std_logic_vector(3 downto 0);
            VREN: in std_logic
        );
    end component;

begin
    gw_vcc <= '1';
    gw_gnd <= '0';

    PSDA_i <= gw_gnd & gw_gnd & gw_gnd & gw_gnd;
    DUTYDA_i <= gw_gnd & gw_gnd & gw_gnd & gw_gnd;
    FDLY_i <= gw_gnd & gw_gnd & gw_gnd & gw_gnd;

    pllvr_inst: PLLVR
        generic map (
            FCLKIN => "27",
            DEVICE => "GW1NSR-4C",
            DYN_IDIV_SEL => "true",
            IDIV_SEL => 3,
            DYN_FBDIV_SEL => "true",
            FBDIV_SEL => 54,
            DYN_ODIV_SEL => "true",
            ODIV_SEL => 2,
            PSDA_SEL => "0000",
            DYN_DA_EN => "true",
            DUTYDA_SEL => "1000",
            CLKOUT_FT_DIR => '1',
            CLKOUTP_FT_DIR => '1',
            CLKOUT_DLY_STEP => 0,
            CLKOUTP_DLY_STEP => 0,
            CLKFB_SEL => "internal",
            CLKOUT_BYPASS => "false",
            CLKOUTP_BYPASS => "false",
            CLKOUTD_BYPASS => "false",
            DYN_SDIV_SEL => 2,
            CLKOUTD_SRC => "CLKOUT",
            CLKOUTD3_SRC => "CLKOUT"
        )
        port map (
            CLKOUT => clkout,
            LOCK => lock_o,
            CLKOUTP => clkoutp_o,
            CLKOUTD => clkoutd_o,
            CLKOUTD3 => clkoutd3_o,
            RESET => reset,
            RESET_P => gw_gnd,
            CLKIN => clkin,
            CLKFB => gw_gnd,
            FBDSEL => fbdsel,
            IDSEL => idsel,
            ODSEL => odsel,
            PSDA => PSDA_i,
            DUTYDA => DUTYDA_i,
            FDLY => FDLY_i,
            VREN => gw_vcc
        );

end Behavioral; --Gowin_PLLVR_dyn_r
