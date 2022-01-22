library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity normalization is
    Port ( exp : in  STD_LOGIC_VECTOR (7 downto 0);
           frac : in  STD_LOGIC_VECTOR (14 downto 0);
           exp_o : out  STD_LOGIC_VECTOR (7 downto 0);
           frac_o : out  STD_LOGIC_VECTOR (14 downto 0));
end normalization;

architecture Behavioral of normalization is
	signal lead0 : unsigned(3 downto 0);
	signal t_frac : unsigned(14 downto 0);
	signal frac_norm : unsigned(14 downto 0);
begin
	t_frac <= unsigned(frac);
	lead0 <= "0000" when frac(14) = '1' else
				"0001" when frac(13) = '1' else
				"0010" when frac(12) = '1' else
				"0011" when frac(11) = '1' else
				"0100" when frac(10) = '1' else
				"0101" when frac(9) = '1' else
				"0110" when frac(8) = '1' else
				"0111" when frac(7) = '1' else
				"1000" when frac(6) = '1' else
				"1001" when frac(5) = '1' else
				"1010" when frac(4) = '1' else
				"1011" when frac(3) = '1' else
				"1100" when frac(2) = '1' else
				"1101" when frac(1) = '1' else
				"1110";
	
	with lead0 select 
		frac_norm <= 
			t_frac(14 downto 0) 						when "0000",
			t_frac(13 downto 0) & '0'				when "0001",
			t_frac(12 downto 0) & "00"				when "0010",
			t_frac(11 downto 0) & "000"			when "0011",
			t_frac(10 downto 0) & "0000"			when "0100",
			t_frac(9 downto 0)  & "00000"			when "0101",
			t_frac(8 downto 0)  & "000000"		when "0110",
			t_frac(7 downto 0)  & "0000000"		when "0111",
			t_frac(6 downto 0)  & "00000000"		when "1000",
			t_frac(5 downto 0)  & "000000000"		when "1001",
			t_frac(4 downto 0)  & "0000000000"		when "1010",
			t_frac(3 downto 0)  & "00000000000"		when "1011",
			t_frac(2 downto 0)  & "000000000000"		when "1100",
			t_frac(1 downto 0)  & "0000000000000"		when "1101",
			t_frac(0)			  & "00000000000000"		when others;

	process(frac_norm,lead0,exp)
	begin
		if (lead0 > unsigned(exp)) then
			exp_o <= (others=>'0');
			frac_o <= (others=>'0');
		else
			exp_o <= std_logic_vector(unsigned(exp) - lead0);
			frac_o <= std_logic_vector(frac_norm);
		end if;
	end process;

end Behavioral;

