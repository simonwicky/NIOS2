library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM is
    port(
        clk     : in  std_logic;
        cs      : in  std_logic;
        read    : in  std_logic;
        write   : in  std_logic;
        address : in  std_logic_vector(9 downto 0);
        wrdata  : in  std_logic_vector(31 downto 0);
        rddata  : out std_logic_vector(31 downto 0));
end RAM;

architecture synth of RAM is

	signal s_read: std_logic := '0';
	signal s_cs : std_logic := '0';
	signal s_address : std_logic_vector(9 downto 0);

	type ram_type is array(0 to 1023) of std_logic_vector(31 downto 0);
	signal ram : ram_type := (others => (others => '0'));

begin

p_write : process( clk )
begin

	if rising_edge(clk) then
		if (cs = '1' and write = '1') then
			ram(to_integer(unsigned(address))) <= wrdata;		
		end if ;
	end if ;
	
end process ; -- p_write

p_read : process( clk )
begin



	if rising_edge(clk) then

		if (s_read = '1' and s_cs = '1') then
			rddata <= ram(to_integer(unsigned(s_address)));
			else
				rddata <= (others => 'Z');
		end if ;




	end if ;

	s_read <= read;
	s_cs <= cs;
	s_address <= address;

	
end process ; -- read












end synth;
