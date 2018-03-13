library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
entity add_sub_8_tb is
end add_sub_8_tb;

architecture behavioral of add_sub_8_tb is
--  Declaration of the component that will be instantiated.
component add_sub_8
port(	In1, In2:	in std_logic_vector (7 downto 0);		-- signed 4 bit input 
			Output : out std_logic_vector(7 downto 0);      -- overflow and underflow signal
);
end component add_sub_8;

-- Internal signals (wires for connecting components)
signal in1, in2, output : std_logic_vector(7 downto 0);
signal carry, underflow : std_logic;

begin
--  Component instantiation.
add_sub_8_0: add_sub_8 port map (In1 => in1, In2 => in2, Output => output, Carry => carry, Underflow => underflow); 

-- Testing process
test_bench_add_sub_8 : process  is
--begin

type pattern_type is record
--  The inputs and outputs of the shift_reg.
in1, in2, output : std_logic_vector (7 downto 0);
carry, underflow : std_logic;

end record;

--  The patterns to apply.
type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
----------- all 4-bit adder/subtracter functionality -----------
-- ("in1", '"in2", "output", 'carry', 'underflow')
(
("00001001", "00001001", "00010010", '0', '0'),
("00001110", "00000001", "00001111", '0', '0'),
("00000011", "00001100", "00001111", '0', '0'),
("00100000", "01010000", "01110000", '0', '0'),
-- ("1010", "0011", "1101", '0', '0'),
-- ("0111", "0010", "0001", '1', '0'), 
-- ("0011", "0100", "0111", '0', '0'), 
-- ("0001", "0001", "0010", '0', '0'),
-- ("0001", "0001", "0010", '0', '0'), 
-- ("0001", "0100", "0101", '0', '0'), 
-- ("0010", "0010", "0100", '0', '0'),  			
-- ("1110", "1101", "1011", '0', '0'), 			-- neg 5
-- ("1100", "1110", "1010", '0', '0'), 	
-- ("0001", "0010", "0011", '0', '0'),
-- ("0001", "0001", "0010", '0', '0'),
-- ("1001", "1000", "1001", '0', '1'),
("01110000", "00010000", "00000000", '1', '0')
);


variable test_result : std_logic_vector(7 downto 0) := "00000000";
variable print_control : std_logic := '0';

begin
--  Check each pattern.
for n in patterns'range loop
--  Set the inputs.
in1 <= patterns(n).in1;
in2 <= patterns(n).in2;


--  Wait for the results.
wait for 20 ns;

 -- test_result := output;

-- if (print_control = '1') then 
 -- for i in 0 to test_result'LENGTH loop
 -- report "test_result("&integer'image(i)&") value is" &  std_logic'image(test_result(i));
 -- end loop;
-- end if;
 
 -- print_control := not print_control;
 
--  Check the outputs.
assert output = patterns(n).output report "Error: bad output value" severity error;
assert carry = patterns(n).carry report "Error: bad carry value" severity error;
assert underflow = patterns(n).underflow report "Error: bad underflow value" severity error;

end loop;

assert false report "End of 8-bit integer adder/subtracter test. Passed if no errors displayed" severity note;

--  Wait forever; this will finish the simulation.
wait;

end process test_bench_add_sub_8;
-- End of testing process

end architecture;
-- end of bavioral test bench 