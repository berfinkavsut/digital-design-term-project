library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity servo_pwm is 
    port (  clk   : IN  STD_LOGIC;
            reset : IN  STD_LOGIC;
            pos   : IN  STD_LOGIC_VECTOR(8 downto 0);
            servo : OUT STD_LOGIC);
end servo_pwm;

architecture arch_servo_pwm of servo_pwm is
-- Counter, from 0 to 2559.
signal counter : unsigned(12 downto 0);
-- Temporal signal used to generate the PWM pulse.
signal pwm: unsigned(9 downto 0);
begin
    -- Minimum value should be 1 ms.
    pwm <= unsigned('0' & pos) + 180;
     
    -- Counter process, from 0 to 2559.
    -- It counts until 2ms.
    Counter_process: process (reset, clk) begin
        if (reset = '1') then
            counter <= (others => '0');
        elsif rising_edge(clk) then
            if (counter = 3600) then
                counter <= (others => '0');
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    
    -- Output signal for the servomotor.
    servo <= '1' when (counter <= pwm) else '0';
    
end arch_servo_pwm;