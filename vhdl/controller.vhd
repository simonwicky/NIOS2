library ieee;
use ieee.std_logic_1164.all;

entity controller is
    port(
        clk        : in  std_logic;
        reset_n    : in  std_logic;
        -- instruction opcode
        op         : in  std_logic_vector(5 downto 0);
        opx        : in  std_logic_vector(5 downto 0);
        -- activates branch condition
        branch_op  : out std_logic;
        -- immediate value sign extention
        imm_signed : out std_logic;
        -- instruction register enable
        ir_en      : out std_logic;
        -- PC control signals
        pc_add_imm : out std_logic;
        pc_en      : out std_logic;
        pc_sel_a   : out std_logic;
        pc_sel_imm : out std_logic;
        -- register file enable
        rf_wren    : out std_logic;
        -- multiplexers selections
        sel_addr   : out std_logic;
        sel_b      : out std_logic;
        sel_mem    : out std_logic;
        sel_pc     : out std_logic;
        sel_ra     : out std_logic;
        sel_rC     : out std_logic;
        -- write memory output
        read       : out std_logic;
        write      : out std_logic;
        -- alu op
        op_alu     : out std_logic_vector(5 downto 0)
    );
end controller;

architecture synth of controller is

	type state_type is (FETCH1, FETCH2, DECODE, R_OP, STORE,BREAK,LOAD1,I_OP,LOAD2);

	signal current_state : state_type;
	signal next_state : state_type;

begin




op_alu_sel : process( op,opx )
begin
	
	case( op ) is
	
		when "111010" =>

			case( opx ) is
			
				when "001110" =>
					op_alu <= "100001";

				when "011011" =>
					op_alu <= "110011";

				when others =>
					op_alu <= "000000";
			
			end case ;

		when "000100" =>
			op_alu <= "000000";

		when "010111" =>
			op_alu <= "000000";

		when "010101" =>
			op_alu <= "000000";
				
		when others =>
			op_alu <= "000000";
	
	end case ;

end process ; -- op_alu_sel


reset : process( reset_n )
begin
	if (reset_n = '1')  then
		current_state <= FETCH1;
	end if ;
	
end process ; -- reset








end synth;
