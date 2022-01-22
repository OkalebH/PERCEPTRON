----------------------------------------------------------------------------------
-- Company: BUAP
-- Engineer: Oscar Kaleb Hernández Badillo
-- 
-- Create Date:    21:22:01 09/18/2020 
-- Design Name: 
-- Module Name:    AdderSubtractor
-- Project Name: Adder_Subtractor
-- Target Devices: Spartan6
-- Description: 
-- This project implements the floating point adder/subtractor in 16 bit format
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity AdderSubtractor is
    Port ( num_1 : in  STD_LOGIC_VECTOR (23 downto 0);
           num_2 : in  STD_LOGIC_VECTOR (23 downto 0);
           num : out  STD_LOGIC_VECTOR (23 downto 0));
end AdderSubtractor;

architecture Behavioral of AdderSubtractor is
-------------------------------------------------------------------
--                   C  O  M  P  O  N  E  N  T                   --
-------------------------------------------------------------------
	COMPONENT Greater
	PORT(
		num_1 : IN std_logic_vector(23 downto 0);
		num_2 : IN std_logic_vector(23 downto 0);          
		s1 : OUT std_logic;
		s2 : OUT std_logic;
		exp1 : OUT std_logic_vector(7 downto 0);
		exp2 : OUT std_logic_vector(7 downto 0);
		frac1 : OUT std_logic_vector(14 downto 0);
		frac2 : OUT std_logic_vector(14 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Align
	PORT(
		exp1 : IN std_logic_vector(7 downto 0);
		exp2 : IN std_logic_vector(7 downto 0);
		frac2 : IN std_logic_vector(14 downto 0);          
		frac_align : OUT std_logic_vector(14 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Operation
	PORT(
		sign1 : IN std_logic;
		sign2 : IN std_logic;
		frac1 : IN std_logic_vector(14 downto 0);
		frac2 : IN std_logic_vector(14 downto 0);          
		frac : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	COMPONENT n_suma
	PORT(
		suma : IN std_logic_vector(15 downto 0);
		exp : IN std_logic_vector(7 downto 0);          
		exp_n : OUT std_logic_vector(7 downto 0);
		num : OUT std_logic_vector(14 downto 0)
		);
	END COMPONENT;
	
		COMPONENT Union_bits
	PORT(
		s : IN std_logic;
		exp : IN std_logic_vector(7 downto 0);
		frac : IN std_logic_vector(14 downto 0);          
		num : OUT std_logic_vector(23 downto 0)
		);
	END COMPONENT;
-------------------------------------------------------------------
--                       S  I  G  N  A  L                        --
-------------------------------------------------------------------
signal s1x,s2x : std_logic;
signal exp1x, exp2x,expnx : std_logic_vector(7 downto 0);
signal frac_x : std_logic_vector(15 downto 0);
signal frac1x,frac2x,frac_ax,numx : std_logic_vector(14 downto 0);
begin
-------------------------------------------------------------------
--              I  N  S  T  A  N  T  I  A  T  I  O  N            --
-------------------------------------------------------------------
	Mayor: Greater PORT MAP(
		num_1 => num_1,
		num_2 => num_2,
		s1 => s1x,
		s2 => s2x,
		exp1 => exp1x,
		exp2 => exp2x,
		frac1 => frac1x,
		frac2 => frac2x
	);
	
	Alinear: Align PORT MAP(
		exp1 => exp1x,
		exp2 => exp2x,
		frac2 => frac2x,
		frac_align => frac_ax
	);
	
	Suma_Resta: Operation PORT MAP(
		sign1 => s1x,
		sign2 => s2x,
		frac1 => frac1x,
		frac2 => frac_ax,
		frac => frac_x
	);
	
	
	Norm_SUMA_RESTA: n_suma PORT MAP(
		suma => frac_x,
		exp => exp1x,
		exp_n => expnx,
		num => numx
	);
	
		UnionBits: Union_bits PORT MAP(
		s => s1x,
		exp => expnx,
		frac => numx,
		num => num
	);
end Behavioral;

