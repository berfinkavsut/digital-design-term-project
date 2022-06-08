library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity servo_control is
  Port ( 
        clk  : IN  STD_LOGIC;
        reset: IN  STD_LOGIC;
        sw : in STD_LOGIC_VECTOR( 5 downto 0 );
        servo: OUT STD_LOGIC_VECTOR( 3 downto 0 ) );
end servo_control;

architecture arch_servo_control of servo_control is

    component servo_pwm_clk180kHz 
        port( clk  : IN  STD_LOGIC;
              reset: IN  STD_LOGIC;
              pos  : IN  STD_LOGIC_VECTOR(8 downto 0);
              servo: OUT STD_LOGIC);
    end component;

--Positions in integer types
signal pos1_int  : integer range 0 to 180;
signal pos2_int  : integer range 0 to 180;
signal pos3_int  : integer range 0 to 180;
signal pos4_int  : integer range 0 to 180;

--Counters for the positions 
signal counter1_right : integer range 0 to 180000; -- counts until 180000
signal counter1_left  : integer range 0 to 180000; -- counts until 180000
signal counter2_up    : integer range 0 to 360000; -- counts until 360000
signal counter2_down  : integer range 0 to 360000; -- counts until 360000
signal counter3_right : integer range 0 to 360000; -- counts until 180000
signal counter3_left  : integer range 0 to 360000; -- counts until 180000

-- Switch controls
signal sw1 : STD_LOGIC_VECTOR( 1 downto 0 );
signal sw2 : STD_LOGIC_VECTOR( 1 downto 0 );
signal sw3 : STD_LOGIC_VECTOR( 1 downto 0 );

-- Positions in std_logic_vector(8 downto 0) types
signal pos1 : STD_LOGIC_VECTOR( 8 downto 0 );
signal pos2 : STD_LOGIC_VECTOR( 8 downto 0 );
signal pos3 : STD_LOGIC_VECTOR( 8 downto 0 );
signal pos4 : STD_LOGIC_VECTOR( 8 downto 0 );

begin
sw1 <= sw (5 downto 4);
sw2 <= sw (3 downto 2);
sw3 <= sw (1 downto 0);

--Switch controls
Servo_1_process: process (reset,clk) begin
    -- reset
    if reset = '1' then 
        pos1_int <= 0;   
        counter1_left <= 0;  
        counter1_right <= 0;  
        
    -- set
    elsif rising_edge (clk) then
    
        --right
        if sw1 = "01" AND pos1_int > 0 then
           if counter1_left < 180000  then
                counter1_left <= counter1_left + 1;
           elsif (counter1_left = 180000) then
                pos1_int <= pos1_int - 1;
                counter1_left <= 0; 
           end if;   
                   
        --left
        elsif sw1 = "10" AND pos1_int < 90 then
           if counter1_right < 180000 then
             counter1_right <= counter1_right + 1;
           elsif (counter1_right = 180000) then
             pos1_int <= pos1_int + 1;             
             counter1_right <= 0; 
           end if;
        --stay
        else
            counter1_right <= 0;  
            counter1_left <= 0;      
        end if; 
               
    end if;
    
end process;

--Switch controls
Servo_2_and_3_process: process (reset,clk) begin
    --reset
    if reset = '1' then 
        pos2_int <= 0; 
        pos3_int <= 0;   
        counter2_up <= 0;  
        counter2_down <= 0;    
    --set
    elsif rising_edge (clk) then    
        --up
        if sw2 = "10" and pos2_int > 0 AND (pos3_int > 0 )then                
           if counter2_up < 360000 then
                counter2_up <= counter2_up + 1;              
           elsif (counter2_up = 360000) then
                pos2_int <= pos2_int - 1;
                pos3_int <= pos3_int - 1;
                counter2_up <= 0;
           end if;           
        --down
        elsif sw2 = "01" and pos2_int < 90 AND (pos3_int < 90 )then        
           if counter2_down < 360000 then
                 counter2_down <= counter2_down + 1;             
           elsif (counter2_down = 360000) then
                 pos2_int <= pos2_int + 1;
                 pos3_int <= pos3_int + 1;             
                 counter2_down <= 0;                         
            end if;           
        --stay
        else
            counter2_up <= 0; 
            counter2_down <= 0;  
        end if;        
    end if;
end process;

--Switch controls
Servo_4_process: process (reset,clk) begin
    --reset
    if reset = '1' then 
        pos4_int <= 0;   
        counter3_left <= 0;  
        counter3_right <= 0;   
        
    --set       
    elsif rising_edge (clk) then    
        --left
        if sw3 = "10" and pos4_int > 0 then
           if counter3_left < 180000 then
                counter3_left <= counter3_left + 1;
           elsif (counter3_left = 180000) then
                pos4_int <= pos4_int - 1;
                counter3_left <= 0; 
           end if;
                                 
        --right
        elsif sw3 = "01" and pos4_int < 90 then
           if counter3_right < 180000 then
             counter3_right <= counter3_right + 1;
           elsif (counter3_right = 180000) then
             pos4_int <= pos4_int + 1;
             counter3_right <= 0; 
           end if;  
                              
        --stay
        else
            counter3_right <= 0;  
            counter3_left <= 0;      
        end if;
                
    end if;
    
end process;

pos1 <= std_logic_vector( to_unsigned( pos1_int, pos1'length ) );
pos2 <= std_logic_vector( to_unsigned( pos2_int, pos2'length ) );
pos3 <= std_logic_vector( to_unsigned( pos3_int, pos3'length ) );
pos4 <= std_logic_vector( to_unsigned( pos4_int, pos4'length ) );

Servo_control_1 : servo_pwm_clk180kHz port map (clk, reset, pos1, servo(3));
Servo_control_2 : servo_pwm_clk180kHz port map (clk, reset, pos2, servo(2));
Servo_control_3 : servo_pwm_clk180kHz port map (clk, reset, pos3, servo(1));
Servo_control_4 : servo_pwm_clk180kHz port map (clk, reset, pos4, servo(0));

end arch_servo_control;
