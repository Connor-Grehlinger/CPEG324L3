library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
use ieee.std_logic_unsigned.all;

entity Debounce is
  Port (
    CLK : in  STD_LOGIC;
    btn_in : in  STD_LOGIC;
    db_btn : out  STD_LOGIC
  );
end Debounce;

architecture Behavioral of Debounce is
	signal Q1, Q2, Q3 : std_logic;

signal tmrCntr : std_logic_vector(26 downto 0) := (others => '0');
--constant TMR_CNTR_MAX : std_logic_vector(26 downto 0) := "000000001011110000100000000"; --"100,000,000 = clk cycles per second
constant TMR_CNTR_MAX : std_logic_vector(26 downto 0) :=   "000000011110100001001000000"; --"100,000,000 = clk cycles per second

	signal f100hz : std_logic;

begin

clock_100hz : process (CLK)
begin
    if (rising_edge(CLK)) then
        if (tmrCntr = TMR_CNTR_MAX) then
            tmrCntr <= (others => '0');
			f100hz <= not f100hz;                
        else
            tmrCntr <= tmrCntr + 1;
        end if;
        end if;
end process;

process(f100hz)
begin

   if (rising_edge(f100hz)) then
		if (btn_in = '1') then

         Q1 <= btn_in;

         Q2 <= Q1;

         Q3 <= Q2;

      end if;

   end if;

end process;

db_btn <= Q1 and Q2 and (not Q3);

end Behavioral;
