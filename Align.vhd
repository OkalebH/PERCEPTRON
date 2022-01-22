library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Align is
    Port ( exp1 : in  STD_LOGIC_VECTOR (7 downto 0);
           exp2 : in  STD_LOGIC_VECTOR (7 downto 0);
           frac2 : in  STD_LOGIC_VECTOR (14 downto 0);
           frac_align : out  STD_LOGIC_VECTOR (14 downto 0));
end Align;

architecture Behavioral of Align is
signal exp_diff : unsigned(7 downto 0);
signal frac_a,frac_s : unsigned(14 downto 0);
begin
	frac_s <= unsigned(frac2);
	exp_diff <= unsigned(exp1) - unsigned(exp2);
	with exp_diff select
		frac_a <=       frac_s   			    when x"00",
					 '0' & frac_s(14 downto 1)  when x"01",
					"00" & frac_s(14 downto 2)  when x"02",
				  "000" & frac_s(14 downto 3)  when x"03",
				 "0000" & frac_s(14 downto 4)  when x"04",
				"00000" & frac_s(14 downto 5)  when x"05",
			  "000000" & frac_s(14 downto 6)  when x"06",
			 "0000000" & frac_s(14 downto 7)  when x"07",
			"00000000" & frac_s(14 downto 8)  when x"08",
		  "000000000" & frac_s(14 downto 9)  when x"09",
		 "0000000000" & frac_s(14 downto 10) when x"0A",
		"00000000000" & frac_s(14 downto 11) when x"0B",
	  "000000000000" & frac_s(14 downto 12) when x"0C",
	 "0000000000000" & frac_s(14 downto 13) when x"0D",
	"00000000000000" & frac_s(14)			    when x"0E",
  "000000000000000" 							    when others;	
	frac_align <= std_logic_vector(frac_a);

end Behavioral;

