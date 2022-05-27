----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.05.2022 12:16:41
-- Design Name: 
-- Module Name: button_debounceTB - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity button_debounceTB is
--  Port ( );
end button_debounceTB;

architecture Behavioral of button_debounceTB is

component button_debouncer is
  generic ( FREQ_IN   : integer := 100000000;
              DELAY_MS  : integer := 50;
              FF_SIZE   : integer := 2 );
             
    Port ( reset    : in STD_LOGIC := '1'; 
           clock    : in STD_LOGIC := '0';
           input    : in STD_LOGIC;
           output   : out STD_LOGIC);
           
end component;

signal t_reset : std_logic := '0';
signal t_clock : std_logic := '0';
signal t_input : std_logic := '0';
signal t_output : std_logic := '0';
constant clk_period : time := 1 us;


begin

uut: button_debouncer port map(
    reset => t_reset,
    clock => t_clock,
    input => t_input,
    output => t_output
    );
    
clk_process :process
   begin
  t_clock <= '0';
  wait for clk_period/2;
  t_clock <= '1';
  wait for clk_period/2;
   end process;

stimulus: process begin 
wait for 100 ns;

t_input <= '1';
t_reset <= '1';
wait for 10 us;
t_input <= '0';
wait for 10 us;
t_input <= '1';
wait for 10 us;
t_input <= '0';



wait;
end process stimulus;

end;
