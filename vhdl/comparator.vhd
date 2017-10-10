library ieee;
use ieee.std_logic_1164.all;

entity comparator is
    port(
        a_31    : in  std_logic;
        b_31    : in  std_logic;
        diff_31 : in  std_logic;
        carry   : in  std_logic;
        zero    : in  std_logic;
        op      : in  std_logic_vector(2 downto 0);
        r       : out std_logic
    );
end comparator;

architecture synth of comparator is


begin
	
	comparator : process( a_31, b_31, diff_31, carry, zero, op )
	begin

		case( op ) is								

			--not equal
			when "011" => r <= not zero; 								

			-- >= signed
			when "001" => r <=  (not(a_31) and b_31) or ( not(diff_31) and (not(a_31) xor b_31));

			-- < signed
			when "010" => r <=  (a_31 and not(b_31)) or ( diff_31 and (not(a_31) xor b_31));

			-- >= unsigned
			when "101" => r <=  carry;

			-- < unsigned 
			when "110" => r <=  not (carry);
				
			--equal
			when others => r <= zero;
		
		end case ;
		
	end process ; -- comparator



end synth;
