----------------------------------------------------------------------------------
-- Company:  UC, ECE
-- Lecturer: Steve Weddell
-- 
-- Create Date:    23:24:33 02/07/2011 
-- Revised Date:   22:01:20 04/03/2019
-- Design Name: 
-- Module Name:    my_divider - Behavioral 
-- Project Name: 	For ENEL373 course on digital logic
-- Target Devices: Any
-- Tool versions:  Any
-- Description:   This clock divider will take a 100MHz clock and divide it down to 1Hz
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity my_divider is
    Port ( Clk_in : in  STD_LOGIC;
           Clk_out : out  STD_LOGIC);
			  
-- attributes - these are not needed, as they are provided in the constraints file	
end my_divider;

architecture Behavioral of my_divider is
--
--	constant clk_limit : std_logic_vector(27 downto 0) := X"17D783F"; -- 2 Hz output
    constant clk_limit : std_logic_vector(27 downto 0) := X"2FAF07E"; -- 1 Hz   "

	signal clk_ctr : std_logic_vector(27 downto 0);
	signal temp_clk : std_logic;

begin

 	clock: process (Clk_in)

		begin
		if Clk_in = '1' and Clk_in'Event then
		  if clk_ctr = clk_limit then				-- if counter == (1Hz count)/2
		  	 temp_clk <= not temp_clk;				--  toggle clock
			 clk_ctr <= X"0000000";					--  reset counter
		  else											-- else
		  	 clk_ctr <= clk_ctr + X"0000001";	--  counter = counter + 1
		  end if;
		end if;

	end process clock;

	Clk_out <= temp_clk;	

end Behavioral;

