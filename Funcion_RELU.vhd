----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Funcion_RELU is
    Port ( din : in  STD_LOGIC_VECTOR (23 downto 0);
           dout : out  STD_LOGIC_VECTOR (23 downto 0));
end Funcion_RELU;

architecture Behavioral of Funcion_RELU is

begin
	with din(23) select
		dout <= x"000000" when '1',
				  din			when others;

end Behavioral;

