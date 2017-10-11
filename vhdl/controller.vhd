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
begin




op_alu_sel : process( op,opx )
begin
	
	case( op ) is
	
		when X"3A" =>

			case( opx ) is
			
				when X"0E" =>
					op_alu <= "100001";

				when X"1B" =>
					op_alu <= "110011";

				when X"34" =>
				 --break
								
				when others =>
			
			end case ;

		when X"04" =>
			op_alu <= "000000";

		when X"17" =>
			op_alu <= "000000";

		when X"15" =>
			op_alu <= "000000";
			
	
		when others =>
	
	end case ;

end process ; -- op_alu_sel

end synth;
