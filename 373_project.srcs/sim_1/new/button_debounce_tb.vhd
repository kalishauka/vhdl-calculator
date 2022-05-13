----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.05.2022 12:02:25
-- Design Name: 
-- Module Name: button_debounce_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity button_debounce_tb is
--  Port ( );
end button_debounce_tb;

architecture Behavioral of button_debounce_tb is
component button_debouncer
Port ( clock : in std_logic;
           reset : in std_logic;
           button_in : in std_logic; 
           pulse_out : out std_logic );
end component;

signal clock : std_logic := '0';
signal reset : std_logic := '0';
signal button_in : std_logic := '0';

signal pulse_out : std_logic;

constant clock_period : time := 10ns;



begin
    utt: button_debouncer PORT MAP (
        clock => clock,
        reset => reset,
        button_in => button_in,
        pulse_out => pulse_out );
        
        
   clock_process : process
   begin 
       clock <= '0';
       wait for clock_period/2;
       clock <= '1';
       wait for clock_period/2;
   end process; 
       
   stim_proc: process
   begin
       button_in <= '0';
       reset <= '1';
       
     wait for 100 ns;
       reset <= '0';
     wait for clock_period*10;
     
        button_in <= '1';   wait for clock_period*2;
        button_in <= '0';   wait for clock_period*1;
        button_in <= '1';   wait for clock_period*1;
        button_in <= '0';   wait for clock_period*20;
        --second activity
        button_in <= '1';   wait for clock_period*1;
        button_in <= '0';   wait for clock_period*1;
        button_in <= '1';   wait for clock_period*1;
        button_in <= '0';   wait for clock_period*2;
        button_in <= '1';   wait for clock_period*20;
        button_in <= '0';   
      wait;
   end process;    
   
end Behavioral;      


