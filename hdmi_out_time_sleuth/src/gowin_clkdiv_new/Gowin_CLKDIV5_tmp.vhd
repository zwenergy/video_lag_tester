--Copyright (C)2014-2022 Gowin Semiconductor Corporation.
--All rights reserved.
--File Title: Template file for instantiation
--GOWIN Version: V1.9.8.05
--Part Number: GW1NSR-LV4CQN48PC6/I5
--Device: GW1NSR-4C
--Created Time: Fri Jan 06 11:17:50 2023

--Change the instance name and port connections to the signal names
----------Copy here to design--------

component Gowin_CLKDIV5
    port (
        clkout: out std_logic;
        hclkin: in std_logic;
        resetn: in std_logic
    );
end component;

your_instance_name: Gowin_CLKDIV5
    port map (
        clkout => clkout_o,
        hclkin => hclkin_i,
        resetn => resetn_i
    );

----------Copy end-------------------
