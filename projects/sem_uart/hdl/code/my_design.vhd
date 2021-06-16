-- **********************************************
-- my_design.vhd : Top Instance
--
-- Dr. Luis Aranda Barjola
--
-- Universidad Nebrija
-- 15/03/2019
-- **********************************************
-- LIBRARIES
-- **********************************************
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- **********************************************
-- ENTITY
-- **********************************************
-- My Design Entity
entity my_design is
	port( clk                      : in  std_logic;    -- 100MHz FPGA Clock
	      rst                      : in  std_logic;    -- 100MHz FPGA Clock
--	      status_observation       : out std_logic;    -- Status Observation LED
--          status_correction        : out std_logic;    -- Status Correction LED
          --status_injection         : out std_logic;    -- Status Injection LED
          status_injection         : in std_logic;    -- Status Injection LED
--          status_uncorrectable     : out std_logic;    -- Status Uncorrectable Signal to Reconfigure FPGA
--          monitor_tx               : out std_logic;    -- Monitor TX Signal to the PMOD
--          monitor_rx               : in  std_logic;    -- Monitor RX Signal to the PMOD
          S_OUT                    : out std_logic     -- DUT Serial Output
    );
end my_design;

-- **********************************************
-- ARCHITECTURE
-- **********************************************
architecture Behavior of my_design is
    -- SEM IP Component
--    component sem_ip is
--    port (
--        clk                   : in     std_logic;
--        status_observation    : out    std_logic;
--        status_correction     : out    std_logic;
--        status_injection      : out    std_logic;
--        status_uncorrectable  : out    std_logic;
--        monitor_tx            : out    std_logic;
--        monitor_rx            : in     std_logic;
--        icap_clk_out          : buffer std_logic;
--        injection_done        : buffer std_logic
--    );
--    end component;
    
    -- Top Component
    component top is
        port( CLK  : in  std_logic;                       -- Clock
              RST  : in  std_logic;                       -- Reset
              Read : in  std_logic;                       -- Read
              Addr : in  integer range 0 to 30;        -- Address
              ERR  : out std_logic_vector(7 downto 0)     -- Error Signal
        );
    end component;
    
    -- UART Component
    component uart_tx6 is
        port( data_in               : in std_logic_vector(7 downto 0);
              en_16_x_baud          : in std_logic;
              serial_out            : out std_logic;
              buffer_write          : in std_logic;
              buffer_data_present   : out std_logic;
              buffer_half_full      : out std_logic;
              buffer_full           : out std_logic;
              buffer_reset          : in std_logic;
              clk                   : in std_logic
        );
    end component;
    
    -- Signal Definition
    signal BAUD_COUNT        : integer range 0 to 6 := 0;
    signal BAUD_ENA, B_WRITE : std_logic := '0';
    signal FLAG1             : std_logic := '0';
    signal FLAG2             : std_logic := '1';
    signal icap_clk, injection_done : std_logic;
    signal Read : std_logic := '0';
    signal ERR : std_logic_vector(7 downto 0);
    signal Addr : integer range 0 to 10000 := 0;
    
    --Debug Definition
    attribute MARK_DEBUG : string;
    attribute MARK_DEBUG of ERR: signal is "TRUE";
    attribute MARK_DEBUG of RST: signal is "TRUE";
    attribute MARK_DEBUG of Addr: signal is "TRUE";
    attribute MARK_DEBUG of Read: signal is "TRUE";
    attribute MARK_DEBUG of status_injection: signal is "TRUE";
    
begin
    -- Instantiate the SEM IP
--    SEM : sem_ip port map(
--        clk                   => clk,
--        status_observation    => status_observation,
--        status_correction     => status_correction,
--        status_injection      => status_injection,
--        status_uncorrectable  => status_uncorrectable,
--        monitor_tx            => monitor_tx,
--        monitor_rx            => monitor_rx,
--        icap_clk_out          => icap_clk,
--        injection_done        => injection_done
--    );

    injection_done <= not status_injection;
    
    -- Instantiate the Top Level Entity of my DUT
    DUT : top port map(
        CLK  => clk,
        RST  => injection_done,
        Read => Read,
        Addr => Addr,
        ERR  => ERR
    );
    
    -- Instantiate the UART
    UART : uart_tx6 port map(
        data_in               => ERR,
        en_16_x_baud          => BAUD_ENA,
        serial_out            => S_OUT,
        buffer_write          => B_WRITE,
        buffer_data_present   => open,
        buffer_half_full      => open,
        buffer_full           => open,
        buffer_reset          => '0',
        clk                   => clk
    );
    
    -- ************************************
    -- UART Output Process
    -- ************************************
    process(clk) begin
          if (rising_edge(clk)) then
                -- Reset
                if (injection_done = '1') then
                    B_WRITE  <= '0';
                    FLAG1    <= '0';
                    FLAG2    <= '0';
                    Read     <= '0';
                    Addr     <= 0;
                else
                    if (Addr < 29) then
                        Read <= '1';
                        Addr <= Addr + 1;
--                    elsif (Addr = 29) then
--                        Addr     <= 0;
                    else
                        -- Send Output Pulse
                        if ((FLAG1 = '0') and (FLAG2 = '0') and (B_WRITE = '0')) then
                            FLAG1 <= '1';
                        elsif ((FLAG1 = '1') and (FLAG2 = '0') and (B_WRITE = '0')) then
                            B_WRITE <= '1';
                            FLAG2 <= '1';
                        elsif ((FLAG1 = '1') and (FLAG2 = '1') and (B_WRITE = '1')) then
                            B_WRITE <= '0';
                        else
                            B_WRITE <= '0';
                        end if;
                    end if;
                end if;
          end if;
    end process;
    
    -- Baud Generator Process
    process(clk) begin
        if (rising_edge(clk)) then
            if (BAUD_COUNT = 6) then
                BAUD_COUNT <= 0;
                BAUD_ENA <= '1';
            else
                BAUD_COUNT <= BAUD_COUNT + 1;
                BAUD_ENA <= '0';
            end if;
        end if;
    end process;
end Behavior;