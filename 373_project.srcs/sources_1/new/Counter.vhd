----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.03.2022 16:27:03
-- Design Name: 
-- Module Name: Counter - Behavioral
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

entity n_bit_counter is
    Generic
    (
        n : integer
    );
    Port
    (
        clk : in STD_LOGIC;
        Q : out unsigned (n-1 downto 0)
    );
end n_bit_counter;

architecture Behavioral of n_bit_counter is
    signal count : unsigned (n-1 downto 0);
begin
   
    process (clk)
    begin
        if rising_edge(clk) then
            count <= count + 1;
            Q <= count;
        end if;
    end process;

end Behavioral;
