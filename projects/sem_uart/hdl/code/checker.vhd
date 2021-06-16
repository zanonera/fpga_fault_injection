-- **********************************************
-- checker.vhd : Golden Checker
--
-- Dr. Luis Aranda Barjola
--
-- Universidad Nebrija
-- 14/03/2019
-- **********************************************
-- LIBRARIES
-- **********************************************
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- **********************************************
-- ENTITY
-- **********************************************
-- Checker Entity
entity checker is
	port( CLK  : in  std_logic;                      -- Clock
	      RST  : in  std_logic;                      -- Enable
	      Addr : in integer range 0 to 30;           -- Address
	      Y0   : in signed(15 downto 0);  -- DCT Output 0
          Y1   : in signed(15 downto 0);  -- DCT Output 1
          ERR  : out std_logic_vector(7 downto 0)    -- Error Signal
    );
end checker;

-- **********************************************
-- ARCHITECTURE
-- **********************************************
architecture Behavior of checker is
-- Declare Auxiliar Signal
signal FLAG : std_logic := '0';

begin
    -- Checking Process
    process(CLK)
    begin
        if (rising_edge(CLK)) then
            -- Check Output
            if (RST = '1') then
                ERR  <= x"30";            -- Zero in ASCII (Normal Operation)
                FLAG <= '0';
            elsif ((RST = '0') and (Addr > 11) and (Addr < 30) and (FLAG = '0')) then
                -- Error
                if (Y0 /= Y1) then
                    ERR  <= x"31";        -- One in ASCII (Error)
                    FLAG <= '1';
                end if;
            end if;
        end if;
    end process;
end Behavior;
