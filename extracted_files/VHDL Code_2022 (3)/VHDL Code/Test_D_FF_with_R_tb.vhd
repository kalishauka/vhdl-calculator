----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/15/2019 12:49:30 PM
-- Design Name: 
-- Module Name: D_ff_tb - Behavioral
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

entity D_ff_tb is
--  Port ( );
end D_ff_tb;

architecture Behavioral of D_ff_tb is

 component Test_D_FF_with_R
     Port ( R : in STD_LOGIC;
        D : in STD_LOGIC;
        EN : in STD_LOGIC;
        clk : in STD_LOGIC;
        Q : out STD_LOGIC);
 end component;
 
signal R, D, EN, clk, Q : std_logic;

begin

 UUT: Test_D_FF_with_R port map ( R => R, D => D, EN => EN, clk => clk, Q => Q);
 
 -- we need a clock process, so define one, in addition to some clock delays
 clk_process : process
  begin
   clk <= '1', '0' after 10 ns, '1' after 20 ns, '0' after 30 ns;
   wait for 40 ns;
  end process clk_process;
   
 io_process : process
  begin  
   R <= '0';
   EN <= '1';
   D  <= '0';
   wait for 40 ns;
   
   EN <= '0';
   D <= '1';
   D <= '0';
   wait for 40 ns;
  
  
  end process io_process; 

end Behavioral;
