library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_level is
    Port(
        clk : in std_logic;        -- High-frequency clock (1 kHz)
        start : in std_logic;      -- Push button
        reset : in std_logic;      -- External reset

        led : out std_logic;       -- System ON indicator

        NS_green : out std_logic;
        NS_yellow : out std_logic;
        NS_red : out std_logic;
        EW_green : out std_logic;
        EW_yellow : out std_logic;
        EW_red : out std_logic
    );
end top_level;

architecture Behavioral of top_level is

    signal clock_1HZ : std_logic;     -- From timer
    signal enableAll : std_logic;     -- From inputControl
    signal resetAll : std_logic;      -- From inputControl


begin

    --------------------------------------------------------------------
    -- TIMER MODULE  -> Required by Project
    -- Converts 1 kHz clock into 1 Hz tick used to time FSM durations
    --------------------------------------------------------------------
    timer_0 : entity work.timer
        Port map(
            clk => clk,              -- 1 kHz
            reset => resetAll,
            enable => enableAll,
            timerTick => clock_1HZ   -- 1 Hz output
        );
    --------------------------------------------------------------------
    -- INPUT CONTROL MODULE  -> Required by Project
    -- Handles:
    --   • push button debouncing
    --   • start/stop toggling
    --   • generating clean reset + enable
    --------------------------------------------------------------------
	 input_control_0 : entity work.inputControl
        Port map(
            clk => clk,              -- 1 kHz clock
            start => start,          -- push button
            rst => reset,            -- external reset
            led => led,              -- indicator
            enabler => enableAll,    -- clean enable
            resetter => resetAll     -- clean reset
        );
		  
	 --------------------------------------------------------------------
    -- FSM MODULE 
    -- Main controller for traffic lights
    -- States: NS_GREEN, NS_YELLOW, EW_GREEN, EW_YELLOW, IDLE
    -- Timing: Green=5s, Yellow=2s
    -- Triggered by 1 Hz timerTick
    --------------------------------------------------------------------
	 FSM_0 : entity work.fsm_controller
        Port map(
            clk       => clock_1HZ,     
				rst       => resetAll,      -- reset from inputControl
				ena       => enableAll,     -- enable from inputControl
				
	     	   ns_green  => NS_green,
				ns_yellow => NS_yellow,
				ns_red    => NS_red,
				
				ew_green  => EW_green,
            ew_yellow => EW_yellow,
            ew_red    => EW_red
        );

end Behavioral;
    
		  
    
