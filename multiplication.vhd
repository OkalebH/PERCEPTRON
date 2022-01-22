library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multiplication is
    Port ( frac1 : in  STD_LOGIC_VECTOR (14 downto 0);
           frac2 : in  STD_LOGIC_VECTOR (14 downto 0);
           frac : out  STD_LOGIC_VECTOR (14 downto 0));
end multiplication;

architecture Behavioral of multiplication is
signal b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14 : unsigned(28 downto 0);
signal num_1, num_2 : unsigned(14 downto 0);
signal bit_sum : unsigned(29 downto 0);
signal frac_t,frac_r : unsigned(17 downto 0);
signal lead0 : unsigned(3 downto 0);
signal least0 : unsigned(17 downto 0);
signal d0,d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14 : std_logic;
begin
	num_1 <= unsigned(frac1);
	num_2 <= unsigned(frac2);
	d0 <= std_logic(num_2(0));
	d1 <= std_logic(num_2(1));
	d2 <= std_logic(num_2(2));
	d3 <= std_logic(num_2(3));
	d4 <= std_logic(num_2(4));
	d5 <= std_logic(num_2(5));
	d6 <= std_logic(num_2(6));
	d7 <= std_logic(num_2(7));
	d8 <= std_logic(num_2(8));
	d9 <= std_logic(num_2(9));
	d10 <= std_logic(num_2(10));
	d11 <= std_logic(num_2(11));
	d12 <= std_logic(num_2(12));
	d13 <= std_logic(num_2(13));
	d14 <= std_logic(num_2(14));
	
	b0 <= "00000000000000" & num_1      when d0 = '1' else "00000000000000000000000000000";
	b1 <= "0000000000000"  & num_1 & "0" when d1 = '1' else "00000000000000000000000000000";
	b2 <= "000000000000"   & num_1 & "00" when d2 = '1' else "00000000000000000000000000000";
	b3 <= "00000000000"    & num_1 & "000" when d3 = '1' else "00000000000000000000000000000";
	b4 <= "0000000000"     & num_1 & "0000" when d4 = '1' else "00000000000000000000000000000";
	b5 <= "000000000"      & num_1 & "00000" when d5 = '1' else "00000000000000000000000000000";
	b6 <= "00000000"       & num_1 & "000000" when d6 = '1' else "00000000000000000000000000000";
	b7 <= "0000000"        & num_1 & "0000000" when d7 = '1' else "00000000000000000000000000000";
	b8 <= "000000"         & num_1 & "00000000" when d8 = '1' else "00000000000000000000000000000";
	b9 <= "00000"          & num_1 & "000000000" when d9 = '1' else "00000000000000000000000000000";
	b10 <= "0000"          & num_1 & "0000000000" when d10 = '1' else "00000000000000000000000000000";
	b11 <= "000"           & num_1 & "00000000000" when d11 = '1' else "00000000000000000000000000000";
	b12 <= "00"            & num_1 & "000000000000" when d12 = '1' else "00000000000000000000000000000";
	b13 <= "0"             & num_1 & "0000000000000" when d13 = '1' else "00000000000000000000000000000";
	b14 <=                   num_1 & "00000000000000" when d14 = '1' else "00000000000000000000000000000";
	
	bit_sum <= unsigned('0'&b0) + unsigned('0'&b1) + unsigned('0'&b2) + unsigned('0'&b3) + unsigned('0'&b4) + unsigned('0'&b5) + unsigned('0'&b6) 
	         + unsigned('0'&b7) + unsigned('0'&b8) + unsigned('0'&b9) + unsigned('0'&b10) + unsigned('0'&b11) + unsigned('0'&b12) + unsigned('0'&b13)
	         + unsigned('0'&b14);
--	--Trunca a 18 bits, revisa que los bits más significativos no sean cero
	lead0 <= "0000" when bit_sum(29) = '1' else
				"0001" when bit_sum(28) = '1' else
				"0010" when bit_sum(27) = '1' else
				"0011" when bit_sum(26) = '1' else
				"0100" when bit_sum(25) = '1' else
				"0101" when bit_sum(24) = '1' else
				"0110" when bit_sum(23) = '1' else
				"0111" when bit_sum(22) = '1' else
				"1000" when bit_sum(21) = '1' else
				"1001" when bit_sum(20) = '1' else
				"1010" when bit_sum(19) = '1' else
				"1011" when bit_sum(18) = '1' else
				"1100";

	with lead0 select 
		frac_t <= 
			bit_sum(29 downto 12) when "0000",
			bit_sum(28 downto 11) when "0001",
			bit_sum(27 downto 10) when "0010",
			bit_sum(26 downto 9) when "0011",
			bit_sum(25 downto 8) when "0100",
			bit_sum(24 downto 7) when "0101",
			bit_sum(23 downto 6) when "0110",
			bit_sum(22 downto 5) when "0111",
			bit_sum(21 downto 4) when "1000",
			bit_sum(20 downto 3) when "1001",
			bit_sum(19 downto 2) when "1010",
			bit_sum(18 downto 1) when "1011",
			bit_sum(17 downto 0) when others;
--			
--	--REDONDEOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
	least0 <= "000000000000000000" when frac_t(17 downto 0) = "111111111111111111" else
				 "000000000000000001" when frac_t(0) = '1' else
				 "000000000000000010" when frac_t(1) = '1' else
				 "000000000000000100" when frac_t(2) = '1' else
				 "000000000000000000"; 
	frac_r <= frac_t + least0;
	frac <= std_logic_vector(frac_r(17 downto 3));
end Behavioral;

