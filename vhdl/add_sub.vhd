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
  
  --signal nb_a   : signed(31 downto 0);
  --signal nb_b   : signed(31 downto 0);
  --signal nb_r   : signed(31 downto 0) := (others => '1');
  signal result : std_logic_vector(32 downto 0) := X"00000000" & '0';

begin

  adder : process(a,b,sub_mode)
  begin

    if sub_mode = '0' then
      result <= std_logic_vector(('0' & signed(a)) + ('0' & signed(b)));
    else
      result <= std_logic_vector(('0' & signed(a)) - ('1' & signed(b))); -- the first 1 is inverted by the - to become a zero
    end if;


    if result = (X"00000000" & '0') then
      zero <= '1';
    else
      zero <= '0';
    end if;




  end process;  -- adder
    carry  <= result(32);
    r      <= result(31 downto 0);




end synth;
