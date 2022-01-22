library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Activacion is
    Port ( din : in  STD_LOGIC_VECTOR (23 downto 0);
           dout : out  STD_LOGIC_VECTOR(23 downto 0));
end Activacion;

architecture Behavioral of Activacion is

begin
	with din(23) select
		dout <= x"3F8000" when '0',
				 x"BF8000" when others;

end Behavioral;

