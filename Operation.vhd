library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Operation is
    Port ( sign1 : in std_logic;
			  sign2 : in std_logic;
			  frac1 : in  STD_LOGIC_VECTOR (14 downto 0);
           frac2 : in  STD_LOGIC_VECTOR (14 downto 0);
           frac : out  STD_LOGIC_VECTOR (15 downto 0));
end Operation;

architecture Behavioral of Operation is
signal result : unsigned(15 downto 0);
signal num1,num2 : unsigned(14 downto 0);
begin
	num1 <= unsigned(frac1);
	num2 <= unsigned(frac2);
	
	result <= ('0'&num1) + ('0'&num2) when sign1 = sign2 else
			 ('0'&num1) - ('0'&num2);
	
	frac <= std_logic_vector(result);
end Behavioral;

