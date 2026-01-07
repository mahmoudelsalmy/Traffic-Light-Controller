library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity inputControl is
    Port (
        clk      : in  std_logic;    -- 1 kHz clock
        start    : in  std_logic;    -- push button
        rst      : in  std_logic;    -- external async reset
        led      : out std_logic;    -- ON indicator
        enabler  : out std_logic;    -- enable signal to FSM + Timer
        resetter : out std_logic     -- reset pulse to FSM + Timer
    );
end inputControl;

architecture Behavioral of inputControl is

	 signal counter        : unsigned(20 downto 0) := (others => '0');
    signal counterEnable  : std_logic := '0';
    signal onSignal		  : std_logic:='0';

begin

	 -- Main Control Logic
	 
	 process(clk, rst)
    begin
        if(rst = '1') then
     		   counter       <= (others => '0');
            counterEnable <= '0';
            enabler       <= '0';
            resetter      <= '0';
            led           <= '0';
            onSignal      <= '0';
			  
		  elsif(clk'event and clk='1')then 
		  
		    resetter <= '0';
		  
		      if(counterEnable = '1')then 
				     counter <= counter + to_unsigned(1, counter'length); 
				end if;
				
				
				if(start = '1') then
				   if(counterEnable = '0') then 
					    counter <= to_unsigned(0, counter'length);
						 counterEnable<='1';
						 
					elsif(counter >= 30 and counter < 40) then
					    resetter<='1'; 
						 
					elsif(counter >= 40) then --send enable signal
						 enabler <='1'; 
						 resetter<='0'; 
						 led<='1'; 
						 onSignal <= '1'; 
					end if;
			   else 
			          led <= onSignal; 
						 enabler <= onSignal; 
						 resetter <= '0'; 
			   end if; 
			
			end if; 
	end process; 
end Behavioral;
