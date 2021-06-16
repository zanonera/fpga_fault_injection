-- **********************************************
-- top.vhd : Top Entity
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
-- Top Entity
entity top is
	port( CLK  : in  std_logic;                      -- Clock
	      RST  : in  std_logic;                      -- Reset
	      Read : in  std_logic;                      -- Read
	      Addr : in  integer range 0 to 30;          -- Address
	      ERR  : out std_logic_vector(7 downto 0)    -- Error Signal
    );
end top;

-- **********************************************
-- ARCHITECTURE
-- **********************************************
architecture Behavior of top is
    -- inputROM Component
    component inputROM is
        port( CLK  : in  std_logic;                        -- Clock
              Read : in  std_logic;                        -- Read
              Addr : in  integer range 0 to 30;            -- Address
              X    : out signed(7 downto 0)                -- X
        );
    end component;
    
    -- DCT Component
    component FIR is
        port( CLK  : in  std_logic;                      -- Clock
              RST  : in  std_logic;                      -- Reset
              X    : in  signed(7 downto 0);             -- Input
              Y    : out signed(15 downto 0)          -- Output
        );
    end component;
    
    -- Checker component
    component checker is
        port( CLK  : in  std_logic;                      -- Clock
              RST  : in  std_logic;                      -- Enable
              Addr : in  integer range 0 to 30;          -- Address
              Y0   : in  signed(15 downto 0);  -- DCT Output 0
              Y1   : in  signed(15 downto 0);  -- DCT Output 1
              ERR  : out std_logic_vector(7 downto 0)    -- Error Signal
        );
    end component;
    
    -- Signal Definition
    signal X : signed(7 downto 0);
    signal Y0, Y1 : signed(15 downto 0);
    
    --Debug Definition
    attribute MARK_DEBUG : string;
    attribute MARK_DEBUG of X: signal is "TRUE";
    attribute MARK_DEBUG of Y0: signal is "TRUE";
    attribute MARK_DEBUG of Y1: signal is "TRUE";
begin
    ROM : inputROM port map(
        CLK  => CLK,
        Read => Read,
        Addr => Addr,
        X => X
    );
    
    FIR1 : FIR port map(
        CLK => CLK,
        RST => RST,
        X => X,
        Y => Y0
    );
    
    FIR2 : FIR port map(
        CLK => CLK,
        RST => RST,
        X => X,
        Y => Y1
    );
    
    CHCK : checker port map(
        CLK  => CLK,
        RST  => RST,
        Addr => Addr,
        Y0   => Y0,
        Y1   => Y1,
        ERR  => ERR
    );
end Behavior;
