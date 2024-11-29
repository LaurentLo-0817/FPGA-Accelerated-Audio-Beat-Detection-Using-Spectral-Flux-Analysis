module I2cInitializer(
    input  i_rst_n,
    input  i_clk,
    input  i_start,
    output o_finished,
    output o_sclk,
    inout  o_sdat,
    output o_oen
);
localparam data_bytes = 24;
localparam [data_bytes*7-1: 0] setup_data = {
    24'b0011_0100_000_1111_0_0000_0000,
    24'b0011_0100_000_0100_0_0001_0101,
    24'b0011_0100_000_0101_0_0000_0000,
    24'b0011_0100_000_0110_0_0000_0000,
    24'b0011_0100_000_0111_0_0100_0010,
    24'b0011_0100_000_1000_0_0001_1001,
    24'b0011_0100_000_1001_0_0000_0001
};
localparam S_IDLE = 3'd0;
localparam S_READY = 3'd1;
localparam S_SEND = 3'd2;
localparam S_FINISH = 3'd3;
localparam SCL_READY = 0;
localparam SCL_TRANSFER = 1;
localparam SCL_FALL = 2;


logic [2:0] state,state_nxt;
logic [2:0] SCL_STATE, SCL_STATE_nxt;
logic [data_bytes * 7 - 1: 0] data, data_nxt;
logic buff, buff_nxt;
logic ack;
logic sdat, sdat_nxt;
logic sclk, sclk_nxt;
logic [4:0] bit24_trans_count, bit24_trans_count_nxt;
logic [4:0] bit8_trans_count, bit8_trans_count_nxt; 
logic [2:0] finish_stage, finish_stage_nxt;

assign o_finished = (finish_stage == 2) & (data == 168'd0) & (state == S_FINISH);
assign o_sclk = sclk;
assign o_sdat = (o_oen)? sdat: 1'bz;
// assign o_sdat = sdat;
assign o_oen = (bit8_trans_count == 8)? 0 : 1;
assign ack = (bit8_trans_count == 8)? o_sdat : 0;
always_comb begin
    case(state)
        S_IDLE: begin
            if(i_start)begin
                data_nxt = setup_data;
                sclk_nxt = 1;
				sdat_nxt = 0;
                SCL_STATE_nxt = SCL_READY;
                bit24_trans_count_nxt = 0;
                bit8_trans_count_nxt = 0;
                state_nxt = S_READY;
                finish_stage_nxt = 0;
                buff_nxt = buff;
            end
            else begin
                data_nxt = data;
                sclk_nxt = sclk;
                sdat_nxt = 1;
                SCL_STATE_nxt = SCL_READY;
                bit24_trans_count_nxt = 0;
                bit8_trans_count_nxt = 0;
                state_nxt = S_IDLE;
                finish_stage_nxt = 0;
                buff_nxt = buff;
            end
        end
        S_READY: begin
            if(buff) begin
                data_nxt = data<<1;
                sclk_nxt = 0;
                sdat_nxt = data[data_bytes*7-1];
                SCL_STATE_nxt = SCL_READY;
                bit24_trans_count_nxt = 0;
                bit8_trans_count_nxt = 0;
                state_nxt = S_SEND;
                finish_stage_nxt = 0;
                buff_nxt = buff;
            end
            else begin
                data_nxt = data;
                sclk_nxt = 0;
                sdat_nxt = 0;
                SCL_STATE_nxt = SCL_READY;
                bit24_trans_count_nxt = 0;
                bit8_trans_count_nxt = 0;
                state_nxt = S_READY;
                finish_stage_nxt = 0;
                buff_nxt = 1;
            end
            
        end
        S_SEND: begin
            if(bit24_trans_count <3) begin
                case(SCL_STATE)
                    SCL_READY:begin
                        data_nxt = data;
                        sclk_nxt = 1;
                        sdat_nxt = sdat;
                        SCL_STATE_nxt = SCL_TRANSFER;
                        bit24_trans_count_nxt = bit24_trans_count;
                        bit8_trans_count_nxt = bit8_trans_count;
                        state_nxt = state;
                        finish_stage_nxt = 0;
                        buff_nxt = buff;
                    end
                    SCL_TRANSFER: begin
                        data_nxt = data;
                        sclk_nxt = 0;
                        sdat_nxt = sdat;
                        SCL_STATE_nxt = SCL_FALL;
                        bit24_trans_count_nxt = bit24_trans_count;
                        bit8_trans_count_nxt = bit8_trans_count;
                        state_nxt = state;
                        finish_stage_nxt = 0;
                        buff_nxt = buff;
                    end
                    SCL_FALL: begin
                        data_nxt = (bit8_trans_count == 7)? data : (((bit8_trans_count == 8) & (bit24_trans_count == 2))? data : data << 1);
                        sclk_nxt = 0;
                        sdat_nxt = data[data_bytes*7-1];
                        SCL_STATE_nxt = SCL_READY;
                        bit24_trans_count_nxt = (bit8_trans_count == 8)? bit24_trans_count + 1 : bit24_trans_count;
                        bit8_trans_count_nxt = (bit8_trans_count == 8)? 0 : bit8_trans_count + 1;
                        state_nxt = state;
                        finish_stage_nxt = 0;
                        buff_nxt = buff;
                    end
                default: begin
                    data_nxt = data;
                    sclk_nxt = sclk;
                    sdat_nxt = sdat;
                    SCL_STATE_nxt = SCL_STATE;
                    bit24_trans_count_nxt = bit24_trans_count;
                    bit8_trans_count_nxt = bit8_trans_count;
                    state_nxt = state;
                    finish_stage_nxt = finish_stage;
                    buff_nxt = buff;
                end
                endcase
            end
            else begin
                data_nxt = data;
                sclk_nxt = 1;
                sdat_nxt = 0;
                SCL_STATE_nxt = SCL_READY;
                bit24_trans_count_nxt = 0;
                bit8_trans_count_nxt = 0;
                state_nxt = S_FINISH;
                finish_stage_nxt = 0;
                buff_nxt = buff;
            end
        end
        S_FINISH:begin
            case(finish_stage)
                0: begin
                    data_nxt = data;
                    sclk_nxt = 1;
                    sdat_nxt = 1;
                    SCL_STATE_nxt = SCL_READY;
                    bit24_trans_count_nxt = 0;
                    bit8_trans_count_nxt = 0;
                    state_nxt = S_FINISH;
                    finish_stage_nxt = finish_stage + 1;
                    buff_nxt = buff;
                end

                1: begin
                    data_nxt = data;
                    sclk_nxt = 1;
                    sdat_nxt = 0;
                    SCL_STATE_nxt = SCL_READY;
                    bit24_trans_count_nxt = 0;
                    bit8_trans_count_nxt = 0;
                    state_nxt = S_FINISH;
                    finish_stage_nxt = finish_stage + 1;
                    buff_nxt = 0;
                end

                2: begin
                    if(data == 168'd0)begin
                        data_nxt = data;
                        sclk_nxt = 1;
                        sdat_nxt = 1;
                        SCL_STATE_nxt = SCL_READY;
                        bit24_trans_count_nxt = 0;
                        bit8_trans_count_nxt = 0;
                        state_nxt = S_FINISH;
                        finish_stage_nxt = 2;
                        buff_nxt = buff;
                    end
                    else begin
                        data_nxt = data<<1;
                        sclk_nxt = 0;
                        sdat_nxt = data[data_bytes*7-1];
                        SCL_STATE_nxt = SCL_READY;
                        bit24_trans_count_nxt = 0;
                        bit8_trans_count_nxt = 0;
                        state_nxt = S_SEND;
                        finish_stage_nxt = 0;
                        buff_nxt = buff;
                    end
                    
                end
            default: begin
                data_nxt = data;
                sclk_nxt = sclk;
                sdat_nxt = sdat;
                SCL_STATE_nxt = SCL_STATE;
                bit24_trans_count_nxt = bit24_trans_count;
                bit8_trans_count_nxt = bit8_trans_count;
                state_nxt = state;
                finish_stage_nxt = finish_stage;
                buff_nxt = buff;
            end
            
            endcase
            
        end


    default: begin
        data_nxt = data;
        sclk_nxt = sclk;
        sdat_nxt = sdat;
        SCL_STATE_nxt = SCL_STATE;
        bit24_trans_count_nxt = bit24_trans_count;
        bit8_trans_count_nxt = bit8_trans_count;
        state_nxt = state;
        finish_stage_nxt = finish_stage;
        buff_nxt = buff;
    end

    endcase
end
always_ff @(posedge i_clk or negedge i_rst_n)begin
    if(!i_rst_n)begin
        data <= 0;
        sclk <= 1;
        sdat <= 1;
        SCL_STATE <= SCL_READY;
        bit24_trans_count <= 0;
        bit8_trans_count <= 0;
        state <= S_IDLE;
        finish_stage <= 0;
        buff <= 0;
    end
    else begin
        data <= data_nxt;
        sclk <= sclk_nxt;
        sdat <= sdat_nxt;
        SCL_STATE <= SCL_STATE_nxt;
        bit24_trans_count <= bit24_trans_count_nxt;
        bit8_trans_count <= bit8_trans_count_nxt;
        state <= state_nxt;
        finish_stage <= finish_stage_nxt;
        buff <= buff_nxt;
    end

end
endmodule
// module I2cInitializer(
//     input  i_rst_n,
//     input  i_clk,
//     input  i_start,
//     output o_finished,
//     output o_sclk,
//     inout  o_sdat,
//     output o_oen
// );
// localparam data_bytes = 30;
// localparam [data_bytes * 8-1: 0] setup_data = {
//     24'b00110100_000_1001_0_0000_0001,
//     24'b00110100_000_1000_0_0001_1001,
//     24'b00110100_000_0111_0_0100_0010,
//     24'b00110100_000_0110_0_0000_0000,
//     24'b00110100_000_0101_0_0000_0000,
//     24'b00110100_000_0100_0_0001_0101,
//     24'b00110100_000_0011_0_0111_1001,
//     24'b00110100_000_0010_0_0111_1001,
//     24'b00110100_000_0001_0_1001_0111,
//     24'b00110100_000_0000_0_1001_0111
// };
// localparam S_IDLE = 0;
// localparam S_READY = 1;
// localparam S_PROC = 2;
// localparam S_FIN1 = 3;
// localparam S_FIN2 = 4;
// localparam S_FIN3 = 5;
// localparam S_FIN4 = 6;
// localparam SCLK_READY = 0;
// localparam SCLK_OUTPUT = 1;
// localparam SCLK_MOD = 2;

// logic [2:0] state,state_nxt;
// logic [2:0] sclk_S, sclk_Snxt;
// logic [data_bytes * 8 - 1: 0] data, data_nxt;
// logic oen;
// logic sdat, sdat_nxt;
// logic sclk, sclk_nxt;
// logic finish, finish_nxt;
// logic [4:0] ctr1, ctr1_nxt; //ctr1=0~3 3rd means 24'b send finish
// logic [4:0] ctr2, ctr2_nxt; //ctr2=0~8 8th cycle send high impedence(oen=1)

// assign o_finished = finish;
// assign o_sclk = sclk;
// assign o_sdat = oen? sdat: 1'bz;
// assign o_oen = oen;
// assign o_state = ~o_finished & (state>=S_READY);

// always_comb begin
// 	state_nxt = state;
// 		data_nxt = data;
// 		sdat_nxt = sdat;
// 		sclk_nxt = sclk;
// 		sclk_Snxt = sclk_S;
// 		finish_nxt = 0;
// 		oen = 1;
// 		ctr1_nxt = 0;
// 		ctr2_nxt = 0;
// 	case(state)
// 		S_IDLE: begin
// 			if(i_start) begin
// 				state_nxt = S_READY;
// 				data_nxt = setup_data;
// 				sclk_nxt = 1;
// 				sdat_nxt = 0;
// 				sclk_Snxt = SCLK_READY;
// 			end
// 			else begin
// 				state_nxt = state;
// 				data_nxt = data;
// 				sdat_nxt = sdat;
// 				sclk_nxt = sclk;
// 				sclk_Snxt = sclk_S;
// 			end
// 			finish_nxt = 0;
// 			oen = 1;
// 			ctr1_nxt = 0;
// 			ctr2_nxt = 0;
// 		end
// 		S_READY: begin
// 			state_nxt = S_PROC;
// 			data_nxt = data << 1;
// 			sdat_nxt = data[data_bytes * 8 - 1];
// 			sclk_nxt = 0;
// 			sclk_Snxt = SCLK_READY;
// 			finish_nxt = finish;
// 			oen = 1;
// 			ctr1_nxt = 0;
// 			ctr2_nxt = 0;
// 		end
// 		S_PROC: begin
// 			if(ctr1<5'd3) begin
// 				case(sclk_S)
// 					SCLK_READY: begin
// 						ctr2_nxt = ctr2;
// 						ctr1_nxt = ctr1;
// 						sdat_nxt = sdat;
// 						sclk_nxt = 1;
// 						sclk_Snxt = SCLK_OUTPUT;
// 						data_nxt = data;
// 					end
// 					SCLK_OUTPUT: begin
// 						ctr2_nxt = ctr2;
// 						ctr1_nxt = ctr1;
// 						sdat_nxt = sdat;
// 						sclk_nxt = 0;
// 						sclk_Snxt = SCLK_MOD;
// 						data_nxt = data;
// 					end
// 					SCLK_MOD: begin
// 						ctr2_nxt = (ctr2==5'd8)? 0:ctr2 + 5'd1;
// 						ctr1_nxt = (ctr2==5'd8)? ctr1+5'd1:ctr1;
// 						sdat_nxt = data[data_bytes * 8 - 1];
// 						sclk_nxt = 0;
// 						sclk_Snxt = SCLK_READY;
// 						data_nxt = (ctr2==5'd7)? data: ((ctr2==5'd8)&&(ctr1==5'd2))? data: data << 1;
// 					end
// 				endcase
// 				oen = (ctr2==5'd8)? 0:1;
// 				state_nxt = state;
// 				finish_nxt = 0;
// 			end
// 			else begin
// 				ctr2_nxt = 0;
// 				ctr1_nxt = 0;
// 				sdat_nxt = 0;
// 				sclk_nxt = 1;
// 				sclk_Snxt = SCLK_READY;
// 				data_nxt = data;
// 				oen = 1;
// 				state_nxt = S_FIN1;
// 				finish_nxt = 0;
// 			end
// 		end
// 		S_FIN1: begin
// 			ctr2_nxt = 0;
// 			ctr1_nxt = 0;
// 			sdat_nxt = 1;
// 			sclk_nxt = 1;
// 			sclk_Snxt = SCLK_READY;
// 			data_nxt = data;
// 			oen = 1;
// 			state_nxt = S_FIN2;
// 			finish_nxt = 0;
// 		end
// 		S_FIN2: begin
// 			ctr2_nxt = 0;
// 			ctr1_nxt = 0;
// 			sdat_nxt = 0;
// 			sclk_nxt = 1;
// 			sclk_Snxt = SCLK_READY;
// 			data_nxt = data;
// 			oen = 1;
// 			state_nxt = S_FIN3;
// 			finish_nxt = 0;
// 		end
// 		S_FIN3: begin
// 			ctr2_nxt = 0;
// 			ctr1_nxt = 0;
// 			sdat_nxt = 0;
// 			sclk_nxt = 0;
// 			sclk_Snxt = SCLK_READY;
// 			data_nxt = data;
// 			oen = 1;
// 			state_nxt = S_FIN4;
// 			finish_nxt = 0;
// 		end
// 		S_FIN4: begin
// 			if(data!=240'd0) begin
// 				state_nxt = S_PROC;
// 				data_nxt = data << 1;
// 				sdat_nxt = data[data_bytes * 8 - 1];
// 				sclk_nxt = 0;
// 				sclk_Snxt = SCLK_READY;
// 				finish_nxt = 0;
// 				oen = 1;
// 				ctr1_nxt = 0;
// 				ctr2_nxt = 0;
// 			end
// 			else begin
// 				state_nxt = S_FIN4;
// 				data_nxt = data;
// 				sdat_nxt = 0;
// 				sclk_nxt = 0;
// 				sclk_Snxt = SCLK_READY; //don't care
// 				finish_nxt = 1;
// 				oen = 1;
// 				ctr1_nxt = 0;
// 				ctr2_nxt = 0;
// 			end
// 		end
// 		default: begin
// 			state_nxt = state;
// 			data_nxt = data;
// 			sdat_nxt = sdat;
// 			sclk_nxt = sclk;
// 			sclk_Snxt = sclk_S;
// 			finish_nxt = 0;
// 			oen = 1;
// 			ctr1_nxt = 0;
// 			ctr2_nxt = 0;
// 		end
// 	endcase
// end
// always_ff @(posedge i_clk or negedge i_rst_n) begin
// 	if(~i_rst_n) begin
// 		state <= S_IDLE;
// 		data <= setup_data;
// 		ctr1 <= 0;
// 		ctr2 <= 0;
// 		sdat <= 1;
// 		sclk <= 1;
// 		sclk_S <= SCLK_MOD;
// 		finish <= 0;
// 	end else begin
// 		state <= state_nxt;
// 		data <= data_nxt;
// 		ctr1 <= ctr1_nxt;
// 		ctr2 <= ctr2_nxt;
// 		sdat <= sdat_nxt;
// 		sclk <= sclk_nxt;
// 		sclk_S <= sclk_Snxt;
// 		finish <= finish_nxt;
// 	end
// end
// endmodule