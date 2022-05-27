----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2022 16:48:14
-- Design Name: 
-- Module Name: Main - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
    Port ( SW : in STD_LOGIC_VECTOR (11 downto 0);
           CA : out STD_LOGIC_VECTOR (0 to 6);
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           CLK100MHZ : in std_logic;
           LED : out std_logic_vector (15 downto 0);
           BTNC : in std_logic);
end main;

architecture Behavioral of Main is
    Signal clk_1hz, ready : std_logic;
    Signal count : unsigned(2 downto 0);
    Signal BCD, bcd_buf : std_logic_vector(31 downto 0); 
    Signal binary_24 : std_logic_vector(23 downto 0);
    Signal BCD_2 : std_logic_vector (3 downto 0);
    Signal neg : std_logic_vector(7 downto 0);

    
    --attempiting to implement finite state signal
    Signal displayed_num : std_logic_vector (11 downto 0);
    Signal edge_push : std_logic;
    Signal push : std_logic;
    Signal overflow_sig : std_logic_vector( 7 downto 0); 

component Finite_state_machine is
 port( sw_in : in std_logic_vector(11 downto 0);
 button : in std_logic;
 reset : in std_logic;
 clk_signal : in std_logic;
 disp_val : out std_logic_vector(11 downto 0);
 leds : out std_logic_vector (4 downto 0);
 op_leds : out std_logic_vector (3 downto 0)); 
  
end component;

component clk_divider is
    generic (
        FREQ_IN  : integer := 100000000; -- Input clock frequency (100 MHz)
        FREQ_OUT : integer := 500);        -- Desired output frequency in Hz
    port (
        clk_in  : in std_logic;
        clk_out : out std_logic);
end component;

component n_bit_counter is
    Generic
    (
        n : integer
    );
    Port
    ( 
        clk : in STD_LOGIC;
        Q : out unsigned (n-1 downto 0)
    );
end component;

--component BCD_to_7SEG is
--		   Port ( bcd_in: in std_logic_vector (3 downto 0);	-- Input BCD vector
--    			leds_out: out	std_logic_vector (1 to 7));		-- Output 7-Seg vector 
--end component;

component bin_to_bcd is
    generic (
        BCD_SIZE : integer := 28; --! Length of BCD signal
        NUM_SIZE : integer := 24; --! Length of binary input
        NUM_SEGS : integer := 7;  --! Number of segments
        SEG_SIZE : integer := 4   --! Vector size for each segment
    );
    port (
        reset : in std_logic;                                --! Asynchronous reset
        clock : in std_logic;                                --! System clock
        start : in std_logic;                                --! Assert to start conversion
        bin   : in std_logic_vector(NUM_SIZE - 1 downto 0);  --! Binary input
        bcd   : out std_logic_vector(BCD_SIZE - 1 downto 0); --! Binary coded decimal output
        ready : out std_logic                                --! Asserted once conversion is finished
    );
end component;

component button_debouncer is
    generic ( FREQ_IN   : integer := 100000000;
              DELAY_MS  : integer := 50;
              FF_SIZE   : integer := 2 );
             
    Port ( reset    : in STD_LOGIC;
           clock    : in STD_LOGIC;
           input    : in STD_LOGIC;
           output   : out STD_LOGIC);
           
end component;

begin


segment_to_mux : entity work.my_multiplexer 
generic map (N => 7)
port map ( A => "11111110", B => "11111101", C => "11111011", D => "11110111", E => "11101111", F => "11011111", G => "10111111", H => neg,  X => AN, Sel => count);



clock_to_counter : n_bit_counter 
generic map (n => 3)
    port map (clk => clk_1hz, Q => count);
    
clk_signal: entity work.clk_divider 
port map (clk_in => CLK100MHZ, clk_out => clk_1hz );

clk_and_sw_to_Bin: bin_to_bcd
generic map (BCD_SIZE => 32, NUM_SIZE => 24, NUM_SEGS => 8, SEG_SIZE => 4) 
port map (reset => '0', clock => CLK100MHZ, start => '1', bin => binary_24, bcd => bcd_buf, ready => ready);

process(CLK100MHZ) -- flipflop instead of latch by using rising edge
begin
    if rising_edge(CLK100MHZ) then
        if ready = '1' then
            BCD <= bcd_buf;
        end if;
    end if;
end process;

multi_BCD: entity work.my_multiplexer
generic map (N => 3)
port map (A => BCD(3 downto 0), B => BCD(7 downto 4), C => BCD(11 downto 8), D => BCD(15 downto 12), E => BCD(19 downto 16), F => BCD(23 downto 20), G=> BCD(27 downto 24), H => "0001", X => BCD_2, Sel => count);



BCD_to_BCD_7: entity work.BCD_to_7SEG
port map (bcd_in => BCD_2, leds_out => CA);
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              


button_to_led : button_debouncer
port map(clock => CLK100MHZ, reset => '0', input => BTNC, output => push); 


state_handler : entity work.Finite_state_machine 
port map(sw_in => SW, button => push, reset => '0', clk_signal => CLK100MHZ, disp_val => binary_24, leds => LED( 4 downto 0), op_leds => lED(15 downto 11), neg => neg);

end Behavioral;
