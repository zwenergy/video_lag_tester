-----------------------------------------------------------------------
-- Title: Clock Generator
-- Author: zwenergy
-----------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clockGen is
  port(
    clkIn : in std_logic;
    rst : in std_logic;
    mode : in std_logic_vector( 4 downto 0 );
    modeClk : in std_logic;
    pxlClkx5 : out std_logic;
    pxlClk : out std_logic
  );
end clockGen;

architecture rtl of clockGen is
signal idsel, fbdsel, odsel: std_logic_vector( 5 downto 0 );
signal rstN, pxlClkx5_int : std_logic;

-- 480p
-- MODE: 10111
constant IDSEL_480P : std_logic_vector := std_logic_vector( to_unsigned( 64 - 1, idsel'length ) );
constant FBDSEL_480P : std_logic_vector := std_logic_vector( to_unsigned( 64 - 5, idsel'length ) );
constant ODSEL_480P : std_logic_vector := std_logic_vector( to_unsigned( 60, idsel'length ) );

-- 480i
-- MODE: 01111
constant IDSEL_480I : std_logic_vector := std_logic_vector( to_unsigned( 64 - 1, idsel'length ) );
constant FBDSEL_480I : std_logic_vector := std_logic_vector( to_unsigned( 64 - 5, idsel'length ) );
constant ODSEL_480I : std_logic_vector := std_logic_vector( to_unsigned( 60, idsel'length ) );

-- 720p
-- MODE: 11011
constant IDSEL_720P : std_logic_vector := std_logic_vector( to_unsigned( 64 - 4, idsel'length ) );
constant FBDSEL_720P : std_logic_vector := std_logic_vector( to_unsigned( 64 - 55, idsel'length ) );
constant ODSEL_720P : std_logic_vector := std_logic_vector( to_unsigned( 63, idsel'length ) );

-- 1080i
-- MODE: 11101
constant IDSEL_1080I : std_logic_vector := std_logic_vector( to_unsigned( 64 - 4, idsel'length ) );
constant FBDSEL_1080I : std_logic_vector := std_logic_vector( to_unsigned( 64 - 55, idsel'length ) );
constant ODSEL_1080I : std_logic_vector := std_logic_vector( to_unsigned( 63, idsel'length ) );

component Gowin_CLKDIV5 is
  port (
      clkout: out std_logic;
      hclkin: in std_logic;
      resetn: in std_logic
  );
end component;

component Gowin_PLLVR_dyn_r is
    port (
        clkout: out std_logic;
        clkin: in std_logic;
        reset: in std_logic;
        fbdsel: in std_logic_vector(5 downto 0);
        idsel: in std_logic_vector(5 downto 0);
        odsel: in std_logic_vector(5 downto 0)
    );
end component;

begin

  rstN <= not rst;
  pxlClkx5 <= pxlClkx5_int;

  dynPLL : Gowin_PLLVR_dyn_r
    port map (
      clkout => pxlClkx5_int,
      clkin => clkIn,
      reset => rst,
      fbdsel => fbdsel,
      idsel => idsel,
      odsel => odsel
    );

  clkDivInst: Gowin_CLKDIV5
    port map (
      clkout => pxlClk,
      hclkin => pxlClkx5_int,
      resetn => rstN
    );

  process( modeClk ) is
  begin
    if ( rising_edge( modeClk ) ) then
      if ( rst = '1' ) then
        idsel <= IDSEL_720P;
        fbdsel <= FBDSEL_720P;
        odsel <= ODSEL_720P;
      else
        
        case mode is
          when "10111" =>
            idsel <= IDSEL_480P;
            fbdsel <= FBDSEL_480P;
            odsel <= ODSEL_480P;

          when "01111" =>
            idsel <= IDSEL_480I;
            fbdsel <= FBDSEL_480I;
            odsel <= ODSEL_480I;
            
          when "11011" =>
            idsel <= IDSEL_720P;
            fbdsel <= FBDSEL_720P;
            odsel <= ODSEL_720P;
            
          when "11101" =>
            idsel <= IDSEL_1080I;
            fbdsel <= FBDSEL_1080I;
            odsel <= ODSEL_1080I;
            
          when others =>
            idsel <= IDSEL_720P;
            fbdsel <= FBDSEL_720P;
            odsel <= ODSEL_720P;
            
        end case;
        
      end if;
    end if;
  end process;

end rtl;
