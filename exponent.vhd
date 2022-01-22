library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity exponent is
    Port ( exp1 : in  STD_LOGIC_VECTOR(7 downto 0);
           exp2 : in  STD_LOGIC_VECTOR(7 downto 0);
           exp : out  STD_LOGIC_VECTOR (7 downto 0));
end exponent;

architecture Behavioral of exponent is
signal exp_1,exp_2 : unsigned(7 downto 0);
begin
	exp_1 <= unsigned(exp1) - 127;
	exp_2 <= unsigned(exp2)-127;
	exp <= std_logic_vector(exp_1 + exp_2 + 127);
end Behavioral;

