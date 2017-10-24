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

    signal address : signed(15 downto 0) := X"0000";
    signal next_address : signed(15 downto 0) := X"0000";

begin

inc_address : process( clk, reset_n )
begin
    if (reset_n = '0') then
        address <= X"0000";

    elsif rising_edge(clk) then
        if (en = '1') then
        --pc is synchronous
            address <= next_address;
        end if ;
    end if;
end process ; -- inc_address

transition : process( add_imm, sel_imm, sel_a, address )
begin
    if (add_imm = '1') then
        --critical point if imm is not a multiple of 4. Modify imm?
        next_address <= address + signed(imm);
    elsif (sel_imm = '1') then
        -- shoudl be ok but doesn't pass the test. Maybe problem in the if order?
        next_address <= signed(imm(13 downto 0) & "00");
    elsif (sel_a = '1') then
        --critical if a not multiple of 4
        next_address <= signed(a);                
    else
        next_address <= address + X"0004";    
    end if ;
end process ; -- transition

--problem in the test, weird, maybe bc the point above
addr <= X"0000" & std_logic_vector(address);


end synth;
