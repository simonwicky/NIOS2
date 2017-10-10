library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift_unit is
    port(
        a  : in  std_logic_vector(31 downto 0);
        b  : in  std_logic_vector(4 downto 0);
        op : in  std_logic_vector(2 downto 0);
        r  : out std_logic_vector(31 downto 0)
    );
end shift_unit;

architecture synth of shift_unit is


begin

shift : process( a,b,op )
variable nb_b : integer;
begin
	
	nb_b  := to_integer(unsigned(b));
	case( op ) is
	
		when "000" =>
			r <= a(31-to_integer(unsigned(b)) downto 0) & a(31 downto 32-to_integer(unsigned(b)));
		when "001" =>
			r <= a(to_integer(unsigned(b))-1 downto 0) & a(31 downto to_integer(unsigned(b)));
		when "010" =>
			r <= a(31-to_integer(unsigned(b)) downto 0) & (to_integer(unsigned(b))-1 downto 0 => '0');
		when "011" =>
			r <= (to_integer(unsigned(b))-1 downto 0 => '0') & a(31 downto to_integer(unsigned(b)));
		when "111" =>
			r <=(to_integer(unsigned(b))-1 downto 0 => a(31)) & a(31 downto to_integer(unsigned(b)));	
		when others =>
			r <= a;
	
	end case ;

end process ; -- shift


end synth;
