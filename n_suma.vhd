library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity n_suma is
    Port ( suma : in  STD_LOGIC_VECTOR (15 downto 0);
           exp : in  STD_LOGIC_VECTOR (7 downto 0);
			  exp_n : out std_logic_vector(7 downto 0);
           num : out  STD_LOGIC_VECTOR (14 downto 0));
end n_suma;

architecture Behavioral of n_suma is
signal lead0 : unsigned(3 downto 0);
signal exp_t,exp_norm : unsigned(7 downto 0);
signal sum_t : unsigned(15 downto 0);
signal sum_r,sum_n : unsigned(14 downto 0);
begin
	sum_t <= unsigned(suma);
	exp_t <= unsigned(exp);
	lead0 <= "0000" when sum_t(14) = '1' else
				"0001" when sum_t(13) = '1' else
				"0010" when sum_t(12) = '1' else
				"0011" when sum_t(11) = '1' else
				"0100" when sum_t(10) = '1' else
				"0101" when sum_t(9) = '1' else
				"0110" when sum_t(8) = '1' else
				"0111" when sum_t(7) = '1' else
				"1000" when sum_t(6) = '1' else
				"1001" when sum_t(5) = '1' else
				"1010" when sum_t(4) = '1' else
				"1011" when sum_t(3) = '1' else
				"1100" when sum_t(2) = '1' else
				"1101" when sum_t(1) = '1' else
				"1110";
	with lead0 select 
		sum_r <= 
			sum_t(14 downto 0) 								when "0000",
			sum_t(13 downto 0) & '0'						when "0001",
			sum_t(12 downto 0) & "00"						when "0010",
			sum_t(11 downto 0) & "000"						when "0011",
			sum_t(10 downto 0) & "0000"					when "0100",
			sum_t(9 downto 0)  & "00000"					when "0101",
			sum_t(8 downto 0)  & "000000"					when "0110",
			sum_t(7 downto 0)  & "0000000"				when "0111",
			sum_t(6 downto 0)  & "00000000"				when "1000",
			sum_t(5 downto 0)  & "000000000"				when "1001",
			sum_t(4 downto 0)  & "0000000000"			when "1010",
			sum_t(3 downto 0)  & "00000000000"			when "1011",
			sum_t(2 downto 0)  & "000000000000"		   when "1100",
			sum_t(1 downto 0)  & "0000000000000"		when "1101",
			sum_t(0) 			 & "00000000000000"		when others;
			
	process(sum_r,sum_t,exp_t,lead0)
	begin
		if sum_t(15) = '1' then
			exp_norm <= exp_t + 1;
			sum_n <= sum_t(15 downto 1);
		elsif (lead0 > exp_t) then
			exp_norm <= (others => '0');
			sum_n <= (others => '0');
		else -- Cuando el número de ceros de cabecera es menor que el exponente 
			exp_norm <= exp_t - lead0;
			sum_n <= sum_r;
		end if;
	end process;
	exp_n <= std_logic_vector(exp_norm);
	num <= std_logic_vector(sum_n);
end Behavioral;

