library IEEE;
        	-- As discussed in Lecture 8 of ENEL373, 2019
        	-- ------------------------------------------
            use ieee.std_logic_1164.all;
            use ieee.std_logic_unsigned.all;  -- this is needed for the adder
            									-- i.e., the "+"
        
        	-- external (to the FPGA) input and output connections
            entity counter is 
             port(Clock, CLR : in  std_logic;
                    Q : out std_logic_vector(3 downto 0));
             end counter;
        
             architecture behav of counter is  
        
              signal tmp: std_logic_vector(3 downto 0); -- internal to FPGA
              											-- note, "in" or "out"  
        												-- are invalid
              -- you can also define components here, and only here. 
             
              begin
        
               process (Clock, CLR) -- if either of these signals change,
        							-- run this process
               begin   
        
                   if (CLR='1') then     -- this is an asynchronous clear
        
                          tmp <= "0000";  
        
                   elsif (Clock'event and Clock='1') then 
        
                          tmp <= tmp + 1;  -- Counters uses flip-flops to
        									-- "remember" the last count,
        									-- which can then be added to.
                   end if;     
        
               end process; 
        
                   Q <= tmp;  - lastly, copy this internal vector to the output
        
             end behav;
