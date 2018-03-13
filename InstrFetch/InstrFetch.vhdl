library std;
use std.textio.all;

library ieee;
use ieee.std_logic_1164.all;

entity InstrFetch is
port(	clock:	in std_logic;
		inst: in std_logic_vector (7 downto 0);
        inst_out: out std_logic_vector(7 downto 0)
);
end instrfetch;

architecture behavioral of InstrFetch is
begin

    inst_out <= inst;
    

end architecture behavioral;

