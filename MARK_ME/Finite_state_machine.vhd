----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.05.2022 15:24:45
-- Design Name: 
-- Module Name: Finite_state_machine - Behavioral
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

entity Finite_state_machine is
 port( sw_in : in std_logic_vector(11 downto 0);
 button : in std_logic;
 reset : in std_logic;
 clk_signal : in std_logic;
 disp_val : out std_logic_vector(23 downto 0);
 leds : out std_logic_vector(4 downto 0);
 op_leds : out std_logic_vector (4 downto 0);
 neg : out std_logic_vector(7 downto 0)); 
  
end Finite_state_machine;

architecture Behavioral of Finite_state_machine is
type calculator_state is (num_1, operand, num_2, output);
Signal current_state : calculator_state;
Signal number_1 : std_logic_vector (11 downto 0);
signal operator : std_logic_vector (11 downto 0);
Signal number_2 : std_logic_vector (11 downto 0);
Signal answer : unsigned(11 downto 0);
Signal mult_ans : unsigned( 23 downto 0); 
Signal ready : std_logic := '0'; 
Signal unsigned_num_1 : unsigned(11 downto 0);
Signal unisgned_num_2 : unsigned(11 downto 0); 
Signal final_answer : std_logic_vector(23 downto 0);
Signal overflow_check : std_logic_vector(23 downto 0); 
Signal negative_out : std_logic := '0'; 
begin

process(reset, button, current_state)
begin
    if(reset = '1') then
        current_state <= num_1;
    elsif rising_edge(button) then
        --if button = '1' then
            case current_state is
                when num_1 =>  current_state <= operand;
       
                when operand => current_state <= num_2;
           
                when num_2 =>  current_state <= output;
               
                when output =>  current_state <= num_1;
              
               
            end case;
          end if;
      --end if;
  end process;
 
 process(current_state)
 begin
  --if rising_edge(clk_signal) then  
  case current_state is 
    when num_1 => number_1 <= sw_in;
    when operand => operator <= sw_in;
    when num_2 => number_2 <= sw_in;
    when output => ready <= '1';
end case;
--end if;
end process;

process(current_state)
  begin
  --if rising_edge(clk_signal) then
  case current_state is 
    when num_1 => disp_val <= "0000000000000" & number_1(10 downto 0);
    if(number_1(11) = '1') then neg <= "01111111";
    else neg <= "11111111";
    end if;
    leds <= "00001";
    when operand => disp_val <= "000000000000" & operator;
    leds <= "00010";
    when num_2 => disp_val <= "0000000000000" & number_2(10 downto 0);
    if(number_2(11) = '1') then neg <= "01111111";
    else neg <= "11111111";
    end if;
    leds <= "00100";
    when output => disp_val <= final_answer;
    if (negative_out = '1') then neg <= "01111111";
    else neg <= "11111111";
    end if; 
    leds <= "01000";
    end case;
    --end if;
end process;


process(ready)
begin
--if rising_edge(clk_signal) then
    if (ready = '1') then
    unsigned_num_1 <= '0' & unsigned(number_1(10 downto 0));
    unisgned_num_2 <= '0' & unsigned( number_2(10 downto 0));
        case operator is 
            when "000000000001" => 
            if((number_1(11) = '1')AND(number_2(11) = '0')) then if (unsigned_num_1 > unisgned_num_2) then 
                answer <= (unsigned_num_1  - unisgned_num_2);
                else answer <= (unisgned_num_2 - unsigned_num_1);
                end if; 
                if (unsigned_num_1 > unisgned_num_2) then negative_out <= '1'; 
                else negative_out <= '0';
                end if;
            elsif ((number_1(11) = '0')AND(number_2(11) = '1')) then if (unsigned_num_1 > unisgned_num_2) then 
                answer <= (unsigned_num_1  - unisgned_num_2);
                else answer <= (unisgned_num_2 - unsigned_num_1);
                end if; 
                if (unisgned_num_2  > unsigned_num_1 ) then negative_out <= '1'; 
                else negative_out <= '0'; 
                end if;
            elsif ((number_1(11) = '0')AND(number_2(11) = '0')) then answer <= (unisgned_num_2 + unsigned_num_1);
                negative_out <= '0';
            else answer <= (unsigned_num_1 + unisgned_num_2);
                negative_out <= '1';
            end if;
            overflow_check <= std_logic_vector( "000000000000" & std_logic_vector(answer)); 
            if (overflow_check(23 downto 12) /= "000000000000") then final_answer <= "000000000000000000000000";
            else
            final_answer <= "000000000000" & std_logic_vector(answer);
            end if; 
            op_leds <= "10000";
            when "000000000010" =>           
            if((number_1(11) = '1')AND(number_2(11) = '0')) then answer <= (unisgned_num_2 + unsigned_num_1);
            negative_out <= '1'; 
            elsif ((number_1(11) = '0')AND(number_2(11) = '1')) then answer <= (unsigned_num_1 + unisgned_num_2);
            negative_out <= '0';  
            elsif ((number_1(11) = '0')AND(number_2(11) = '0')) then if (unsigned_num_1 > unisgned_num_2) then 
                answer <= (unsigned_num_1 - unisgned_num_2);
                else answer <= (unisgned_num_2 - unsigned_num_1);
                end if; 
                if (unisgned_num_2  > unsigned_num_1 ) then negative_out <= '1';
                else negative_out <= '0';
                end if;
            else if (unsigned_num_1 > unisgned_num_2) then answer <= (unsigned_num_1 - unisgned_num_2);
                else answer <= (unisgned_num_2 - unsigned_num_1);
                end if; 
                if (unsigned_num_1 > unisgned_num_2 ) then negative_out <= '1';
                else negative_out <= '0';
                end if;
            end if;
            overflow_check <= std_logic_vector( "000000000000" & std_logic_vector(answer)); 
            if (overflow_check(23 downto 12) /= "000000000000") then final_answer <= "000000000000000000000000";
            else
            final_answer <= "000000000000" & std_logic_vector(answer);
            end if; 
            op_leds <= "01000"; 
            when "000000000100" => mult_ans <= (unisgned_num_2 * unsigned_num_1);
            if(((number_1(11) = '1')AND(number_2(11) = '0'))OR((number_2(11) = '1')AND(number_1(11) = '0'))) then negative_out <= '1';
            else negative_out <= '0';
            end if;    
            overflow_check <= std_logic_vector(mult_ans); 
            if (overflow_check(23 downto 12) /= "000000000000") then final_answer <= "000000000000000000000000";
           else
            final_answer <= "000000000000" & std_logic_vector(mult_ans(11 downto 0));
            end if; 
            op_leds <= "00100";
            when "000000001000" => answer <= (unsigned_num_1 / unisgned_num_2 );
            if(((number_1(11) = '1')AND(number_2(11) = '0'))OR((number_2(11) = '1')AND(number_1(11) = '0'))) then negative_out <= '1';
            else negative_out <= '0';
            end if;    
            overflow_check <= std_logic_vector( "000000000000" & std_logic_vector(answer)); 
            if (overflow_check(23 downto 12) /= "000000000000") then final_answer <= "000000000000000000000000";
            else
            final_answer <= "000000000000" & std_logic_vector(answer);
            end if;
            op_leds <= "00010";
            when "000000010000" => answer <= (unsigned_num_1 mod unisgned_num_2); 
            final_answer <= "000000000000" & std_logic_vector(answer);
            op_leds <= "00001"; 
            when others => 
           if((number_1(11) = '1')AND(number_2(11) = '0')) then if (unsigned_num_1 > unisgned_num_2) then 
                answer <= (unsigned_num_1  - unisgned_num_2);
                else answer <= (unisgned_num_2 - unsigned_num_1);
                end if; 
                if (unsigned_num_1 > unisgned_num_2) then negative_out <= '1'; 
                else negative_out <= '0';
                end if;
            elsif ((number_1(11) = '0')AND(number_2(11) = '1')) then if (unsigned_num_1 > unisgned_num_2) then 
                answer <= (unsigned_num_1  - unisgned_num_2);
                else answer <= (unisgned_num_2 - unsigned_num_1);
                end if; 
                if (unisgned_num_2  > unsigned_num_1 ) then negative_out <= '1'; 
                else negative_out <= '0'; 
                end if;
            elsif ((number_1(11) = '0')AND(number_2(11) = '0')) then answer <= (unisgned_num_2 + unsigned_num_1);
                negative_out <= '0';
            else answer <= (unsigned_num_1 + unisgned_num_2);
                negative_out <= '1';
            end if;
            overflow_check <= std_logic_vector( "000000000000" & std_logic_vector(answer)); 
            if (overflow_check(23 downto 12) /= "000000000000") then final_answer <= "000000000000000000000000";
            else
            final_answer <= "000000000000" & std_logic_vector(answer);
            end if; 
            op_leds <= "10000";
            end case; 
            end if;
            --end if;
            end process;  
   

         
end Behavioral;
