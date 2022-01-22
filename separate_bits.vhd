library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity separate_bits is
    Port ( en : in  STD_LOGIC_VECTOR(1 downto 0);
           num_1 : in  STD_LOGIC_VECTOR (23 downto 0);
           num_2 : in  STD_LOGIC_VECTOR (23 downto 0);
           s1 : out  STD_LOGIC;
           s2 : out  STD_LOGIC;
           exp1 : out  STD_LOGIC_VECTOR (7 downto 0);
           exp2 : out  STD_LOGIC_VECTOR (7 downto 0);
           frac1 : out  STD_LOGIC_VECTOR (14 downto 0);
           frac2 : out  STD_LOGIC_VECTOR (14 downto 0));
end separate_bits;

architecture Behavioral of separate_bits is

begin
	process(en,num_1,num_2)
	begin
		if(en = "00") then
			s1 <= num_1(23);
			exp1 <= num_1(22 downto 15);
			frac1 <= num_1(14 downto 0);
			s2 <= num_2(23);
			exp2 <= num_2(22 downto 15);
			frac2 <= num_2(14 downto 0);
		end if;
	end process;

end Behavioral;

