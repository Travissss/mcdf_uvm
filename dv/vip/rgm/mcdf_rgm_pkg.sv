//////////////////////////////////////////////////////////////////////////////////
// Engineer: 		Travis
// 
// Create Date: 	03/04/2021 Thu 15:10
// Filename: 		mcdf_rgm_pkg.sv
// class Name: 		mcdf_rgm_pkg
// Project Name: 	mcdf
// Revision 0.01 - File Created 
// Additional Comments:
// -------------------------------------------------------------------------------
// 	-> register model package
//////////////////////////////////////////////////////////////////////////////////

`include "param_def.v"
package mcdf_rgm_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"
import reg_pkg::*;


//////////////////////////////////////////////////////////////////////////////////
// 	-> control register, reg
//////////////////////////////////////////////////////////////////////////////////
class ctrl_reg extends uvm_reg;

    //------------------------------------------
	// Data, Interface, port  Members
	//------------------------------------------
    uvm_reg_field       reserved;
    rand uvm_reg_field  pkt_len;
    rand uvm_reg_field  prio_level;
    rand uvm_reg_field  chnl_en;
  
	//Factory Registration
	//
    `uvm_object_utils(ctrl_reg)
    
    //------------------------------------------
	// Constraints
	//------------------------------------------
    covergroup value_cg;
        option.per_instance = 1;
        reserved    : coverpoint reserved.value[25:0]{
                    bins a0[2] = {[26'h00000:26'h3ffffff]};
                    }
        pkt_len     : coverpoint pkt_len.value[2:0];
        prio_level  : coverpoint prio_level.value[1:0];
        chnl_en     : coverpoint chnl_en.value[0:0];
    endgroup
    
	//----------------------------------------------
	// Methods
	// ---------------------------------------------
	// Standard UVM Methods:
    function new(string name = "ctrl_reg");
        super.new(name, 32, UVM_CVR_ALL);
		void'(set_coverage(UVM_CVR_FIELD_VALS));
        if(has_coverage(UVM_CVR_FIELD_VALS)) begin
            value_cg = new();
        end
    endfunction
    
    virtual function void build();

        
        reserved    = uvm_reg_field::type_id::create("reserved");
        pkt_len     = uvm_reg_field::type_id::create("pkt_len");
        prio_level  = uvm_reg_field::type_id::create("prio_level");
        chnl_en     = uvm_reg_field::type_id::create("chnl_en");
        
        reserved.configure  (this, 26, 6, "RO", 0, 26'h0, 1, 0, 0);        
        pkt_len.configure   (this, 3 , 3, "RW", 0, 3'h0 , 1, 1, 0);   
        prio_level.configure(this, 2 , 1, "RW", 0, 2'h3 , 1, 1, 0);
        chnl_en.configure   (this, 1 , 0, "RW", 0, 1'h1 , 1, 1, 0);   
    endfunction
    
    function void sample(
        uvm_reg_data_t  data,
        uvm_reg_data_t  byte_en,
        bit             is_read,
        uvm_reg_map     map
    
    );
        super.sample(data, byte_en, is_read, map);
        sample_values();
    endfunction
    
    function void sample_values();
    
        super.sample_values();
        if(get_coverage(UVM_CVR_FIELD_VALS))begin
            value_cg.sample();
        end
    endfunction
endclass

//////////////////////////////////////////////////////////////////////////////////
// 	-> state register, read only
//////////////////////////////////////////////////////////////////////////////////
class stat_reg extends uvm_reg;

    //------------------------------------------
	// Data, Interface, port  Members
	//------------------------------------------
    uvm_reg_field       reserved;
    rand uvm_reg_field  fifo_avail;
  
	//Factory Registration
	//
    `uvm_object_utils(stat_reg)
    
    //------------------------------------------
	// Constraints
	//------------------------------------------
    covergroup value_cg;
        option.per_instance = 1;
        reserved    : coverpoint reserved.value[23:0]{
        bins a0[4] = {[24'h00000:24'hffffff]};
        }
        
        fifo_avail  : coverpoint fifo_avail.value[7:0]{
        bins a0[2] = {[8'h00:8'hff]};
        }
    endgroup
    
	//----------------------------------------------
	// Methods
	// ---------------------------------------------
	// Standard UVM Methods:
    function new(string name = "stat_reg");
        super.new(name, 32, UVM_CVR_ALL);
		void'(set_coverage(UVM_CVR_FIELD_VALS));
        if(has_coverage(UVM_CVR_FIELD_VALS)) begin
            value_cg = new();
        end
    endfunction
    
    virtual function void build();
       
        reserved    = uvm_reg_field::type_id::create("reserved");
        fifo_avail  = uvm_reg_field::type_id::create("fifo_avail");
        
        reserved.configure  (this, 24, 8, "RO", 0, 24'h0, 1, 0, 0);        
        fifo_avail.configure(this, 8 , 0, "RO", 0, 8'h20, 1, 1, 0);   
        
    endfunction
    
    function void sample(
        uvm_reg_data_t  data,
        uvm_reg_data_t  byte_en,
        bit             is_read,
        uvm_reg_map     map
    
    );
        super.sample(data, byte_en, is_read, map);
        sample_values();
    endfunction
    
    function void sample_values();
    
        super.sample_values();
        if(get_coverage(UVM_CVR_FIELD_VALS))begin
            value_cg.sample();
        end
    endfunction
endclass


//////////////////////////////////////////////////////////////////////////////////
// 	-> register block including child registers and address map
//////////////////////////////////////////////////////////////////////////////////
class mcdf_rgm extends uvm_reg_block;
    //------------------------------------------
	// Data, Interface, port  Members
	//------------------------------------------
    rand ctrl_reg   chnl0_ctrl_reg;
    rand ctrl_reg   chnl1_ctrl_reg;
    rand ctrl_reg   chnl2_ctrl_reg;
    
    rand stat_reg   chnl0_stat_reg;
    rand stat_reg   chnl1_stat_reg;
    rand stat_reg   chnl2_stat_reg;
  
    uvm_reg_map     map;
	//Factory Registration
	//
    `uvm_object_utils(mcdf_rgm)
    
    function new(string name = "mcdf_rgm");
        super.new(name, UVM_NO_COVERAGE);
    endfunction
    
    virtual function void build();
    `uvm_info("mcdf_rgm_pkg::", $sformatf("build_debug:get into build "), UVM_HIGH)
        chnl0_ctrl_reg  = ctrl_reg::type_id::create("chnl0_ctrl_reg");
        chnl0_ctrl_reg.configure(this);
        chnl0_ctrl_reg.build();

        chnl1_ctrl_reg  = ctrl_reg::type_id::create("chnl1_ctrl_reg");
        chnl1_ctrl_reg.configure(this);
        chnl1_ctrl_reg.build();
        
        chnl2_ctrl_reg  = ctrl_reg::type_id::create("chnl2_ctrl_reg");
        chnl2_ctrl_reg.configure(this);
        chnl2_ctrl_reg.build();
        
        chnl0_stat_reg  = stat_reg::type_id::create("chnl0_stat_reg");
        chnl0_stat_reg.configure(this);                    
        chnl0_stat_reg.build();                            
                                       
        chnl1_stat_reg  = stat_reg::type_id::create("chnl1_stat_reg");
        chnl1_stat_reg.configure(this);                    
        chnl1_stat_reg.build();                            
                                       
        chnl2_stat_reg  = stat_reg::type_id::create("chnl2_stat_reg");
        chnl2_stat_reg.configure(this);
        chnl2_stat_reg.build();
        
        //map name. offset, width(bytes), endianess     
        map = create_map("map", 'h0, 4, UVM_LITTLE_ENDIAN);
        
        map.add_reg(chnl0_ctrl_reg, 32'h00000000, "RW");
        map.add_reg(chnl1_ctrl_reg, 32'h00000004, "RW");
        map.add_reg(chnl2_ctrl_reg, 32'h00000008, "RW");
        map.add_reg(chnl0_stat_reg, 32'h00000010, "RO");
        map.add_reg(chnl1_stat_reg, 32'h00000014, "RO");
        map.add_reg(chnl2_stat_reg, 32'h00000018, "RO");
        
        //specify HDL path
        chnl0_ctrl_reg.add_hdl_path_slice($sformatf("mem[%0d]", `SLV0_RW_REG), 0, 32);
        chnl1_ctrl_reg.add_hdl_path_slice($sformatf("mem[%0d]", `SLV1_RW_REG), 0, 32);
        chnl2_ctrl_reg.add_hdl_path_slice($sformatf("mem[%0d]", `SLV2_RW_REG), 0, 32);
        chnl0_stat_reg.add_hdl_path_slice($sformatf("mem[%0d]", `SLV0_R_REG), 0, 32);
        chnl1_stat_reg.add_hdl_path_slice($sformatf("mem[%0d]", `SLV1_R_REG), 0, 32);
        chnl2_stat_reg.add_hdl_path_slice($sformatf("mem[%0d]", `SLV2_R_REG), 0, 32);
        add_hdl_path("mcdf_tb.dut.ctrl_regs_inst");
        
        lock_model();
    `uvm_info("mcdf_rgm_pkg::", $sformatf("build_debug:get out from build "), UVM_HIGH)
        
    endfunction
                
endclass
        
   
        
//////////////////////////////////////////////////////////////////////////////////
// 	-> reg2mcdf adapter, converting uvm_reg_bus_op to reg_trans
//////////////////////////////////////////////////////////////////////////////////  
class reg2mcdf_adapter extends uvm_reg_adapter;

    //Factory Registration
    //
    `uvm_object_utils(reg2mcdf_adapter) 
   
    //----------------------------------------------
    // Methods
    // ---------------------------------------------
    // Standard UVM Methods:
    function new(string name = "reg2mcdf_adapter");
        super.new(name);
        provides_responses = 1;
    endfunction
    
    function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
        reg_trans tr;
        tr = reg_trans::type_id::create("tr");
        
        tr.cmd  = (rw.kind == UVM_WRITE) ? `WRITE: `READ;
        tr.addr = rw.addr;
        tr.data = rw.data;
		return tr;
    endfunction
    
    function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
        reg_trans tr;
        if(!$cast(tr, bus_item)) begin
            `uvm_fatal("bus2reg_fatal", "provided bus_item is in correct")
			return;
		end
        rw.kind     = (tr.cmd == `WRITE) ? UVM_WRITE : UVM_READ;
        rw.addr     = tr.addr;
        rw.data     = tr.data;
        rw.status   = UVM_IS_OK;
    endfunction
endclass


endpackage
