module AudDSP (
	input i_rst_n,
	input i_clk,
	input i_start,
	input i_pause,
	input i_stop,
	input signed [15:0] i_sram_data, 
	output signed [15:0] o_dac_data,
	output signed[19:0] o_sram_addr,
	output [2:0] state_out
);

logic [7:0] left,right;
logic [1:0] state,state_nxt;
logic signed [15:0] o_dac_data_now,o_dac_data_nxt,pause_data,pause_data_prv;
logic signed [15:0] data_1,data_1_nxt,data_2;
logic signed [19:0] o_sram_addr_now,o_sram_addr_nxt,pause_addr,pause_addr_prv;
logic [2:0] slowcount,slowcount_nxt;

parameter IDLE = 2'b00;
parameter PLAY = 2'b01;
parameter PAUSE = 2'b10;

assign state_out = state;

assign o_sram_addr = o_sram_addr_now;
assign o_dac_data = o_dac_data_now;

always @(*) begin

	case(state)

		IDLE:begin

			o_dac_data_nxt = 0;
			o_sram_addr_nxt = 0;
			pause_data = 0;
			pause_addr = 0;

			if(i_start)begin

				state_nxt = PLAY;

			end

			else begin
				state_nxt = IDLE;
			end

		end

		PLAY:begin

			if (i_stop) begin
				o_sram_addr_nxt = 0;
				o_dac_data_nxt = 16'b0;
				state_nxt = IDLE;
				pause_data = 0;
				pause_addr = 0;
			end
			else begin

				state_nxt = PLAY;
				o_dac_data_nxt = i_sram_data;
				pause_data = i_sram_data;

				if(i_pause) begin
				
					o_dac_data_nxt = 16'b0;
					state_nxt = PAUSE;
					o_sram_addr_nxt = o_sram_addr_now;
					pause_addr = o_sram_addr_now + 1 ;

				end

				else begin
					o_sram_addr_nxt = o_sram_addr_now + 1;
					pause_addr = 0;
				end
					
					
			end
		end

		PAUSE:begin

			pause_data = pause_data_prv;
			pause_addr = pause_addr_prv;

			if (i_stop) begin
				o_sram_addr_nxt = 0;
				o_dac_data_nxt = 16'b0;
				state_nxt = IDLE;
				pause_data = 0;
				pause_addr = 0;
			end

			else if(!i_start) begin

				o_sram_addr_nxt = o_sram_addr_now;
				state_nxt = PAUSE;
				o_dac_data_nxt = 16'b0;
				
			end

			else begin

				o_dac_data_nxt = pause_data_prv;
				o_sram_addr_nxt = pause_addr_prv;
				state_nxt = PLAY;

			end

		end

		default: begin

			pause_data = 0;
			pause_addr = 0;
			o_sram_addr_nxt = 0;
			o_dac_data_nxt = 16'b0;
			state_nxt = IDLE;

		end

	endcase

end

//sequential
always @(posedge i_clk or negedge i_rst_n) begin
    //reset
    if(!i_rst_n) begin
        state <= IDLE;
		o_sram_addr_now <= 0;
		o_dac_data_now <= 0;
		pause_data_prv <= 0;
		pause_addr_prv <= 0;
    end

    else begin
        state <= state_nxt;
		o_sram_addr_now <= o_sram_addr_nxt;
		o_dac_data_now <= o_dac_data_nxt;
		pause_data_prv <= pause_data;
		pause_addr_prv <= pause_addr;
    end
end	

endmodule