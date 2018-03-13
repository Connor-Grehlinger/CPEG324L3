library ieee;
use ieee.std_logic_1164.all;

-- Design and implement a 8 bit integer adder/subtracter. The inputs are signed!
-- The inputs of the components are two 4-bit signal vectors, and its outputs include a 4
-- bit signed signal vector for result, 1 bit carry(overflow) signal and 1 bit underflow signal

entity twoscomp is
	port( inp : in std_logic_vector(7 downto 0);
		  outp : out std_logic_vector(7 downto 0)
		);
end twoscomp;

architecture behavioral of twoscomp is
	
	signal temp : std_logic_vector(8-1 downto 0);
begin
	temp    <= not inp;
	adder : entity work.add_sub_8 port map( In1 => temp, In2 => "00000001", Output => outp);
	
end architecture behavioral;

