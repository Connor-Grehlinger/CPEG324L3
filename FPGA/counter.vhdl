library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--The IEEE.std_logic_unsigned contains definitions that allow
--std_logic_vector types to be used with the + operator to instantiate a
--counter
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
    Port ( SW : in  STD_LOGIC_VECTOR (3 downto 0);
			  CLK : in  STD_LOGIC;
           SSEG_CA : out  STD_LOGIC_VECTOR (7 downto 0);
           SSEG_AN : out  STD_LOGIC_VECTOR (3 downto 0));
end counter;

architecture Behavioral of counter is
signal displayIndex : std_logic_vector(1 downto 0) := (others => '0');

signal tmrCntr : std_logic_vector(26 downto 0) := (others => '0');
constant TMR_CNTR_MAX : std_logic_vector(26 downto 0) := "000000001011110000100000000"; --"100,000,000 = clk cycles per second^

signal digitBuf : std_logic_vector(15 downto 0) := (others => '0');
signal digit : std_logic_vector(3 downto 0) := (others => '0');

begin

process (SW(0), SW(1), SW(2), SW(3))
begin
	if(SW(3) = '0') then
		digitBuf (3 downto 0) <= "0000";
	else
		digitBuf (3 downto 0) <= "0001";
	end if;
	
	if(SW(2) = '0') then
		digitBuf (7 downto 4) <= "0000";
	else
		digitBuf (7 downto 4) <= "0001";
	end if;
	
	if(SW(1) = '0') then
		digitBuf (11 downto 8) <= "0000";
	else
		digitBuf (11 downto 8) <= "0001";
	end if;
	
	if(SW(0) = '0') then
		digitBuf (15 downto 12) <= "0000";
	else
		digitBuf (15 downto 12) <= "0001";
	end if;
end process;

with displayIndex select
	digit <= digitBuf (3 downto 0) when "00",
			digitBuf (7 downto 4) when "01",
			digitBuf (11 downto 8) when "10",
			digitBuf (15 downto 12) when "11";
			
with digit select
	SSEG_CA <= "11000000" when "0000",
				"11111001" when "0001",
				"10001000" when "0010", --A
				"10000000" when "0011", --B
				"11000110" when "0100",	--C	
				"11111101" when "0101",								
				"00000000" when others;
			
with displayIndex select
	SSEG_AN <= "1110" when "00",
				"1101" when "01",
				"1011" when "10",
				"0111" when "11",
				"1111" when others;
				 
display_process : process (CLK)
begin
	if (rising_edge(CLK)) then
        if (tmrCntr = TMR_CNTR_MAX) then
            tmrCntr <= (others => '0');
			
				if (displayIndex >= 3) then
					displayIndex <= (others => '0');
				else 
					displayIndex <= displayIndex + 1;
				end if;
        else
            tmrCntr <= tmrCntr + 1;
        end if;
		end if;
end process;

end Behavioral;