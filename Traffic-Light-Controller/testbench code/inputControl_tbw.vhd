
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY input_tbw IS
END input_tbw;
 
ARCHITECTURE behavior OF input_tbw IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT inputControl
    PORT(
         clk : IN  std_logic;
         start : IN  std_logic;
         rst : IN  std_logic;
         led : OUT  std_logic;
         enabler : OUT  std_logic;
         resetter : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal start : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal led : std_logic;
   signal enabler : std_logic;
   signal resetter : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: inputControl PORT MAP (
          clk => clk,
          start => start,
          rst => rst,
          led => led,
          enabler => enabler,
          resetter => resetter
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		start<='1';
      wait for 100 ns;
		

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
