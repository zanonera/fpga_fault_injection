-- **********************************************
-- tb_top.vhd : Testbench for Top Entity
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

-- **********************************************
-- ENTITY
-- **********************************************
-- Adder Entity
entity tb_top is
end tb_top;

-- **********************************************
-- ARCHITECTURE
-- **********************************************
architecture Behavior of tb_top is
    -- Top Component
    component top is
        port( CLK  : in  std_logic;                      -- Clock
              RST  : in  std_logic;                      -- Reset
              Read : in  std_logic;                      -- Read
              Addr : in  integer range 0 to 30;       -- Address
              ERR  : out std_logic_vector(7 downto 0)    -- Error Signal
        );
    end component;
    
    -- Signal Definition
    signal CLK, RST, Read : std_logic;
    signal ERR  : std_logic_vector(7 downto 0);
    signal Addr : integer range 0 to 30;
begin
    -- Component Instantiation
    DUT : top port map(CLK => CLK,RST => RST,Read => Read,Addr => Addr,ERR => ERR);
    
    -- Clock Process
    process begin
        CLK <= '0'; wait for 5ns;
        CLK <= '1'; wait for 5ns;
    end process;
    
    -- Reset Process
    process begin
        RST <= '0'; wait for 10ns;
        RST <= '1'; wait for 15ns;
        RST <= '0'; wait;
    end process;
    
    -- Read Process
    process begin
        Read <= '0'; wait for 20ns;
        Read <= '1'; wait;
    end process;
    
    -- Address Process
    process begin
        Addr <= 0; wait for 25ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait for 10ns;
        Addr <= Addr + 1; wait;
    end process;
end Behavior;
