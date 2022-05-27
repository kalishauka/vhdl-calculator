----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.03.2022 16:05:53
-- Design Name: 
-- Module Name: 4_to_1 multiplexer - Behavioral
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

entity my_multiplexer is
    generic (N : integer := 8);
    Port ( A, B, C, D, E, F, G, H : in STD_LOGIC_VECTOR (N downto 0);
           Sel : in unsigned (2 downto 0);
           X : out STD_LOGIC_VECTOR (N downto 0));
end my_multiplexer;

architecture Behavioral of my_multiplexer is

begin
    process(A, B, C, D, E, F, G, H, Sel)
    begin
    case Sel is 
    when "000" => X <= A;
    when "001" => X <= B;
    when "010" => X <= C;
    when "011" => X <= D;
    when "100" => X <= E;
    when "101" => X <= F;
    when "110" => X <= G;
    when "111" => X <= H;
    end case;
    end process;
end Behavioral;
