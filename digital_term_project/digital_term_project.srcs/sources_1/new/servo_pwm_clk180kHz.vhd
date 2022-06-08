library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity servo_pwm_clk180kHz is
    port(
        clk  : IN  STD_LOGIC;
        reset: IN  STD_LOGIC;
        pos  : IN  STD_LOGIC_VECTOR(8 downto 0);
        servo: OUT STD_LOGIC
    );
end servo_pwm_clk180kHz;

architecture arch_servo_pwm_clk180kHz of servo_pwm_clk180kHz is
    component clk180kHz
        port( clk    : in  STD_LOGIC;
              reset  : in  STD_LOGIC;
              clk_out: out STD_LOGIC);
    end component;
    
    component servo_pwm
        port( clk   : IN  STD_LOGIC;
              reset : IN  STD_LOGIC;
              pos   : IN  STD_LOGIC_VECTOR(8 downto 0);
              servo : OUT STD_LOGIC);
    end component;

signal clk_out : STD_LOGIC := '0';
begin
    clk180kHz_map: clk180kHz port map( clk, reset, clk_out );
    servo_pwm_map: servo_pwm port map ( clk_out, reset, pos, servo );
end arch_servo_pwm_clk180kHz;