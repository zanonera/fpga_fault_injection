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
entity tb_my_design is
end tb_my_design;

-- **********************************************
-- ARCHITECTURE
-- **********************************************
architecture Behavior of tb_my_design is
    -- Top Component
	component my_design is
	     port( clk                      : in  std_logic;    -- 100MHz FPGA Clock
	      rst                      : in  std_logic;    -- 100MHz FPGA Clock
--	      status_observation       : out std_logic;    -- Status Observation LED
--          status_correction        : out std_logic;    -- Status Correction LED
          --status_injection         : out std_logic;    -- Status Injection LED
          status_injection         : in std_logic;    -- Status Injection LED
--          status_uncorrectable     : out std_logic;    -- Status Uncorrectable Signal to Reconfigure FPGA
--          monitor_tx               : out std_logic;    -- Monitor TX Signal to the PMOD
--          monitor_rx               : in  std_logic;    -- Monitor RX Signal to the PMOD
          S_OUT                    : out std_logic     -- DUT Serial Output                    : out std_logic     -- DUT Serial Output
	    );
	end component;
    
    -- Signal Definition
    signal CLK,RST,SO,INJ  : std_logic;
begin
    -- Component Instantiation
    DUT : my_design port map(CLK,RST,INJ,SO);
    
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
    
    -- Reset Process
    process begin
        INJ <= '0'; wait for 100ns;
        INJ <= '1'; wait for 500ns;
        INJ <= '0'; wait for 50us;
    end process;
    
    -- Address Process
    process begin
       wait;
    end process;
end Behavior;
