library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity timer is
    Port (
        clk       : in  std_logic;             -- 1 kHz clock
        reset     : in  std_logic;             -- reset from inputControl
        enable    : in  std_logic;             -- enable from inputControl
        timerTick : out std_logic              -- 1 Hz pulse
    );
end timer;

architecture Behavioral of timer is

    signal counter : unsigned(31 downto 0) := (others=>'0');

begin

    process(clk, reset)
    begin
        if reset = '1' then
            counter   <= (others=>'0');
            timerTick <= '0';
				
					 
		  elsif(clk'EVENT and clk='1') then 
            if(enable = '1') then
                 counter <= counter + to_unsigned(1, counter'length);
						  
					if(counter < 500)then --configured for 1KHZ clock
							  
								  timerTick <='1'; 
					else 
								  timerTick<='0'; 
								  
					end if;
						  
					if(counter >= 1000) then 
						counter <= to_unsigned(0, counter'length); 
					end if; 
						  
				else
					timerTick<='0'; 
						  
				end if;
					 
					 
	      end if; 
	
	end process; 
end Behavioral;