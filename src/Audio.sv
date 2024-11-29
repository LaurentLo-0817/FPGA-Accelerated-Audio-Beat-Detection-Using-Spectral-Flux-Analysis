module Audio (
	input i_rst_n,
	input i_clk,
	input i_key_0,
	input i_key_1,
	input i_key_2,

	
	// AudDSP and SRAM
	output [19:0] o_SRAM_ADDR,
	inout  [15:0] io_SRAM_DQ,
	output        o_SRAM_WE_N,
	output        o_SRAM_CE_N,
	output        o_SRAM_OE_N,
	output        o_SRAM_LB_N,
	output        o_SRAM_UB_N,
	
	// I2C
	input  i_clk_100k,
	output o_I2C_SCLK,
	inout  io_I2C_SDAT,
	
	// AudPlayer
	input  i_AUD_ADCDAT,
	inout  i_AUD_ADCLRCK,
	inout  i_AUD_BCLK,
	inout  i_AUD_DACLRCK,
	output o_AUD_DACDAT,

	//beat
	output o_beat,
	output [19:0] o_stop_address

	// SEVENDECODER (optional display)
	/*output [2:0] state_out,
	output [3:0] r_addr0,
	output [3:0] r_addr1,
	output [3:0] r_addr2,
	output o_i2c_oen*/
	//output probe
	//output [3:0] 

	// LCD (optional display)
	// input        i_clk_800k,
	// inout  [7:0] o_LCD_DATA,
	// output       o_LCD_EN,
	// output       o_LCD_RS,
	// output       o_LCD_RW,
	// output       o_LCD_ON,
	// output       o_LCD_BLON,

	// LED
	// output  [8:0] o_ledg,
	// output [17:0] o_ledr
);

// design the FSM and states as you like
parameter S_IDLE       = 0;
parameter S_I2C        = 1;
parameter S_RECD       = 2;
parameter S_RECD_PAUSE = 3;
parameter S_PLAY       = 4;
parameter S_PLAY_PAUSE = 5;

wire i2c_oen, i2c_sdat;
logic [19:0] addr_record, addr_play;
logic [15:0] data_record, data_play, dac_data;
logic [2:0] state, state_nxt;
logic I2CStart, I2CStart_nxt;
wire  RecStart, RecPause, Stop, PlayStart, PlayPause;
logic I2C_finish , I2C_finish_nxt;
wire o_finished;
wire Aud_en;

//assign state_out = state;
//assign probe = dac_data[12];
assign r_addr0 = addr_play[3:0];
assign r_addr1 = addr_play[7:4];
assign r_addr2 = addr_play[11:8];
assign o_i2c_oen = i2c_oen;

assign RecStart = (state == S_RECD)? 1:0;
assign RecPause = 0;
// assign PlayStart = (i_key_1 & (state == S_IDLE | state == S_PLAY_PAUSE) & o_finished)? i_AUD_DACLRCK:0;
assign PlayStart = (state == S_PLAY)? 1:0;
assign PlayPause = 0;
assign Stop = (state == S_IDLE)? 1:0;
assign Aud_en = PlayStart;

assign io_I2C_SDAT = (i2c_oen) ? i2c_sdat : 1'bz;

assign o_SRAM_ADDR = (state == S_RECD) ? addr_record : addr_play[19:0];
assign io_SRAM_DQ  = (state == S_RECD) ? {data_record[15:1],1'b0} : 16'dz; // sram_dq as output
assign data_play   = (state != S_RECD) ? io_SRAM_DQ : 16'd0; // sram_dq as input

assign o_SRAM_WE_N = (state == S_RECD) ? 1'b0 : 1'b1;
assign o_SRAM_CE_N = 1'b0;
assign o_SRAM_OE_N = 1'b0;
assign o_SRAM_LB_N = 1'b0;
assign o_SRAM_UB_N = 1'b0;

assign o_beat = dac_data[0];
// below is a simple example for module division
// you can design these as you like
always_comb begin
	case(state)
		S_IDLE: begin
			if(I2C_finish) begin
				if(i_key_0) begin
					state_nxt = S_RECD;
					I2C_finish_nxt = I2C_finish;
					I2CStart_nxt = 0;
				end
				else if(i_key_1) begin
					state_nxt = S_PLAY;
					I2C_finish_nxt = I2C_finish;
					I2CStart_nxt = 0;
				end
				else begin
					state_nxt = S_IDLE;
					I2C_finish_nxt = I2C_finish;
					I2CStart_nxt = 0;
				end
			end
			else begin
				state_nxt = S_I2C;
				I2C_finish_nxt = I2C_finish;
				I2CStart_nxt = 1;
			end
			
		end
		S_I2C: begin
			if(o_finished) begin
				state_nxt = S_IDLE;
				I2C_finish_nxt = 1;
				I2CStart_nxt = I2CStart;
			end
			else begin
				state_nxt = state;
				I2C_finish_nxt = I2C_finish;
				I2CStart_nxt = I2CStart;
			end
		end
		S_RECD: begin
			if(i_key_0) begin
				state_nxt = S_RECD_PAUSE;
				I2C_finish_nxt = I2C_finish;
				I2CStart_nxt = I2CStart;
			end
			else if (i_key_2) begin
				state_nxt = S_IDLE;
				I2C_finish_nxt = I2C_finish;
				I2CStart_nxt = I2CStart;
			end
			else begin
				state_nxt = state;
				I2C_finish_nxt = I2C_finish;
				I2CStart_nxt = I2CStart;
			end
		end
		S_RECD_PAUSE: begin
			if(i_key_0) begin
				state_nxt = S_RECD;
				I2C_finish_nxt = I2C_finish;
				I2CStart_nxt = I2CStart;
			end
			else if (i_key_2) begin
				state_nxt = S_IDLE;
				I2C_finish_nxt = I2C_finish;
				I2CStart_nxt = I2CStart;
			end
			else begin
				state_nxt = state;
				I2C_finish_nxt = I2C_finish;
				I2CStart_nxt = I2CStart;
			end

		end
		S_PLAY: begin
			if(i_key_1) begin
				state_nxt = S_PLAY_PAUSE;
				I2C_finish_nxt = I2C_finish;
				I2CStart_nxt = I2CStart;
			end
			else if (i_key_2) begin
				state_nxt = S_IDLE;
				I2C_finish_nxt = I2C_finish;
				I2CStart_nxt = I2CStart;
			end
			else begin
				state_nxt = state;
				I2C_finish_nxt = I2C_finish;
				I2CStart_nxt = I2CStart;
			end
		end
		S_PLAY_PAUSE:begin
			if(i_key_1) begin
				state_nxt = S_PLAY;
				I2C_finish_nxt = I2C_finish;
				I2CStart_nxt = I2CStart;
			end
			else if (i_key_2) begin
				state_nxt = S_IDLE;
				I2C_finish_nxt = I2C_finish;
				I2CStart_nxt = I2CStart;
			end
			else begin
				state_nxt = state;
				I2C_finish_nxt = I2C_finish;
				I2CStart_nxt = I2CStart;
			end
		end
		default: begin
			state_nxt = S_PLAY_PAUSE;
			I2C_finish_nxt = I2C_finish;
			I2CStart_nxt = I2CStart;
		end
	endcase
end
always_ff @(posedge i_clk or negedge i_rst_n)begin
	if (!i_rst_n) begin
		state <= 0;
		I2C_finish <= 0;
		I2CStart <= 0;
	end
	else begin
		state <= state_nxt;
		I2C_finish <= I2C_finish_nxt;
		I2CStart <= I2CStart_nxt;
	end
end


// === I2cInitializer ===
// sequentially sent out settings to initialize WM8731 with I2C protocal
I2cInitializer init0(
	.i_rst_n(i_rst_n),
	.i_clk(i_clk_100k),
	.i_start(I2CStart),
	.o_finished(o_finished),
	.o_sclk(o_I2C_SCLK),
	.o_sdat(i2c_sdat),
	.o_oen(i2c_oen) // you are outputing (you are not outputing only when you are "ack"ing.)
);

// === AudDSP ===
// responsible for DSP operations including fast play and slow play at different speed
// in other words, determine which data addr to be fetch for player 
AudDSP dsp0(
	.i_rst_n(i_rst_n),
	.i_clk(i_AUD_DACLRCK),
	.i_start(PlayStart),
	.i_pause(PlayPause),
	.i_stop(Stop),
	.i_sram_data(data_play),
	.o_dac_data(dac_data),
	.o_sram_addr(addr_play),
	.state_out(state_out)
);

// === AudPlayer ===
// receive data address from DSP and fetch data to sent to WM8731 with I2S protocal
AudPlayer player0(
	.i_rst_n(i_rst_n),
	.i_bclk(i_AUD_BCLK),
	.i_daclrck(i_AUD_DACLRCK),
	.i_en(Aud_en), // enable AudPlayer only when playing audio, work with AudDSP
	.i_dac_data({dac_data[15:1],1'b0}), //dac_data
	.o_aud_dacdat(o_AUD_DACDAT)
);

// === AudRecorder ===
// receive data from WM8731 with I2S protocal and save to SRAM
AudRecorder recorder0(
	.i_rst_n(i_rst_n), 
	.i_clk(i_AUD_BCLK),
	.i_lrc(i_AUD_ADCLRCK),
	.i_start(RecStart),
	.i_pause(RecPause),
	.i_stop(Stop),
	.i_data(i_AUD_ADCDAT),
	.o_address(addr_record),
	.o_data(data_record),
	.o_stop_address(o_stop_address)
);


endmodule