-----------------------------------------------------------------------
-- Title: Mode Button
-- Author: zwenergy
-----------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_misc.all;

entity modeButton is
  port(
    clk : in std_logic;
    rst : in std_logic;
    buttonIn : in std_logic;
    modeOut : out std_logic_vector( 4 downto 0 );
    modeChange : out std_logic
  );
end modeButton;

architecture rtl of modeButton is
constant DEJITTERMAX : integer := 32;
signal modeInt : std_logic_vector( 4 downto 0 );
signal buttonDej : std_logic_vector( DEJITTERMAX - 1 downto 0 );
signal buttonVal, prevButtonVal : std_logic;
begin
  
  modeOut <= modeInt;
  
  process( clk ) is
  begin
    if ( rising_edge( clk ) ) then
      if ( rst = '1' ) then
        modeInt <= "11011";
        modeChange <= '0';
        buttonDej <= ( others => '1' );
        buttonVal <= '1';
        prevButtonVal <= '1';
      else
        prevButtonVal <= buttonVal;
        buttonDej( DEJITTERMAX - 1 ) <= buttonIn;
        buttonDej( DEJITTERMAX - 2 downto 0 ) <= buttonDej( DEJITTERMAX - 1 downto 1 );
        
        if ( buttonVal = '1' and or_reduce( buttonDej ) = '0' ) then
          buttonVal <= '0';
        elsif ( buttonVal = '0' and and_reduce( buttonDej ) = '1' ) then
          buttonVal <= '1';
        end if;
        
        if ( prevButtonVal = '1' and buttonVal = '0' ) then
          case modeInt is
            when "01111" =>
              modeInt <= "10111";
            when "10111" =>
              modeInt <= "11011";
            when "11011" =>
              modeInt <= "11101";
            when "11101" =>
              modeInt <= "01111";
            
            when others =>
              modeInt <= "11011";
          end case;
          
          modeChange <= '1';
        else
          modeChange <= '0';
        end if;
        
      end if;
    end if;
  end process;
  
end rtl;
