library ieee;
use ieee.std_logic_1164.all;

-- Design and implement a 8 bit integer adder/subtracter. The inputs are signed!
-- The inputs of the components are two 4-bit signal vectors, and its outputs include a 4
-- bit signed signal vector for result, 1 bit carry(overflow) signal and 1 bit underflow signal

entity brancher is
        port(   skip_value : in std_logic_vector(1 downto 0);
				clk  	   : in std_logic;
                skip_sel   : out std_logic
            );
end brancher;



architecture behavioral of brancher is

	-- ALU for 8 bit adding/subtracting/loading immediates
	component add_sub_8 
	port(	In1, In2 : in std_logic_vector(7 downto 0);
				Output : out std_logic_vector(7 downto 0)
	);
    end component add_sub_8;

	signal q : std_logic_vector(1 downto 0) := "00";
	signal d : std_logic_vector(1 downto 0) := "00";
	signal input_holder : std_logic_vector(7 downto 0);
	signal output_holder : std_logic_vector(7 downto 0);
	signal sel : std_logic := '0';
	signal dec_val : std_logic_vector(1 downto 0) := "00";
begin
	input_holder<="000000"&q;
	sub_one : add_sub_8 port map( In1 => input_holder, In2 => "11111111", Output => output_holder);
	dec_val <= output_holder(1)&output_holder(0);
	sel <= q(0) or q(1);
	d <= skip_value when sel='0' else dec_val;
	process (clk) is begin
		if rising_edge(clk) then
			q <= d;
		end if;
	end process;
	skip_sel <= sel;	

end architecture behavioral;

