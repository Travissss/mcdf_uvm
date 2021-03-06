//////////////////////////////////////////////////////////////////////////////////
// Engineer: 		Travis
// 
// Create Date: 	02/23/2021 Thu 20:29
// Filename: 		chnl_sqr.sv
// class Name: 		chnl_sqr
// Project Name: 	mcdf
// Revision 0.01 - File Created 
// Additional Comments:
// -------------------------------------------------------------------------------
// 	-> channel sequencer
//////////////////////////////////////////////////////////////////////////////////

`ifndef MCDF_CHNL_SQR_SV
`define MCDF_CHNL_SQR_SV

class chnl_sqr extends uvm_sequencer#(chnl_trans);
	
	//Factory Registration
	//
    `uvm_component_utils(chnl_sqr)
 
	//----------------------------------------------
	// Methods
	// ---------------------------------------------
	// Standard UVM Methods:	
	extern function new(string name = "chnl_sqr", uvm_component parent);
	extern virtual function void build_phase(uvm_phase phase);
	
endclass

//Constructor
function chnl_sqr::new(string name = "chnl_sqr", uvm_component parent);
	super.new(name, parent);
endfunction

//Build_Phase
function void chnl_sqr::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

`endif