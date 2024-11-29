module fftx82048(
    input i_clk, 
    input i_rst_n,
    input i_start,
    output o_done,
    output [19:0] o_ADDR,
    inout [31:0] io_DQ, // [15:0]
    output o_WE_N
);
    parameter IDLE = 0;
    parameter FFT = 1;

    wire mem_we;
    wire [7:0] mem_addr0;
    wire [7:0] mem_addr1;
    wire [31:0] mem_data_in0;
    wire [31:0] mem_data_in1;
    wire butterfly_oen;
    wire mem_num;
    logic [31:0] mem_data_out0, mem_data_out0_nxt;
    logic [31:0] mem_data_out1, mem_data_out1_nxt;
    wire addr_enable;
    wire addr_writemode;
    wire butterfly_enable;
    wire ctrl_done;
    wire [7:0] tf_addr;
    wire [31:0] tf_data;
    logic [2:0]state, state_nxt;
    logic input_enable_nxt, input_enable;
    logic done,done_nxt;
//Working memory
assign io_DQ = (~addr_writemode)? 32'bz :(mem_num)? mem_data_in1 : mem_data_in0;
assign o_WE_N = ~addr_writemode;
assign o_ADDR = (mem_num)? mem_addr1 : mem_addr0;
assign o_done = ctrl_done;


always_comb begin
    case(state)
        IDLE:begin
            if(i_start)begin
                state_nxt = FFT;
                input_enable_nxt = 1;
                mem_data_out0_nxt = mem_data_out0;
                mem_data_out1_nxt = mem_data_out1;
            end
            else begin
                state_nxt = state;
                input_enable_nxt = input_enable;
                mem_data_out0_nxt = mem_data_out0;
                mem_data_out1_nxt = mem_data_out1;
            end
        end
        FFT:begin
            if(ctrl_done)begin
                state_nxt = IDLE;
                input_enable_nxt = input_enable;
                mem_data_out0_nxt = mem_data_out0;
                mem_data_out1_nxt = mem_data_out1;
            end
            else begin
                state_nxt = state;
                input_enable_nxt = 0;
                mem_data_out0_nxt = (!addr_writemode && !mem_num)? io_DQ : mem_data_out0;
                mem_data_out1_nxt = (!addr_writemode && mem_num)? io_DQ : mem_data_out1;
            end
        end
        default:begin
            state_nxt = state;
            input_enable_nxt = input_enable;
            mem_data_out0_nxt = mem_data_out0;
            mem_data_out1_nxt = mem_data_out1;
            done_nxt = done;
        end
    endcase
end
always_ff @(posedge i_clk or negedge i_rst_n)begin
    if(!i_rst_n)begin
        state <= IDLE;
        input_enable <= 0;
        mem_data_out0 <= 0;
        mem_data_out1 <= 0;
    end
    else begin
        state <= state_nxt;
        input_enable <= input_enable_nxt;
        mem_data_out0 <= mem_data_out0_nxt;
        mem_data_out1 <= mem_data_out1_nxt;
    end
end

//Twiddle Factor
twiddle_factor twiddle(
    .i_n(tf_addr),
    .o_real(tf_data[31:16]),
    .o_imag(tf_data[15:0])
);
//FFT controller
fftctrl2048 cpu(
    .i_clk(i_clk), 
    .i_rst_n(i_rst_n),
    .i_en(input_enable),
    .i_butteryfly_done(butterfly_oen),
    .o_addr_enable(addr_enable),
    .o_addr_writemode(addr_writemode),
    .o_butterfly_enable(butterfly_enable),
    .o_mem_num(mem_num),
    .o_done(ctrl_done)
    );
//Addresser
fftaddress2048 addresser(
    .i_clk(i_clk),
    .i_rst_n(i_rst_n),
    .i_en(addr_enable),
    .i_rwmode(addr_writemode),
    .o_memwrite(mem_we), //write enable for memory
    .o_mem_addr0(mem_addr0), //memory address
    .o_mem_addr1(mem_addr1),
    .o_tf_addr(tf_addr)
    );
//Butterfly
butterfly_unit butterflyunit(
    .i_clk(i_clk), 
    .i_rst_n(i_rst_n),
    .i_en (butterfly_enable),
    .i_x(mem_data_out0),
    .i_y(mem_data_out1),
    .i_tw(tf_data), //2^15~-2^15a
    .o_x(mem_data_in0),
    .o_y(mem_data_in1),
    .o_en(butterfly_oen)
);

endmodule   
