library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fsm_controller is
  --generic(
    --GREEN_TIME  : integer := 5;
    --YELLOW_TIME : integer := 2;
  --);
  port(
    clk       : in  std_logic;
    rst       : in  std_logic;
    ena       : in  std_logic;
	 
    counter   : out std_logic_vector (5 downto 0);

    ns_red    : out std_logic;
    ns_yellow : out std_logic;
    ns_green  : out std_logic;

    ew_red    : out std_logic;
    ew_yellow : out std_logic;
    ew_green  : out std_logic
  );
end entity fsm_controller;

architecture rtl of fsm_controller is

  type trafficState is (NS_GREEN_EW_RED, NS_YELLOW_EW_RED, EW_GREEN_NS_RED, EW_YELLOW_NS_RED, IDLE);
  SIGNAL currentState, nextState : trafficState;
  signal ticksCounter: unsigned (5 downto 0):= "000000";
  signal currentStateTicks: integer := 5; -- 5 s for green
  signal nextStateTicks   : integer := 2; -- 2 s for yellow
   
  -- internal signals for outputs
  --signal ns_red_int    : std_logic := '0';
  --signal ns_yellow_int : std_logic := '0';
  --signal ns_green_int  : std_logic := '0';
  --signal ew_red_int    : std_logic := '0';
  --signal ew_yellow_int : std_logic := '0';
  --signal ew_green_int  : std_logic := '0';

begin
  
  -- FSM state register
  process(clk, rst)
  begin
    if(rst = '1') then
		ticksCounter <= "000000"; 
		currentStateTicks <= 5; 
		currentState <= NS_GREEN_EW_RED;
		
    elsif( clk'EVENT and clk = '1') then
      if(ena='1') then
		 
        if(ticksCounter >= currentStateTicks ) then -- 5 s
          currentStateTicks <= nextStateTicks; -- 2 s
			 currentState <= nextState; -- NS_YELLOW_EW_RED
			 ticksCounter <= "000000";
			 
		  else
			 currentStateTicks <= currentStateTicks;
			 ticksCounter <= ticksCounter + "000001"; -- ticksCounter ++ and next state
		    
       end if;
		 
    else 
		    currentState <= IDLE; 
			 ticksCounter <= "000000"; 
			 currentStateTicks <= 0; 
		end if; 
    end if;
	 
    	counter <= std_logic_vector(ticksCounter); 
		
  end process;
  
  
  -- Output logic (Moore Style)
  
  process(currentState)

  begin
  
    ns_green <= '0'; 
	 ns_yellow <= '0';
	 ns_red <= '0'; 
	 ew_red <= '0'; 
	 ew_yellow <= '0'; 
	 ew_green <= '0'; 
	 nextState <= currentState; 
	 nextStateTicks <= 0;
	 
	 case currentState is
      when NS_GREEN_EW_RED =>
				ns_green<='1';
            ew_red  <='1';
            nextState      <= NS_YELLOW_EW_RED;
            nextStateTicks <= 2; -- 2 s
      
		when NS_YELLOW_EW_RED =>
            ns_yellow<='1';
            ew_red   <='1';
            nextState <= EW_GREEN_NS_RED;
            nextStateTicks <= 5; -- 5 s
      
		when EW_GREEN_NS_RED =>
				ew_green<='1';
            ns_red  <='1';
            nextState      <= EW_YELLOW_NS_RED;
            nextStateTicks <= 2;
      
		when EW_YELLOW_NS_RED =>
				ew_yellow<='1';
            ns_red   <='1';
            nextState      <= NS_GREEN_EW_RED;
            nextStateTicks <= 5;
		  
		when IDLE =>
				ns_red <= '1'; -- on red
            ew_red <= '1'; 
            nextState      <= IDLE;
            nextStateTicks <= 0;

      when others =>
				null;

    end case;
  end process;
  
  end architecture rtl;
