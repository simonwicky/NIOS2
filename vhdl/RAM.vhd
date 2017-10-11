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
	type RAM_type is array (0 to 1023) of std_logic_vector(31 downto 0);
	signal RAM_mem : RAM_type := (others =>(others => '0'));
	signal enable_read : std_logic := '0';
	signal s_address : std_logic_vector(9 downto 0) := (others => '0');

begin
	
	--read_proc : process( clk )
	--	begin
	--		if(rising_edge(clk)) then
	--			if(s_cs = '1'and s_read = '1') then 
	--				rddata <= RAM_mem(to_integer(unsigned(s_address)));
	--			else
	--				rddata <= (others => 'Z');
	--			end if;	

				
				
	--		end if;

	--		s_read <= read;
	--		s_address <= address;
	--		s_cs <= cs;

			
			
			
	--	end process ; -- read_proc	

	enable_clk : process( clk )
	begin
		if(rising_edge(clk)) then
			enable_read <= cs and read;
			s_address <= address;

		end if;
		
	end process ; -- enable_clk

	read_proc : process( enable_read, s_address, RAM_mem )
	begin
		rddata <= (others => 'Z');
		if(enable_read = '1') then
			rddata <= RAM_mem(to_integer(unsigned(s_address)));
		end if;
		
	end process ; -- read_proc




	write_proc : process( clk )
	begin
		if(rising_edge(clk)) then
			if(cs = '1' and write = '1') then
				RAM_mem(to_integer(unsigned(address))) <= wrdata;
			end if;
		end if;

		
	end process ; -- write_proc

end synth;
