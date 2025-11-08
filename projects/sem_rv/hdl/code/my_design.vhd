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
          uart_enable              : in  std_logic;
          uart_data_in             : in std_logic_vector(7 downto 0);
          uart_data_out            : out std_logic     -- DUT Serial Output
    );
end my_design;

-- **********************************************
-- ARCHITECTURE
-- **********************************************
architecture Behavior of my_design is
 
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
   
begin
    
    -- Instantiate the UART
    UART : uart_tx6 port map(
        data_in               => uart_data_in,
        en_16_x_baud          => BAUD_ENA,
        serial_out            => uart_data_out,
        buffer_write          => uart_enable,
        buffer_data_present   => open,
        buffer_half_full      => open,
        buffer_full           => open,
        buffer_reset          => '0',
        clk                   => clk
    );
        
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