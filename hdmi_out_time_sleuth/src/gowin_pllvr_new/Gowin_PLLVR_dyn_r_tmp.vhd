--Copyright (C)2014-2022 Gowin Semiconductor Corporation.
--All rights reserved.
--File Title: Template file for instantiation
--GOWIN Version: V1.9.8.05
--Part Number: GW1NSR-LV4CQN48PC6/I5
--Device: GW1NSR-4C
--Created Time: Fri Jan 06 11:19:04 2023

--Change the instance name and port connections to the signal names
----------Copy here to design--------

component Gowin_PLLVR_dyn_r
    port (
        clkout: out std_logic;
        reset: in std_logic;
        clkin: in std_logic;
        fbdsel: in std_logic_vector(5 downto 0);
        idsel: in std_logic_vector(5 downto 0);
        odsel: in std_logic_vector(5 downto 0)
    );
end component;

your_instance_name: Gowin_PLLVR_dyn_r
    port map (
        clkout => clkout_o,
        reset => reset_i,
        clkin => clkin_i,
        fbdsel => fbdsel_i,
        idsel => idsel_i,
        odsel => odsel_i
    );

----------Copy end-------------------
