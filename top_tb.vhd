LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY top_tb IS
END top_tb;
 
ARCHITECTURE behavior OF top_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TOP_perceptron
    PORT(
         x0 : IN  std_logic_vector(23 downto 0);
         x1 : IN  std_logic_vector(23 downto 0);
         x2 : IN  std_logic_vector(23 downto 0);
         x3 : IN  std_logic_vector(23 downto 0);
         w0 : IN  std_logic_vector(23 downto 0);
         w1 : IN  std_logic_vector(23 downto 0);
         w2 : IN  std_logic_vector(23 downto 0);
         w3 : IN  std_logic_vector(23 downto 0);
         dout : OUT  std_logic_vector(23 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal x0 : std_logic_vector(23 downto 0) := (others => '0');
   signal x1 : std_logic_vector(23 downto 0) := (others => '0');
   signal x2 : std_logic_vector(23 downto 0) := (others => '0');
   signal x3 : std_logic_vector(23 downto 0) := (others => '0');
   signal w0 : std_logic_vector(23 downto 0) := (others => '0');
   signal w1 : std_logic_vector(23 downto 0) := (others => '0');
   signal w2 : std_logic_vector(23 downto 0) := (others => '0');
   signal w3 : std_logic_vector(23 downto 0) := (others => '0');

 	--Outputs
   signal dout : std_logic_vector(23 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TOP_perceptron PORT MAP (
          x0 => x0,
          x1 => x1,
          x2 => x2,
          x3 => x3,
          w0 => w0,
          w1 => w1,
          w2 => w2,
          w3 => w3,
          dout => dout
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      -- insert stimulus here 
		x0 <= x"3F8000"; -- 1
		w0 <= x"42CE8A"; -- 39.27
		-------------------------
		x1 <= x"41F07A"; -- 14.06
		w1 <= x"42E23B"; -- 49.116
		-------------------------
		x2 <= x"436B39";--107.224
		w2 <= x"40CA3D";-- -2.32
		-------------------------
		x3 <= x"437B74"; -- 123.456
		w3 <= x"40CA3D"; -- 2.32
      wait;
   end process;

END;
