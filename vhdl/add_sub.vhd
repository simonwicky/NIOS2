library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_sub is
    port(
        a        : in  std_logic_vector(31 downto 0);
        b        : in  std_logic_vector(31 downto 0);
        sub_mode : in  std_logic;
        carry    : out std_logic;
        zero     : out std_logic;
        r        : out std_logic_vector(31 downto 0)
    );
end add_sub;

architecture synth of add_sub is

	signal s_b_33 : std_logic_vector(32 downto 0);
	signal s_a_33 : std_logic_vector(32 downto 0);
	signal zero_VAL : std_logic_vector(32 downto 0);
	signal sub_mode_vec_val : std_logic_vector(32 downto 0);
	
	
	signal s_sub_mode_vec : std_logic_vector(31 downto 0);
	signal s_r : std_logic_vector(32 downto 0);

begin

	s_sub_mode_vec <= (others => sub_mode);
	sub_mode_vec_val <= (32 downto 1 => '0') & sub_mode;
	

	r <= s_r(31 downto 0);

	carry <= s_r(32);


	s_b_33 <= '0' & (b xor s_sub_mode_vec);
	s_a_33 <= '0' & a;


	s_r <= std_logic_vector(unsigned(s_a_33) + unsigned(s_b_33) + unsigned(sub_mode_vec_val));
	
	

	zero <= '1' when s_r(31 downto 0) = X"00000000" else '0';



	


end synth;
