-- **********************************************
-- inputROM.vhd : ROM Component with the Inputs
--
-- Prof. Luis A. Aranda
--
-- Universidad Nebrija
-- 17/03/2019
-- **********************************************
-- LIBRARIES
-- **********************************************
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- **********************************************
-- ENTITY
-- **********************************************
-- inputROM Entity
entity inputROM is
    port( CLK  : in  std_logic;                        -- Clock
          Read : in  std_logic;                        -- Read
          Addr : in  integer range 0 to 30;            -- Address
      	  X    : out signed(7 downto 0)                -- X
    );
end inputROM;

-- **********************************************
-- ARCHITECTURE
-- **********************************************
architecture Behavior of inputROM is
    -- Define ROM Content
    type ROM_Array is array (0 to 30) of signed(7 downto 0);
    constant ROM_X : ROM_Array := (x"00",x"01",x"02",x"03",x"04",x"05",x"06",x"07",x"08",x"09",x"0A",x"01",x"02",x"03",x"04",x"05",x"06",x"07",x"08",x"09",x"0A",x"01",x"02",x"03",x"04",x"05",x"06",x"07",x"08",x"09",x"0A");
begin
    -- ROM Process
    process(CLK)
    begin
        if (rising_edge(CLK)) then
            -- Read Data
            if ((Read = '1') and (Addr < 30)) then
                X <= ROM_X(Addr);
            else
                X <= "ZZZZZZZZ";
            end if;
        end if;
    end process;
end Behavior;
