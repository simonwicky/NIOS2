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

  type state_type is (FETCH1, FETCH2, DECODE, R_OP, STORE, BREAK, LOAD1, I_OP, LOAD2,BRANCH,CALL, JUMP);

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

      --when "001110" =>          --0x0E
      --  op_alu <= "011001";

      --when "010110" =>          --0x16
      --  op_alu <= "011010";

      --when "011110" =>          --0x1E
      --  op_alu <= "011011";

      --when "100110" =>          --0x26
      --  op_alu <= "011100";

      --when "101110" =>          --0x2E
      --  op_alu <= "011101";

      --when "110110" =>          --0x36
      --  op_alu <= "011110";
        
      when others =>
        op_alu <= "000000";
        
    end case;

  end process;  -- op_alu_sel

  out_sel_proc : process(current_state)
  begin
    case(current_state) is
      
      when FETCH1 =>
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

      when FETCH2 =>
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

      when DECODE =>
        branch_op  <= '0';
        imm_signed <= '0';
        ir_en      <= '1';

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

      when R_OP =>
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

      when I_OP =>
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

      when STORE =>
        branch_op  <= '0';
        imm_signed <= '1';
        ir_en      <= '0';

        pc_add_imm <= '0';
        pc_en      <= '0';
        pc_sel_a   <= '0';
        pc_sel_imm <= '0';

        rf_wren <= '0';

        sel_addr <= '1';
        sel_b    <= '0';
        sel_mem  <= '0';
        sel_pc   <= '0';
        sel_ra   <= '0';
        sel_rC   <= '0';

        read  <= '0';
        write <= '1';

      when LOAD1 =>
        branch_op  <= '0';
        imm_signed <= '1';
        ir_en      <= '0';

        pc_add_imm <= '0';
        pc_en      <= '0';
        pc_sel_a   <= '0';
        pc_sel_imm <= '0';

        rf_wren <= '0';

        sel_addr <= '1';
        sel_b    <= '0';
        sel_mem  <= '1';
        sel_pc   <= '0';
        sel_ra   <= '0';
        sel_rC   <= '0';

        read  <= '1';
        write <= '0';

      when LOAD2 =>

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
        sel_mem  <= '1';
        sel_pc   <= '0';
        sel_ra   <= '0';
        sel_rC   <= '0';

        read  <= '1';
        write <= '0';

      --when BRANCH =>

      --  branch_op  <= '1';
      --  imm_signed <= '1';
      --  ir_en      <= '0';

      --  pc_add_imm <= '1';
      --  pc_en      <= '0';
      --  pc_sel_a   <= '0';
      --  pc_sel_imm <= '0';

      --  rf_wren <= '0';

      --  sel_addr <= '0';
      --  sel_b    <= '1';
      --  sel_mem  <= '0';
      --  sel_pc   <= '0';
      --  sel_ra   <= '0';
      --  sel_rC   <= '0';

      --  read  <= '0';
      --  write <= '0';

      --when CALL =>

      --  branch_op  <= '0';
      --  imm_signed <= '0';
      --  ir_en      <= '0';

      --  pc_add_imm <= '1';
      --  pc_en      <= '1';
      --  pc_sel_a   <= '0';
      --  pc_sel_imm <= '0';

      --  rf_wren <= '1';

      --  sel_addr <= '0';
      --  sel_b    <= '0';
      --  sel_mem  <= '0';
      --  sel_pc   <= '1';
      --  sel_ra   <= '1';
      --  sel_rC   <= '0';

      --  read  <= '0';
      --  write <= '0';

      when BREAK =>

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


        
        
      when others =>

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
        
    end case;


  end process;  --out_sel_proc






  sel_state : process(current_state)
  begin
    case(current_state) is
      
      when FETCH1 => next_state <= FETCH2;

      when FETCH2 => next_state <= DECODE;

      when DECODE =>
        case(op) is
          
          when "111010" =>              --0X3A

            case(opx) is
              
              when "110100" =>          --0X34
                next_state <= BREAK;

              when others =>
                next_state <= R_OP;
                
            end case;

          when "000100" =>              --0X04
            next_state <= I_OP;

          when "010111" =>              --0X17
            next_state <= LOAD1;

          when "010101" =>              --0X15
            next_state <= STORE;

         -- when "000110" =>          --0x06
         --   next_state <= BRANCH;

         -- when "001110" =>          --0x0E
         --   next_state <= BRANCH;

         -- when "010110" =>          --0x16
         --   next_state <= BRANCH;

         -- when "011110" =>          --0x1E
         --   next_state <= BRANCH;

         -- when "100110" =>          --0x26
         --   next_state <= BRANCH;

         --when "101110" =>          --0x2E
         --   next_state <= BRANCH;

         -- when "110110" =>          --0x36
         --   next_state <= BRANCH;

         -- when "000000" =>           --0x00
         --   next_state <= CALL;
            
          when others =>
            next_state <= BREAK;
            
        end case;

      when LOAD1 => next_state <= LOAD2;

      when R_OP => next_state <= FETCH1;

      when I_OP => next_state <= FETCH1;

      when STORE => next_state <= FETCH1;

      when LOAD2 => next_state <= FETCH1;

      when BREAK => next_state <= BREAK;

      when others => next_state <= BREAK;
                     
    end case;

    
  end process;  -- change_state


  change_state : process(clk, reset_n)
  begin
    if (reset_n = '0') then
      current_state <= FETCH1;

    elsif (rising_edge(clk)) then
      current_state <= next_state;
    end if;
  end process;  -- change_state








end synth;
