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

	shift_rotate : process( a,b,op )
		variable v : std_logic_vector(31 downto 0);
	begin
		v := a;

		case( op ) is
					
			when "010" =>

				-- shift_left
				
				for i in 0 to 4 loop 
					if (b(i) = '1') then
						v := v(31 - (2 ** i) downto 0) & ((2 ** i) - 1 downto 0 => '0'); 
					end if; 
				end loop;
				

			when "011" => 

				-- shift_right
					 
				for i in 0 to 4 loop 
					if (b(i) = '1') then
						v := ((2 ** i) -1 downto 0 => '0') & v(31 downto 2 ** i); 
					end if; 
				end loop; 
			

			when "111" => 
				-- shift_right_arith
				
				for i in 0 to 4 loop 
					if (b(i) = '1') then
						v := ((2 ** i) -1 downto 0 => v(31)) & v(31 downto 2 ** i); 
					end if; 
				end loop;  	


			when "000" =>
				-- rotate_left
				
				for i in 0 to 4 loop 
					if (b(i) = '1') then
						v := v( 31 - (2**i) downto 0) & v( 31 downto 31 - (2 ** i ) + 1 ) ;
					end if; 
				end loop; 
				 

		
			when others =>

				-- rotate_right
				
				for i in 0 to 4 loop 
					if (b(i) = '1') then
						v := v((2**i) -1 downto 0) & v(31 downto 2 ** i);
					end if; 
				end loop; 
				

		
		end case ;

		r <= v; 

	end process ; -- shift_rotate


end synth;
