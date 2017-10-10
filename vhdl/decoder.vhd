library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder is
    port(
        address : in  std_logic_vector(15 downto 0);
        cs_LEDS : out std_logic;
        cs_RAM  : out std_logic;
        cs_ROM  : out std_logic
    );
end decoder;

architecture synth of decoder is
	constant b1 : std_logic_vector := X"0000";
	constant b2 : std_logic_vector := X"0FFC";
	constant b3 : std_logic_vector := X"1000";
	constant b4 : std_logic_vector := X"1FFC";
	constant b5 : std_logic_vector := X"2000";
	constant b6 : std_logic_vector := X"200C";


begin
	
	decode : process( address )
	begin
		
		if(( unsigned(address) >= unsigned(b1) ) and ( unsigned(address) <= unsigned(b2) ))  then
			
			cs_RAM <= '0';
			cs_LEDS <= '0';
			cs_ROM <= '1';

			
		elsif((unsigned(address) >= unsigned(b3)) and (unsigned(address) <= unsigned(b4))) then
			cs_ROM <= '0';
			cs_LEDS <= '0';
			cs_RAM <= '1';

		elsif((unsigned(address) >= unsigned(b5)) and (unsigned(address) <= unsigned(b6))) then
			cs_RAM <= '0';
			cs_ROM <= '0';
			cs_LEDS <= '1';
		else
			cs_RAM <= '0';
			cs_ROM <= '0';
			cs_LEDS <= '0';

		end if;

	end process ; -- decode
	
	

end synth;
