-- **********************************************
-- fir10.vhd : 10th Order Low-pass FIR Filter
-- v2.0      : Load Input from ROM
--
-- Luis Aranda Barjola
--
-- Universidad de Nebrija
-- 03/04/2015
-- **********************************************
-- LIBRARIES
-- **********************************************
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- **********************************************
-- ENTITY
-- **********************************************
-- Filter Entity
entity FIR is
    port( CLK  : in  std_logic;                      -- Clock
          RST  : in  std_logic;                      -- Reset
          X    : in  signed(7 downto 0);             -- Input
          Y    : out signed(15 downto 0)          -- Output
    );
end FIR;

-- **********************************************
-- ARCHITECTURE
-- **********************************************
architecture behavior of FIR is
    -- Delay Flip-Flop Component
    component firdff is 
        port( CLK : in  std_logic;                  -- Clock
              RST : in  std_logic;                  -- Reset
              D   : in  signed(15 downto 0);        -- Input from MCM block
              Q   : out signed(15 downto 0)         -- Output to the Adder
        );
    end component;
    
    -- Signal Definition
    signal MCM0, MCM1, MCM2, MCM3, MCM4, MCM5, MCM6, MCM7, MCM8, MCM9, MCM10 : signed(15 downto 0) := (others => '0');
    signal A0, A1, A2, A3, A4, A5, A6, A7, A8, A9 : signed(15 downto 0) := (others => '0');
    signal Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9 : signed(15 downto 0) := (others => '0');

    -- Filter Coefficients
    constant H0   : signed(7 downto 0) := "00000000";
    constant H1   : signed(7 downto 0) := "00000000";
    constant H2   : signed(7 downto 0) := "00000100";
    constant H3   : signed(7 downto 0) := "00001110";
    constant H4   : signed(7 downto 0) := "00011100";
    constant H5   : signed(7 downto 0) := "00100010";
    constant H6   : signed(7 downto 0) := H4;
    constant H7   : signed(7 downto 0) := H3;
    constant H8   : signed(7 downto 0) := H2;
    constant H9   : signed(7 downto 0) := H1;
    constant H10  : signed(7 downto 0) := H0;

begin
    -- Multiple Constant Multiplications
    MCM0  <= H0 *X;
    MCM1  <= H1 *X;
    MCM2  <= H2 *X;
    MCM3  <= H3 *X;
    MCM4  <= H4 *X;
    MCM5  <= H5 *X;
    MCM6  <= H6 *X;
    MCM7  <= H7 *X;
    MCM8  <= H8 *X;
    MCM9  <= H9 *X;
    MCM10 <= H10*X;

    -- Adders
    A0 <= Q0 + MCM0;
    A1 <= Q1 + MCM1;
    A2 <= Q2 + MCM2;
    A3 <= Q3 + MCM3;
    A4 <= Q4 + MCM4;
    A5 <= Q5 + MCM5;
    A6 <= Q6 + MCM6;
    A7 <= Q7 + MCM7;
    A8 <= Q8 + MCM8;
    A9 <= Q9 + MCM9;

    -- Delay Flip-Flops
    FF0 : firdff port map(CLK, RST, A1, Q0);
    FF1 : firdff port map(CLK, RST, A2, Q1);
    FF2 : firdff port map(CLK, RST, A3, Q2);
    FF3 : firdff port map(CLK, RST, A4, Q3);
    FF4 : firdff port map(CLK, RST, A5, Q4);
    FF5 : firdff port map(CLK, RST, A6, Q5);
    FF6 : firdff port map(CLK, RST, A7, Q6);
    FF7 : firdff port map(CLK, RST, A8, Q7);
    FF8 : firdff port map(CLK, RST, A9, Q8);
    FF9 : firdff port map(CLK, RST, MCM10, Q9);

    -- Output Process
    process(CLK, RST) begin
        if (rising_edge(CLK)) then
            if (RST = '1') then
                Y <= (others => '0');
            else
                -- Filter Output
                Y <= A0;
            end if;
        end if;
    end process;
end behavior;
