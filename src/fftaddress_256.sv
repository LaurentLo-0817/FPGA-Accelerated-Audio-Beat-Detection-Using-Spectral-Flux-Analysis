module fftaddress2048(
    input i_clk,
    input i_rst_n,
    input i_en,
    input i_rwmode, //1: Write 0:Read
    output o_memwrite,
    output [7:0] o_mem_addr0,
    output [7:0] o_mem_addr1,
    output [7:0] o_tf_addr
);

    parameter IDLE = 0;
    parameter ADD = 1;

    wire [7:0] data0;
    wire [7:0] data1;
    logic [10:0] index, index_nxt;
    logic [2:0] state,state_nxt;
    wire [10:0] index_1;

    bitrev11 br0(.data_in(index[7:0]), .data_out(data0));
    bitrev11 br1(.data_in(index_1), .data_out(data1));
    bitcirc_r11 bc0(.n(index[10:8]), .data_in(data0), .data_out(o_mem_addr0));
    bitcirc_r11 bc1(.n(index[10:8]), .data_in(data1), .data_out(o_mem_addr1));
    assign o_memwrite = i_rwmode;
    assign o_tf_addr = (index[7:0] >> (8-index[10:8])) << (7-index[10:8]);
    assign index_1 = index[7:0]+1;

    always_comb begin
        if(i_en)begin
            index_nxt = (index == 2046)? 0 :index +2;
        end
        else begin
            index_nxt = index;
        end
    end
    always_ff @(posedge i_clk or negedge i_rst_n) begin
        if(!i_rst_n)begin
            index <= 0;
        end
        else begin
            index <= index_nxt;
        end
    end

endmodule

module bitrev11(input wire [7:0] data_in, output wire [7:0] data_out);
assign data_out[0] = data_in[7];
assign data_out[1] = data_in[6];
assign data_out[2] = data_in[5];
assign data_out[3] = data_in[4];
assign data_out[4] = data_in[3];
assign data_out[5] = data_in[2];
assign data_out[6] = data_in[1];
assign data_out[7] = data_in[0];
// assign data_out[8] = data_in[0];
// assign data_out[9] = data_in[1];
// assign data_out[10] = data_in[0];
endmodule

module bitcirc_r11(input wire [2:0] n, input wire [7:0] data_in, output wire [7:0] data_out);
//Bit circulates data_in to the right by n bits
wire [7:0] data_out3;
wire [7:0] data_out2;
wire [7:0] data_out1;
// assign data_out3 = (n[3] == 1) ? {data_in[7:0], data_in[8]} : data_in;
assign data_out2 = (n[2] == 1) ? {data_in[3:0], data_out3[7:4]} : data_in;
assign data_out1 = (n[1] == 1) ? {data_out2[1:0], data_out2[7:2]} : data_out2;
assign data_out = (n[0] == 1) ? {data_out1[0], data_out1[7:1]} : data_out1;
endmodule // bitcirc_r11
