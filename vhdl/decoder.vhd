library ieee;
use ieee.std_logic_1164.all;

entity decoder is
    port(
        address : in  std_logic_vector(15 downto 0);
        cs_LEDS : out std_logic;
        cs_RAM  : out std_logic;
        cs_ROM  : out std_logic
    );
end decoder;

architecture synth of decoder is
begin

mx : process( address )
begin
	if ((address >= X"0000") and (X"0FFC" >= address)) then
		cs_ROM <= '1';
		cs_RAM <= '0';
		cs_LEDS <= '0';
		else if ((address >= X"1000") and (X"1FFC" >= address)) then
			cs_ROM <= '0';
			cs_RAM <= '1';
			cs_LEDS <= '0';
			else if ((address >= X"2000") and (X"200C" >= address)) then
				cs_ROM <= '0';
				cs_RAM <= '0';
				cs_LEDS <= '1';
				else
					cs_ROM <= '0';
					cs_RAM <= '0';
					cs_LEDS <= '0';
			end if ;
		end if;
			
	end if ;



end process ; -- mx


end synth;
