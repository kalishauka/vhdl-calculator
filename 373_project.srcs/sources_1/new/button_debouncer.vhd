----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.05.2022 11:47:02
-- Design Name: 
-- Module Name: button_debouncer - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity button_debouncer is
    Port ( clock : in std_logic;
           reset : in std_logic;
           button_in : in std_logic; 
           pulse_out : out std_logic );
end button_debouncer;

architecture Behavioral of button_debouncer is
constant COUNT_MAX: integer := 20;
constant BTN_ACTIVE: std_logic := '1';

signal count : integer := 0;
type state_type is (idle, wait_time);
signal state : state_type := idle;


begin
process(Reset, Clock)
begin
    if(Reset = '1') then
        state <= idle;
        pulse_out <= '0';
    elsif(rising_edge(clock)) then
        case(state) is
            when idle =>
                if(button_in = BTN_ACTIVE) then
                    state <= wait_time;
                else 
                    state <= idle;
                end if;
                pulse_out <= '0';
            when wait_time =>
                if (count = COUNT_MAX) then
                    count <= 0;
                    if (button_in = BTN_ACTIVE) then
                        pulse_out <= '1';
                    end if;
                    state <= idle;
                else
                    count <= count + 1;
                end if;
        end case;
    end if;
end process;
    

end Behavioral;
