-- **********************************************
-- firdff.vhd : Delay Flip-Flop Component
--
-- Luis Aranda Barjola
--
-- Universidad de Nebrija
-- 24/03/2015
-- **********************************************
-- LIBRARIES
-- **********************************************
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- **********************************************
-- ENTITY
-- **********************************************
-- Flip-flop Entity
entity firdff is
	port( CLK : in  std_logic;    		     -- Clock
          RST : in  std_logic;               -- Reset
      	  D   : in  signed(15 downto 0);     -- Input from MCM block
      	  Q   : out signed(15 downto 0)      -- Output to the Adder
    );
end firdff;

-- **********************************************
-- ARCHITECTURE
-- **********************************************
architecture behavior of firdff is
begin
	  -- Process
	  process(CLK, RST) begin
        if (rising_edge(CLK)) then
            if (RST = '1') then
                Q <= (others => '0');
            else
    		    Q <= D;
            end if;
  		  end if;
	  end process;
end behavior;
