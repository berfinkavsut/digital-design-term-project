library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity clk180kHz is
    Port ( clk    : IN  STD_LOGIC;
           reset  : IN  STD_LOGIC;
           clk_out: OUT STD_LOGIC);
end clk180kHz;
 
-- 180 kHz clock
architecture arch_clk180kHz of clk180kHz is
 
signal temporal: STD_LOGIC;
signal counter : integer range 0 to 278 := 0;
begin
    frequency_divider: process (reset, clk) begin
        if (reset = '1') then
            temporal <= '0';
            counter  <= 0;
        elsif rising_edge(clk) then
            if (counter = 278) then
                temporal <= not (temporal);
                counter  <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process; 
    clk_out <= temporal;
    
end arch_clk180kHz;
