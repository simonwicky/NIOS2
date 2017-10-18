library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
    port(
        clk     : in  std_logic;
        reset_n : in  std_logic;
        en      : in  std_logic;
        sel_a   : in  std_logic;
        sel_imm : in  std_logic;
        add_imm : in  std_logic;
        imm     : in  std_logic_vector(15 downto 0);
        a       : in  std_logic_vector(15 downto 0);
        addr    : out std_logic_vector(31 downto 0)
    );
end PC;

architecture synth of PC is

    signal address : unsigned(15 downto 0) := X"0000";
    signal next_address : unsigned(15 downto 0) := X"0000";

begin

inc_address : process( clk, reset_n )
begin
    if (reset_n = '0') then
        address <= X"0000";
        next_address <= X"0000";

    elsif rising_edge(clk) then
        if (en = '1') then
            if (add_imm = '1') then
                next_address <= address + X"0004" + unsigned(imm);
            else
                next_address <= address + X"0004";    
            end if ;
            address <= next_address;
        end if ;
    end if;
end process ; -- inc_address

addr <= X"0000" & std_logic_vector(address);


end synth;
