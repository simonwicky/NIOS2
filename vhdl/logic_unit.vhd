library ieee;
use ieee.std_logic_1164.all;
entity logic_unit is
  port(
    a  : in  std_logic_vector(31 downto 0);
    b  : in  std_logic_vector(31 downto 0);
    op : in  std_logic_vector(1 downto 0);
    r  : out std_logic_vector(31 downto 0)
    );
end logic_unit;



architecture synth of logic_unit is

  signal output : std_logic_vector(31 DOWNTO 0) := (others => '0');

begin


  output_choose : process(op,a,b)
  begin

    case(op) is

      when "00" =>
        output <= a NOR b;

      when "01" =>
        output <= a AND b;

      when "10" =>
        output <= a OR b;

      when "11" =>
        output <= a XOR b;
      when others =>
        output <= (others => '0');

    end case;


  end process;  -- output_choose

  r <= output;


end synth;
