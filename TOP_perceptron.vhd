library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOP_perceptron is
    Port ( x0 : in  STD_LOGIC_VECTOR (23 downto 0);
           x1 : in  STD_LOGIC_VECTOR (23 downto 0);
           x2 : in  STD_LOGIC_VECTOR (23 downto 0);
           x3 : in  STD_LOGIC_VECTOR (23 downto 0);
           w0 : in  STD_LOGIC_VECTOR (23 downto 0);
           w1 : in  STD_LOGIC_VECTOR (23 downto 0);
           w2 : in  STD_LOGIC_VECTOR (23 downto 0);
           w3 : in  STD_LOGIC_VECTOR (23 downto 0);
           dout : out  STD_LOGIC_VECTOR (23 downto 0));
end TOP_perceptron;

architecture Behavioral of TOP_perceptron is
	COMPONENT Multiplier
	PORT(
		num_1 : IN std_logic_vector(23 downto 0);
		num_2 : IN std_logic_vector(23 downto 0);          
		num_o : OUT std_logic_vector(23 downto 0)
		);
	END COMPONENT;
	COMPONENT AdderSubtractor
	PORT(
		num_1 : IN std_logic_vector(23 downto 0);
		num_2 : IN std_logic_vector(23 downto 0);          
		num : OUT std_logic_vector(23 downto 0)
		);
	END COMPONENT;

		COMPONENT Activacion
	PORT(
		din : IN std_logic_vector(23 downto 0);          
		dout : OUT std_logic_vector(23 downto 0)
		);
	END COMPONENT;
	
signal x_s12,x_s34,x_s : std_logic_vector(23 downto 0);
signal x_m1, x_m2,x_m3, x_m4 : std_logic_vector(23 downto 0);
begin
	

	MUL_BIAS: Multiplier PORT MAP(
		num_1 => x0,
		num_2 => w0,
		num_o => x_m1
	);
	MUL_X1: Multiplier PORT MAP(
		num_1 => x1,
		num_2 => w1,
		num_o => x_m2
	);
	MUL_X2: Multiplier PORT MAP(
		num_1 => x2,
		num_2 => w2,
		num_o => x_m3
	);
	MUL_X3: Multiplier PORT MAP(
		num_1 => x3,
		num_2 => w3,
		num_o => x_m4
	);
	SUM_1: AdderSubtractor PORT MAP(
		num_1 => x_m1,
		num_2 => x_m2,
		num => x_s12
	);
	SUM_2: AdderSubtractor PORT MAP(
		num_1 => x_m3,
		num_2 => x_m4,
		num => x_s34
	);
	SUM_12: AdderSubtractor PORT MAP(
		num_1 => x_s12,
		num_2 => x_s34,
		num => x_s 
	);
	Funcion_Activacion: Activacion PORT MAP(
		din => x_s,
		dout => dout
	);
	
end Behavioral;

