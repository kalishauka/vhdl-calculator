----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/23/2017 10:52:27 AM
-- Design Name: 
-- Module Name: mux_dual_4_to_1 - Behavioral
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

entity mux_dual_4_to_1 is
    Port ( curr_count : in STD_LOGIC_VECTOR (7 downto 0);
           sel : in STD_LOGIC;
           num_out : out STD_LOGIC_VECTOR (3 downto 0));
end mux_dual_4_to_1;

architecture Behavioral of mux_dual_4_to_1 is

begin
  p1: process(curr_count, sel)
    begin
      case sel is
        when '0' => num_out <= curr_count(3 downto 0);
        when '1' => num_out <= curr_count(7 downto 4);
      end case;
    end process;  

end Behavioral;
