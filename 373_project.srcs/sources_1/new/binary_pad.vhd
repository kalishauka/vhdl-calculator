----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.05.2022 10:02:43
-- Design Name: 
-- Module Name: binary_pad - Behavioral
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

entity binary_pad is
    Port ( sw_input : in STD_LOGIC_VECTOR(11 downto 0);
    binary_out : out STD_LOGIC_VECTOR(23 downto 0));
end binary_pad;

architecture Behavioral of binary_pad is

begin
    process(sw_input)
        begin binary_out <= "000000000000" & sw_input;
     end process;

end Behavioral;
