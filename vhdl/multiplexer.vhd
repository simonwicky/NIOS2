library ieee;
use ieee.std_logic_1164.all;

entity multiplexer is
  port(
    i0  : in  std_logic_vector(31 downto 0);
    i1  : in  std_logic_vector(31 downto 0);
    i2  : in  std_logic_vector(31 downto 0);
    i3  : in  std_logic_vector(31 downto 0);
    sel : in  std_logic_vector(1 downto 0);
    o   : out std_logic_vector(31 downto 0)
    );
end multiplexer;

architecture synth of multiplexer is

  signal s_out : std_logic_vector(31 downto 0);

begin

  mx : process(sel, i0, i1, i2, i3)
  begin
    case(sel) is

      when "00" => s_out <= i0;
      when "01" => s_out <= i1;
      when "10" => s_out <= i2;
      when "11" => s_out <= i3;

      when others => s_out <= i0;
                     
    end case;
  end process;  -- mx

  o <= s_out;


end synth;
