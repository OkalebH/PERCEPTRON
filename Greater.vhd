library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Greater is
    Port ( num_1 : in  STD_LOGIC_VECTOR (23 downto 0);
           num_2 : in  STD_LOGIC_VECTOR (23 downto 0);
           s1 : out  STD_LOGIC;
           s2 : out  STD_LOGIC;
           exp1 : out  STD_LOGIC_VECTOR (7 downto 0);
           exp2 : out  STD_LOGIC_VECTOR (7 downto 0);
           frac1 : out  STD_LOGIC_VECTOR (14 downto 0);
           frac2 : out  STD_LOGIC_VECTOR (14 downto 0));
end Greater;

architecture Behavioral of Greater is
signal st1,st2 : std_logic;
begin
	process(num_1,num_2)
	begin
		if(num_1(22 downto 0) > num_2(22 downto 0)) then
			s1 <= num_1(23);
			exp1 <= num_1(22 downto 15);
			frac1 <= num_1(14 downto 0);
			s2 <= num_2(23);
			exp2 <= num_2(22 downto 15);
			frac2 <= num_2(14 downto 0);
		else
			s1 <= num_2(23);
			exp1 <= num_2(22 downto 15);
			frac1 <= num_2(14 downto 0);
			s2 <= num_1(23);
			exp2 <= num_1(22 downto 15);
			frac2 <= num_1(14 downto 0);
		end if;
	end process;

end Behavioral;

