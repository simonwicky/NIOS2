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

  type state_type is (FETCH1, FETCH2, DECODE, R_OP, STORE, BREAK, LOAD1, I_OP, LOAD2);

  signal current_state : state_type;
  signal next_state    : state_type;

begin




  op_alu_sel : process(op, opx)
  begin
    
    case(op) is
      
      when "111010" =>

        case(opx) is
          
          when "001110" =>
            op_alu <= "100001";

          when "011011" =>
            op_alu <= "110011";

          when others =>
            op_alu <= "000000";
            
        end case;

      when "000100" =>
        op_alu <= "000000";

      when "010111" =>
        op_alu <= "000000";

      when "010101" =>
        op_alu <= "000000";
        
      when others =>
        op_alu <= "000000";
        
    end case;

  end process;  -- op_alu_sel

  fetch1_proc : process(current_state)
  begin
    branch_op  <= '0';
    imm_signed <= '0';
    ir_en      <= '0';

    pc_add_imm <= '0';
    pc_en      <= '0';
    pc_sel_a   <= '0';
    pc_sel_imm <= '0';

    rf_wren <= '0';

    sel_addr <= '0';
    sel_b    <= '0';
    sel_mem  <= '0';
    sel_pc   <= '0';
    sel_ra   <= '0';
    sel_rC   <= '0';

    read  <= '1';
    write <= '0';
    
  end process;  -- fetch1_proc

fetch2_proc : process(current_state)
  begin
    branch_op  <= '0';
    imm_signed <= '0';
    ir_en      <= '1';

    pc_add_imm <= '0';
    pc_en      <= '1';
    pc_sel_a   <= '0';
    pc_sel_imm <= '0';

    rf_wren <= '0';

    sel_addr <= '0';
    sel_b    <= '0';
    sel_mem  <= '0';
    sel_pc   <= '0';
    sel_ra   <= '0';
    sel_rC   <= '0';

    read  <= '0';
    write <= '0';
    
  end process;  -- fetch2_proc

decode_proc : process(current_state)
  begin
    branch_op  <= '0';
    imm_signed <= '0';
    ir_en      <= '1';

    pc_add_imm <= '0';
    pc_en      <= '1';
    pc_sel_a   <= '0';
    pc_sel_imm <= '0';

    rf_wren <= '0';

    sel_addr <= '0';
    sel_b    <= '0';
    sel_mem  <= '0';
    sel_pc   <= '0';
    sel_ra   <= '0';
    sel_rC   <= '0';

    read  <= '0';
    write <= '0';
    
  end process;  -- decode_proc


R_OP_process : process( current_state )
begin

    branch_op  <= '0';
    imm_signed <= '0';
    ir_en      <= '0';

    pc_add_imm <= '0';
    pc_en      <= '0';
    pc_sel_a   <= '0';
    pc_sel_imm <= '0';

    rf_wren <= '1';

    sel_addr <= '0';
    sel_b    <= '1';
    sel_mem  <= '0';
    sel_pc   <= '0';
    sel_ra   <= '0';
    sel_rC   <= '1';

    read  <= '0';
    write <= '0';

  
end process ; -- R_OP_process

I_OP_process : process( current_state )
begin

    branch_op  <= '0';
    imm_signed <= '1';
    ir_en      <= '0';

    pc_add_imm <= '0';
    pc_en      <= '0';
    pc_sel_a   <= '0';
    pc_sel_imm <= '0';

    rf_wren <= '1';

    sel_addr <= '0';
    sel_b    <= '0';
    sel_mem  <= '0';
    sel_pc   <= '0';
    sel_ra   <= '0';
    sel_rC   <= '0';

    read  <= '0';
    write <= '0';

  
end process ; -- I_OP_process

STORE_process : process( current_state )
begin

    branch_op  <= '0';
    imm_signed <= '1';
    ir_en      <= '0';

    pc_add_imm <= '0';
    pc_en      <= '0';
    pc_sel_a   <= '0';
    pc_sel_imm <= '0';

    rf_wren <= '1';

    sel_addr <= '1';
    sel_b    <= '0';
    sel_mem  <= '0';
    sel_pc   <= '0';
    sel_ra   <= '0';
    sel_rC   <= '0';

    read  <= '0';
    write <= '1';

  
end process ; -- STORE_process

LOAD1_process : process( current_state )
begin

    branch_op  <= '0';
    imm_signed <= '0';
    ir_en      <= '0';

    pc_add_imm <= '0';
    pc_en      <= '0';
    pc_sel_a   <= '0';
    pc_sel_imm <= '0';

    rf_wren <= '1';

    sel_addr <= '1';
    sel_b    <= '0';
    sel_mem  <= '1';
    sel_pc   <= '0';
    sel_ra   <= '0';
    sel_rC   <= '0';

    read  <= '1';
    write <= '0';

  
end process ; -- LOAD1_process

LOAD2_process : process( current_state )
begin

    branch_op  <= '0';
    imm_signed <= '1';
    ir_en      <= '0';

    pc_add_imm <= '0';
    pc_en      <= '0';
    pc_sel_a   <= '0';
    pc_sel_imm <= '0';

    rf_wren <= '1';

    sel_addr <= '1';
    sel_b    <= '0';
    sel_mem  <= '0';
    sel_pc   <= '0';
    sel_ra   <= '0';
    sel_rC   <= '0';

    read  <= '1';
    write <= '0';

  
end process ; -- LOAD2_process

BREAK_process : process( current_state )
begin

    branch_op  <= '0';
    imm_signed <= '0';
    ir_en      <= '0';

    pc_add_imm <= '0';
    pc_en      <= '0';
    pc_sel_a   <= '0';
    pc_sel_imm <= '0';

    rf_wren <= '0';

    sel_addr <= '0';
    sel_b    <= '0';
    sel_mem  <= '0';
    sel_pc   <= '0';
    sel_ra   <= '0';
    sel_rC   <= '0';

    read  <= '0';
    write <= '0';

  
end process ; -- BREAK_process


sel_state : process( current_state )
begin
  case( current_state ) is
  
    when FETCH1 => next_state <= FETCH2;

    when FETCH2 => next_state <= DECODE;

    when DECODE =>
      case(op) is
      
      when "111010" =>          --0X3A

        case(opx) is
          
          when "110100" =>      --0X34
            next_state <= BREAK;

          when others =>
            next_state <= R_OP;
            
        end case;

      when "000100" =>          --0X04
        next_state <= I_OP;

      when "010111" =>          --0X17
        next_state <= LOAD1;

      when "010101" =>          --0X15
        next_state <= STORE;
        
      when others =>
        next_state <= BREAK;
        
    end case;

    when LOAD1 => next_state <= LOAD2;
   
    when R_OP => next_state <= FETCH1;
   
    when I_OP => next_state <= FETCH1;
   
    when STORE => next_state <= FETCH1;
   
    when LOAD2 => next_state <= FETCH1;

    when BREAK => next_state <= BREAK;
 
    when others => BREAK;
  
  end case ;

  
end process ; -- change_state

reset : process(reset_n)
begin
  if (reset_n = '1') then
    current_state <= FETCH1;
  end if;
  
end process;  -- reset

change_state : process( clk )
begin
  if (rising_edge(clk)) then
    current_state <= next_state;
  end if ;
end process ; -- change_state








end synth;
