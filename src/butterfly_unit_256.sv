module butterfly_unit (
    input i_en,
    input i_clk,
    input i_rst_n,
    input [31:0] i_x,
    input [31:0] i_y,
    input [31:0] i_tw, //2^15~-2^15a
    output [31:0] o_x,
    output [31:0] o_y,
    output o_en
);

logic [1:0] en_stage, en_stage_nxt;
wire signed [15:0] x_r,x_j;
wire signed [15:0] y_r,y_j;
logic signed [15:0] x_r_tmp,x_j_tmp,x_r_tmp_nxt,x_j_tmp_nxt;
logic signed [15:0] y_r_tmp,y_j_tmp,y_r_tmp_nxt,y_j_tmp_nxt;
wire signed [15:0] tw_r, tw_j;
logic signed[31:0] r1,r1_nxt,r2,r2_nxt;
logic signed[31:0] j1,j1_nxt,j2,j2_nxt;
logic signed[15:0] o_x_r , o_x_r_nxt, o_x_j , o_x_j_nxt;
logic signed[15:0] o_y_r , o_y_r_nxt, o_y_j , o_y_j_nxt;

assign x_r = i_x[31:16];
assign x_j = i_x[15:0];
assign y_r = i_y[31:16];
assign y_j = i_y[15:0];
assign tw_r = i_tw[31:16];
assign tw_j = i_tw[15:0];
assign o_x = (en_stage[1])? {o_x_r,o_x_j}:0;
assign o_y = (en_stage[1])? {o_y_r,o_y_j}:0;
assign o_en = en_stage[1];

always_comb begin
    en_stage_nxt = {en_stage[0],i_en};
end

always_comb begin
    if(i_en) begin
        r1_nxt = y_r * tw_r;
        r2_nxt = y_j * tw_j;
        j1_nxt = y_r * tw_j;
        j2_nxt = y_j * tw_r;
        x_r_tmp_nxt = x_r;
        x_j_tmp_nxt = x_j;
        y_r_tmp_nxt = y_r;
        y_j_tmp_nxt = y_j;
        
    end
    else begin
        r1_nxt = 0;
        j1_nxt = 0;
        r2_nxt = 0;
        j2_nxt = 0;
        x_r_tmp_nxt = 0;
        x_j_tmp_nxt = 0;
        y_r_tmp_nxt = 0;
        y_j_tmp_nxt = 0;
    end
end
always_comb begin
    if(en_stage[0]) begin
        o_x_r_nxt = x_r_tmp + r1[29:14] - r2[29:14];
        o_x_j_nxt = x_j_tmp + j1[29:14] + j2[29:14];
        o_y_r_nxt = x_r_tmp - r1[29:14] + r2[29:14];
        o_y_j_nxt = x_j_tmp - j1[29:14] - j2[29:14];
    end
    else begin
        o_x_r_nxt = 0;
        o_x_j_nxt = 0;
        o_y_r_nxt = 0;
        o_y_j_nxt = 0;
    end
end

always_ff @( posedge i_clk or negedge i_rst_n ) begin
    if (!i_rst_n)begin
        en_stage  <= 0;
        r1 <= 0;
        r2 <= 0;
        j1 <= 0;
        j2 <= 0;
        o_x_r <= 0;
        o_x_j <= 0;
        o_y_r <= 0;
        o_y_j <= 0;
        x_r_tmp <= 0;
        x_j_tmp <= 0;
        y_r_tmp <= 0;
        y_j_tmp <= 0;
    end
    else begin
        en_stage  <= en_stage_nxt;
        r1 <= r1_nxt;
        r2 <= r2_nxt;
        j1 <= j1_nxt;
        j2 <= j2_nxt;
        o_x_r <= o_x_r_nxt;
        o_x_j <= o_x_j_nxt;
        o_y_r <= o_y_r_nxt;
        o_y_j <= o_y_j_nxt;
        x_r_tmp <= x_r_tmp_nxt;
        x_j_tmp <= x_j_tmp_nxt;
        y_r_tmp <= y_r_tmp_nxt;
        y_j_tmp <= y_j_tmp_nxt;
    end
    
end
    
endmodule
