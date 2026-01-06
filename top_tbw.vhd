--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:40:10 12/09/2025
-- Design Name:   
-- Module Name:   /home/ise/Xilinx_VM_Projects/traffic5/top_tbw.vhd
-- Project Name:  traffic5
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top_level
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY top_tbw IS
END top_tbw;
 
ARCHITECTURE behavior OF top_tbw IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top_level
    PORT(
         clk : IN  std_logic;
         start : IN  std_logic;
         reset : IN  std_logic;
         led : OUT  std_logic;
         NS_green : OUT  std_logic;
         NS_yellow : OUT  std_logic;
         NS_red : OUT  std_logic;
         EW_green : OUT  std_logic;
         EW_yellow : OUT  std_logic;
         EW_red : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal start : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal led : std_logic;
   signal NS_green : std_logic;
   signal NS_yellow : std_logic;
   signal NS_red : std_logic;
   signal EW_green : std_logic;
   signal EW_yellow : std_logic;
   signal EW_red : std_logic;

   -- Clock period definitions
   constant clk_period : time := 1 ms; -- 1 khz
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top_level PORT MAP (
          clk => clk,
          start => start,
          reset => reset,
          led => led,
          NS_green => NS_green,
          NS_yellow => NS_yellow,
          NS_red => NS_red,
          EW_green => EW_green,
          EW_yellow => EW_yellow,
          EW_red => EW_red
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
 
   --Stimulus process
   stim_proc: process
   begin	

		reset <= '1';
      wait for 5 ms;
      reset <= '0';
      wait for 5 ms;
		
      start<='1';
      wait for 50 ms; -- debouncing 40 ms
       --insert stimulus here 

      wait;
   end process;


END;
