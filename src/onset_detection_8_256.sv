module onset_detection(
    input i_clk, 
    input i_rst_n,
    input i_start,
    input [19:0]i_end_address,
    output o_finish,
    output [19:0] o_SRAM_ADDR,
    inout [15:0] io_SRAM_DQ, // [15:0]
	output o_SRAM_WE_N
);
    //SRAM OFFSET 10237000
    parameter IDLE = 0;
    parameter LOAD = 1;
    parameter FFT = 2; 
    parameter REV = 3;
    parameter STORE = 4;
    parameter DIFF = 5;
    parameter SAVE = 6;
    parameter AVG = 7;
    parameter WRITE = 8;
    parameter FIX = 9;

    wire fft_start,fft_done,fft_we_n;
    wire [31:0] fft_dq;
    wire [15:0] sqrt_x1,sqrt_x2,sqrt_y;
    wire [45:0]flux_score;
    wire [2:0]counter_rev;
    wire [19:0] fft_addr;
    logic [15:0] audio_beat,audio_beat_nxt;
    logic sram_we_n,sram_we_n_nxt;
    logic [3:0] state,state_nxt;
    logic [31:0] FFT_data [0:7];
    logic [31:0] FFT_data_nxt [0:7];
    logic beat_mark,beat_mark_nxt;
    logic [19:0] sram_addr,sram_addr_nxt;
    logic [19:0] sram_addr_tmp,sram_addr_tmp_nxt;
    logic [2:0] counter,counter_nxt;
    logic [45:0] flux,flux_nxt;
    logic [3:0] win_pointer, win_pointer_nxt;
    logic [20:0] load_counter, load_counter_nxt;
    logic [45:0] flux_avg[0:15];
    logic [45:0]flux_avg_nxt [0:15];
    logic [19:0] flux_counter,flux_counter_nxt;
    logic [24:0] flux_store [0:7];
    logic [24:0] flux_store_nxt [0:7];
    logic [8:0] sum_counter,sum_counter_nxt;
    logic rev_flag[0:7];
    logic rev_flag_nxt[0:7];
    logic [15:0] last_spectrum, last_spectrum_nxt;


    assign o_SRAM_ADDR = (state == DIFF)? (flux_counter + 10237000) : sram_addr;
    assign io_SRAM_DQ = (o_SRAM_WE_N)? 16'bz : (state == DIFF)? last_spectrum : audio_beat;
    assign o_SRAM_WE_N = sram_we_n;
    assign fft_dq = (fft_we_n)? FFT_data[fft_addr] : 32'bz;
    assign fft_start = (state == FFT)? 1:0;
    assign sqrt_x1 = FFT_data[flux_counter][31:16];
    assign sqrt_x2 = FFT_data[flux_counter][15:0];
    assign flux_score =(flux_avg[0]+flux_avg[1]+flux_avg[2]+flux_avg[3]+flux_avg[4]+flux_avg[5]+flux_avg[6]+flux_avg[7]+flux_avg[8]+flux_avg[9]+flux_avg[10]+
                        flux_avg[11]+flux_avg[12]+flux_avg[13]+flux_avg[14]+flux_avg[15]) >>4;
    assign o_finish = (state == IDLE && sram_addr >= i_end_address)? 1:0;
    
always_comb begin
    integer i,j;
    case(state)
        IDLE:begin
            if(i_start && ~o_finish)begin
                state_nxt = LOAD;
                sram_addr_nxt = sram_addr;
                counter_nxt = 0;
                flux_nxt = flux;
                win_pointer_nxt = win_pointer;
                load_counter_nxt = load_counter;
                flux_counter_nxt = flux_counter;
                sram_we_n_nxt = 1;
                audio_beat_nxt = audio_beat;
                last_spectrum_nxt = last_spectrum;
                sram_addr_tmp_nxt = sram_addr;
                sum_counter_nxt = sum_counter;
                for(i = 0; i<16; i = i+1)begin
                    flux_avg_nxt[i] = flux_avg[i];
                    
                end
                for(i = 0;i<8;i =i+1)begin
                    FFT_data_nxt [i] = FFT_data [i];
                    rev_flag_nxt [i] = rev_flag [i];
                    flux_store_nxt[i] = flux_store[i];
                end
                beat_mark_nxt = beat_mark;
            end
            else begin
                state_nxt = state;
                sram_addr_nxt = sram_addr;
                counter_nxt = counter;
                flux_nxt = flux;
                win_pointer_nxt = win_pointer;
                load_counter_nxt = load_counter;
                flux_counter_nxt = flux_counter;
                sram_we_n_nxt = sram_we_n;
                audio_beat_nxt = audio_beat;
                last_spectrum_nxt = last_spectrum;
                sram_addr_tmp_nxt = sram_addr;
                sum_counter_nxt = sum_counter;
                for(i = 0; i<16; i = i+1)begin
                    flux_avg_nxt[i] = flux_avg[i];
                end
                for(i = 0;i<8;i =i+1)begin
                    FFT_data_nxt [i] = FFT_data [i];
                    rev_flag_nxt [i] = rev_flag [i];
                    flux_store_nxt[i] = flux_store[i];
                end
                beat_mark_nxt = beat_mark;
            end
        end
        LOAD:begin
            if(counter == 7)begin
                state_nxt = FFT;
                sram_addr_nxt = sram_addr + 1;
                counter_nxt = 0;
                flux_nxt = flux;
                win_pointer_nxt = win_pointer;
                load_counter_nxt = load_counter + 1;
                flux_counter_nxt = flux_counter;
                sram_we_n_nxt = sram_we_n;
                audio_beat_nxt = audio_beat;
                last_spectrum_nxt = last_spectrum;
                sram_addr_tmp_nxt = sram_addr_tmp;
                sum_counter_nxt = sum_counter;
                for(i = 0; i<16; i = i+1)begin
                    flux_avg_nxt[i] = flux_avg[i];
                end
                for(i = 0;i<8;i =i+1)begin
                    FFT_data_nxt [i][31:16] = (i == counter)? io_SRAM_DQ : FFT_data [i][31:16];
                    FFT_data_nxt [i][15:0] = FFT_data[i][15:0];
                    rev_flag_nxt [i] = rev_flag [i];
                    flux_store_nxt[i] = flux_store[i];
                end
                beat_mark_nxt = beat_mark;
            end
            else begin
                state_nxt = state;
                sram_addr_nxt = sram_addr + 1;
                counter_nxt = counter + 1;
                flux_nxt = flux;
                win_pointer_nxt = win_pointer;
                load_counter_nxt = load_counter;
                flux_counter_nxt = flux_counter;
                sram_we_n_nxt = sram_we_n;
                audio_beat_nxt = audio_beat;
                last_spectrum_nxt = last_spectrum;
                sram_addr_tmp_nxt = sram_addr_tmp;
                sum_counter_nxt = sum_counter;
                for(i = 0; i<16; i = i+1)begin
                    flux_avg_nxt[i] = flux_avg[i];
                end
                for(i = 0;i<8;i =i+1)begin
                    FFT_data_nxt [i][31:16] = (i == counter)? io_SRAM_DQ : FFT_data [i][31:16];
                    FFT_data_nxt [i][15:0] = FFT_data[i][15:0];
                    rev_flag_nxt [i] = rev_flag [i];
                    flux_store_nxt[i] = flux_store[i];
                end
                beat_mark_nxt = beat_mark;
            end
            
        end
        FFT:begin
            if(fft_done)begin
                state_nxt = REV;
                sram_addr_nxt = sram_addr;
                counter_nxt = 0;
                flux_nxt = flux;
                win_pointer_nxt = win_pointer;
                load_counter_nxt = load_counter;
                flux_counter_nxt = 0;
                sram_we_n_nxt = sram_we_n;
                audio_beat_nxt = audio_beat;
                last_spectrum_nxt = last_spectrum;
                sram_addr_tmp_nxt = sram_addr_tmp;
                sum_counter_nxt =sum_counter;
                for(i = 0; i<16; i = i+1)begin
                    flux_avg_nxt[i] = flux_avg[i];
                end
                for(i = 0;i<8;i =i+1)begin
                    FFT_data_nxt [i] = (i == fft_addr && ~fft_we_n)? fft_dq : FFT_data [i];
                    rev_flag_nxt [i] = rev_flag [i];
                    flux_store_nxt[i] = flux_store[i];
                end
                beat_mark_nxt = beat_mark;
            end
            else begin
                state_nxt = state;
                sram_addr_nxt = sram_addr;
                counter_nxt = counter;
                flux_nxt = flux;
                win_pointer_nxt = win_pointer;
                load_counter_nxt = load_counter;
                flux_counter_nxt = flux_counter;
                sram_we_n_nxt = sram_we_n;
                audio_beat_nxt = audio_beat;
                last_spectrum_nxt = last_spectrum;
                sram_addr_tmp_nxt = sram_addr_tmp;
                sum_counter_nxt = sum_counter;
                for(i = 0; i<16; i = i+1)begin
                    flux_avg_nxt[i] = flux_avg[i];
                end
                for(i = 0;i<8;i =i+1)begin
                    FFT_data_nxt [i] = (i == fft_addr && ~fft_we_n)? fft_dq : FFT_data [i];
                    rev_flag_nxt [i] = rev_flag [i];
                    flux_store_nxt[i] = flux_store[i];
                end
                beat_mark_nxt = beat_mark;
            end
        end
        REV:begin
            if(counter == 7)begin
                state_nxt = STORE;
                sram_addr_nxt = sram_addr;
                counter_nxt = 0;
                flux_nxt = flux;
                win_pointer_nxt = win_pointer;
                load_counter_nxt = load_counter;
                flux_counter_nxt = 0;
                sram_we_n_nxt = 1;
                audio_beat_nxt = audio_beat;
                last_spectrum_nxt = last_spectrum;
                sram_addr_tmp_nxt = sram_addr_tmp;
                sum_counter_nxt = sum_counter;
                for(i = 0; i<16; i = i+1)begin
                    flux_avg_nxt[i] = flux_avg[i];
                end
                for(i = 0; i<8; i = i+1)begin
                    FFT_data_nxt [i] = FFT_data [i];
                    rev_flag_nxt [i] = rev_flag [i];
                    flux_store_nxt[i] = flux_store[i];
                end
                if(!rev_flag[counter])begin
                    FFT_data_nxt [counter] = FFT_data [counter_rev];
                    FFT_data_nxt [counter_rev] = FFT_data [counter];
                    rev_flag_nxt [counter] = 1;
                    rev_flag_nxt [counter_rev] = 1;
                end
                beat_mark_nxt = beat_mark;
            end
            else begin
                state_nxt = state;
                sram_addr_nxt = sram_addr;
                counter_nxt = counter + 1;
                flux_nxt = flux;
                win_pointer_nxt = win_pointer;
                load_counter_nxt = load_counter;
                flux_counter_nxt = flux_counter;
                sram_we_n_nxt = sram_we_n;
                audio_beat_nxt = audio_beat;
                last_spectrum_nxt = last_spectrum;
                sram_addr_tmp_nxt = sram_addr_tmp;
                sum_counter_nxt = sum_counter;
                for(i = 0; i<16; i = i+1)begin
                    flux_avg_nxt[i] = flux_avg[i];
                end
                for(i = 0; i<8; i = i+1)begin
                    FFT_data_nxt [i] = FFT_data [i];
                    rev_flag_nxt [i] = rev_flag [i];
                    flux_store_nxt[i] = flux_store[i];
                end
                if(!rev_flag[counter])begin
                    FFT_data_nxt [counter] = FFT_data [counter_rev];
                    FFT_data_nxt [counter_rev] = FFT_data [counter];
                    rev_flag_nxt [counter] = 1;
                    rev_flag_nxt [counter_rev] = 1;
                end
                beat_mark_nxt = beat_mark;
            end
        end
        STORE:begin
            if(sum_counter == 511)begin
                if(flux_counter == 7) begin
                    state_nxt = DIFF;
                    sram_addr_nxt = sram_addr;
                    counter_nxt = counter;
                    win_pointer_nxt = win_pointer;
                    load_counter_nxt = load_counter;
                    flux_counter_nxt = 0;
                    sram_we_n_nxt = sram_we_n;
                    audio_beat_nxt = audio_beat;
                    last_spectrum_nxt = last_spectrum;
                    sram_addr_tmp_nxt = sram_addr_tmp;
                    sum_counter_nxt = 0;
                    for(i = 0; i<16; i = i+1)begin
                        flux_avg_nxt[i] = flux_avg[i];
                    end
                    for(i = 0;i<8;i =i+1)begin
                        FFT_data_nxt [i] = FFT_data[i];
                        rev_flag_nxt [i] = rev_flag [i];
                        flux_store_nxt[i] = flux_store[i];
                    end
                    flux_store_nxt[flux_counter] = flux_store[flux_counter] + sqrt_y;
                    flux_nxt = flux;
                    beat_mark_nxt = beat_mark;
                end
                else begin
                    state_nxt = state;
                    sram_addr_nxt = sram_addr;
                    counter_nxt = counter;
                    win_pointer_nxt = win_pointer;
                    load_counter_nxt = load_counter;
                    flux_counter_nxt = flux_counter + 1;
                    sram_we_n_nxt = sram_we_n;
                    audio_beat_nxt = audio_beat;
                    last_spectrum_nxt = last_spectrum;
                    sram_addr_tmp_nxt = sram_addr_tmp;
                    sum_counter_nxt = sum_counter;
                    for(i = 0; i<16; i = i+1)begin
                        flux_avg_nxt[i] = flux_avg[i];
                    end
                    for(i = 0;i<8;i =i+1)begin
                        FFT_data_nxt [i] = FFT_data[i];
                        rev_flag_nxt [i] = rev_flag [i];
                        flux_store_nxt[i] = flux_store[i];
                    end
                    flux_store_nxt[flux_counter] = flux_store[flux_counter] + sqrt_y;
                    flux_nxt = flux;
                    beat_mark_nxt = beat_mark;
                end
            end
            else begin
                if(flux_counter == 7) begin
                    state_nxt = IDLE;
                    sram_addr_nxt = sram_addr;
                    counter_nxt = counter;
                    win_pointer_nxt = win_pointer;
                    load_counter_nxt = load_counter;
                    flux_counter_nxt = 0;
                    sram_we_n_nxt = sram_we_n;
                    audio_beat_nxt = audio_beat;
                    last_spectrum_nxt = last_spectrum;
                    sram_addr_tmp_nxt = sram_addr_tmp;
                    sum_counter_nxt = sum_counter + 1;
                    for(i = 0; i<16; i = i+1)begin
                        flux_avg_nxt[i] = flux_avg[i];
                    end
                    for(i = 0;i<8;i =i+1)begin
                        FFT_data_nxt [i] = FFT_data[i];
                        rev_flag_nxt [i] = rev_flag [i];
                        flux_store_nxt [i] = flux_store[i];
                    end
                    flux_store_nxt [flux_counter] = flux_store[flux_counter] + sqrt_y;
                    flux_nxt = flux;
                    beat_mark_nxt = beat_mark;
                end
                else begin
                    state_nxt = state;
                    sram_addr_nxt = sram_addr;
                    counter_nxt = counter;
                    win_pointer_nxt = win_pointer;
                    load_counter_nxt = load_counter;
                    flux_counter_nxt = flux_counter + 1;
                    sram_we_n_nxt = sram_we_n;
                    audio_beat_nxt = audio_beat;
                    last_spectrum_nxt = last_spectrum;
                    sram_addr_tmp_nxt = sram_addr_tmp;
                    sum_counter_nxt = sum_counter;
                    for(i = 0; i<16; i = i+1)begin
                        flux_avg_nxt[i] = flux_avg[i];
                    end
                    for(i = 0;i<8;i =i+1)begin
                        FFT_data_nxt [i] = FFT_data[i];
                        rev_flag_nxt [i] = rev_flag [i];
                        flux_store_nxt [i] = flux_store[i];
                    end
                    flux_store_nxt[flux_counter] = flux_store[flux_counter] + sqrt_y;
                    flux_nxt = flux;
                    beat_mark_nxt = beat_mark;
                end
            end
        end
        DIFF:begin
            if(flux_counter == 7 && ~sram_we_n)begin
                state_nxt = SAVE;
                sram_addr_nxt = sram_addr;
                counter_nxt = counter;
                win_pointer_nxt = win_pointer;
                load_counter_nxt = load_counter;
                flux_counter_nxt = 0;
                sram_we_n_nxt = 1;
                audio_beat_nxt = audio_beat;
                last_spectrum_nxt = last_spectrum;
                sram_addr_tmp_nxt = sram_addr_tmp;
                sum_counter_nxt = sum_counter;
                for(i = 0; i<16; i = i+1)begin
                    flux_avg_nxt[i] = flux_avg[i];
                end
                for(i = 0;i<8;i =i+1)begin
                    FFT_data_nxt [i] = FFT_data[i];
                    rev_flag_nxt [i] = rev_flag [i];
                    flux_store_nxt[i] = 0; 
                end
                flux_nxt = flux;
                beat_mark_nxt = beat_mark;
            end
            else begin
                if(sram_we_n)begin
                    state_nxt = state;
                    sram_addr_nxt = sram_addr;
                    counter_nxt = counter;
                    win_pointer_nxt = win_pointer;
                    load_counter_nxt = load_counter;
                    flux_counter_nxt = flux_counter;
                    sram_we_n_nxt = 0;
                    audio_beat_nxt = audio_beat;
                    last_spectrum_nxt = flux_store[flux_counter][24:9];
                    sram_addr_tmp_nxt = sram_addr_tmp;
                    sum_counter_nxt = sum_counter;
                    for(i = 0; i<16; i = i+1)begin
                        flux_avg_nxt[i] = flux_avg[i];
                    end
                    for(i = 0;i<8;i =i+1)begin
                        FFT_data_nxt [i] = FFT_data[i];
                        rev_flag_nxt [i] = rev_flag [i];
                        flux_store_nxt[i] = flux_store[i]; 
                    end
                    flux_nxt = (flux_store[flux_counter][24:9] > io_SRAM_DQ)? (flux_store[flux_counter][24:9] - io_SRAM_DQ) + flux : flux;
                    beat_mark_nxt = beat_mark;
                end
                else begin
                    state_nxt = state;
                    sram_addr_nxt = sram_addr;
                    counter_nxt = counter;
                    win_pointer_nxt = win_pointer;
                    load_counter_nxt = load_counter;
                    flux_counter_nxt = flux_counter + 1;
                    sram_we_n_nxt = 1;
                    audio_beat_nxt = audio_beat;
                    last_spectrum_nxt = last_spectrum;
                    sram_addr_tmp_nxt = sram_addr_tmp;
                    sum_counter_nxt = sum_counter;
                    for(i = 0; i<16; i = i+1)begin
                        flux_avg_nxt[i] = flux_avg[i];
                    end
                    for(i = 0;i<8;i =i+1)begin
                        FFT_data_nxt [i] = FFT_data[i];
                        rev_flag_nxt [i] = rev_flag [i];
                        flux_store_nxt[i] = flux_store[i]; 
                    end
                    flux_nxt = flux;
                    beat_mark_nxt = beat_mark;
                end
            end
            
        end
        SAVE:begin
            state_nxt = AVG;
            sram_addr_nxt = sram_addr;
            counter_nxt = counter;
            win_pointer_nxt = win_pointer;
            load_counter_nxt = load_counter;
            flux_counter_nxt = flux_counter;
            sram_we_n_nxt = sram_we_n;
            audio_beat_nxt = audio_beat;
            last_spectrum_nxt = last_spectrum;
            sram_addr_tmp_nxt = sram_addr_tmp;
            sum_counter_nxt = sum_counter;
            for(i = 0; i<16; i = i+1)begin
                flux_avg_nxt[i] = (i == win_pointer)? flux :flux_avg[i];
            end
            for(i = 0;i<8;i =i+1)begin
                FFT_data_nxt [i] = FFT_data[i];
                rev_flag_nxt [i] = rev_flag [i];
                flux_store_nxt[i] = flux_store[i];
            end
            flux_nxt = 0;
            beat_mark_nxt = beat_mark;
        end
        AVG:begin
            if(load_counter>=8192)begin
                state_nxt = WRITE;
                sram_addr_nxt = (((load_counter-4096) << 3) > 127333)? ((load_counter-4096) << 3) - 127333 : sram_addr;
                counter_nxt = counter;
                win_pointer_nxt = win_pointer + 1;
                load_counter_nxt = load_counter;
                flux_counter_nxt = flux_counter;
                sram_we_n_nxt = 1;
                audio_beat_nxt = audio_beat;
                last_spectrum_nxt = last_spectrum;
                sram_addr_tmp_nxt = (((load_counter-4096) << 3) > 127333)? sram_addr : sram_addr_tmp;
                sum_counter_nxt = sum_counter;
                for(i = 0; i<16; i = i+1)begin
                    flux_avg_nxt[i] = flux_avg[i];
                end
                for(i = 0;i<8;i =i+1)begin
                    FFT_data_nxt [i] = FFT_data[i];
                    rev_flag_nxt [i] = rev_flag [i];
                    flux_store_nxt[i] = flux_store[i];
                end
                flux_nxt = flux;
                beat_mark_nxt = (flux_avg[{~win_pointer[3],win_pointer[2:0]}] >= (flux_score << 1)) ? 1 : 0;
            end
            else begin
                state_nxt = IDLE;
                sram_addr_nxt = sram_addr;
                counter_nxt = counter;
                win_pointer_nxt = win_pointer +1;
                load_counter_nxt = load_counter;
                flux_counter_nxt = flux_counter;
                sram_we_n_nxt = sram_we_n;
                audio_beat_nxt = audio_beat;
                last_spectrum_nxt = last_spectrum;
                sram_addr_tmp_nxt = sram_addr_tmp;
                sum_counter_nxt = sum_counter;
                for(i = 0; i<16; i = i+1)begin
                    flux_avg_nxt[i] = flux_avg[i];
                end
                for(i = 0;i<8;i =i+1)begin
                    FFT_data_nxt [i] = FFT_data[i];
                    rev_flag_nxt [i] = rev_flag [i];
                    flux_store_nxt[i] = flux_store[i];
                end
                flux_nxt = flux;
                beat_mark_nxt = 0;
            end
        end
        WRITE:begin
            state_nxt = FIX;
            sram_addr_nxt = sram_addr;
            counter_nxt = counter;
            win_pointer_nxt = win_pointer;
            load_counter_nxt = load_counter;
            flux_counter_nxt = flux_counter;
            sram_we_n_nxt = (beat_mark)? 0 : 1;
            audio_beat_nxt = (beat_mark)? {io_SRAM_DQ[15:1], 1'b1} : {io_SRAM_DQ[15:1], 1'b0};
            last_spectrum_nxt = last_spectrum;
            sram_addr_tmp_nxt = sram_addr_tmp;
            sum_counter_nxt = sum_counter;
            for(i = 0; i<16; i = i+1)begin
                flux_avg_nxt[i] = flux_avg[i];
            end
            for(i = 0;i<8;i =i+1)begin
                FFT_data_nxt [i] = FFT_data[i];
                rev_flag_nxt [i] = rev_flag [i];
                flux_store_nxt[i] = flux_store[i];
            end
            flux_nxt = flux;
            beat_mark_nxt = beat_mark;
        end
        FIX:begin
            state_nxt = IDLE;
            sram_addr_nxt = (((load_counter-4096) << 3) > 127333)? sram_addr_tmp : sram_addr;
            counter_nxt = counter;
            win_pointer_nxt = win_pointer;
            load_counter_nxt = load_counter;
            flux_counter_nxt = flux_counter;
            sram_we_n_nxt = 1;
            audio_beat_nxt = audio_beat;
            last_spectrum_nxt = last_spectrum;
            sram_addr_tmp_nxt = sram_addr_tmp;
            sum_counter_nxt = sum_counter;
            for(i = 0; i<16; i = i+1)begin
                flux_avg_nxt[i] = flux_avg[i];
            end
            for(i = 0;i<8;i =i+1)begin
                FFT_data_nxt [i] = FFT_data[i];
                rev_flag_nxt [i] = rev_flag [i];
                flux_store_nxt[i] = flux_store[i];
            end
            flux_nxt = flux;
            beat_mark_nxt = beat_mark;
        end
        default: begin
            state_nxt = state;
            sram_addr_nxt = sram_addr;
            counter_nxt = counter;
            win_pointer_nxt = win_pointer;
            load_counter_nxt = load_counter;
            flux_counter_nxt = flux_counter;
            sram_we_n_nxt = sram_we_n;
            audio_beat_nxt = audio_beat;
            last_spectrum_nxt = last_spectrum;
            sram_addr_tmp_nxt = sram_addr_tmp;
            sum_counter_nxt = sum_counter;
            for(i = 0; i<16; i = i+1)begin
                flux_avg_nxt[i] = flux_avg[i];
            end
            for(i = 0;i<8;i =i+1)begin
                FFT_data_nxt [i] = FFT_data[i];
                rev_flag_nxt [i] = rev_flag [i];
                flux_store_nxt[i] = flux_store[i];
            end
            flux_nxt = flux;
            beat_mark_nxt = beat_mark;
        end
    endcase
end

always_ff @(posedge i_clk or negedge i_rst_n)begin
    integer i;
    if(!i_rst_n)begin
        state <= IDLE;
        sram_addr <= 0;
        counter <= 0;
        win_pointer <= 0;
        load_counter <= 0;
        flux_counter <= 0;
        sram_we_n <= 1;
        audio_beat <= 0;
        last_spectrum <= 0;
        sram_addr_tmp <= 0;
        sum_counter <= 0;
        for(i = 0; i<16; i = i+1)begin
            flux_avg[i] <= 0;
        end
        for(i = 0;i<8;i =i+1)begin
            FFT_data[i] <= 0;
            rev_flag [i] <= 0;
            flux_store[i] <= 0;
        end
        flux <= 0;
        beat_mark <= 0;
    end
    else begin
        state <= state_nxt;
        sram_addr <= sram_addr_nxt;
        counter <= counter_nxt;
        win_pointer <= win_pointer_nxt;
        load_counter <= load_counter_nxt;
        flux_counter <= flux_counter_nxt;
        sram_we_n <= sram_we_n_nxt;
        audio_beat <= audio_beat_nxt;
        last_spectrum <= last_spectrum_nxt;
        sram_addr_tmp <= sram_addr_tmp_nxt;
        sum_counter <= sum_counter_nxt;
        for(i = 0; i<16; i = i+1)begin
            flux_avg[i] <= flux_avg_nxt[i];
        end
        for(i = 0;i<8;i =i+1)begin
            FFT_data[i] <= FFT_data_nxt[i];
            rev_flag [i] <= rev_flag_nxt [i];
            flux_store[i] <= flux_store_nxt[i];
        end
        flux <= flux_nxt;
        beat_mark <= beat_mark_nxt;
    end
end

fftx82048 ffttop(
    .i_clk(i_clk), 
    .i_rst_n(i_rst_n),
    .i_start(fft_start),
    .o_done(fft_done),
    .o_ADDR(fft_addr),
    .io_DQ(fft_dq), // [15:0]
	.o_WE_N(fft_we_n)
);
sqrt sqrt0(
    .x1(sqrt_x1),
    .x2(sqrt_x2),
    .y(sqrt_y)
);
bitrev11 br2(.data_in(counter), .data_out(counter_rev));
endmodule






module sqrt
    #(parameter DATA_IN_WIDTH = 16)
    (
    input   wire    signed  [ DATA_IN_WIDTH-1:  0 ] x1,
    input   wire    signed  [ DATA_IN_WIDTH-1:  0 ] x2,
    output  wire            [ DATA_IN_WIDTH-1:  0 ] y
    );

localparam DATA_WIDTH_SQUARING = (2*DATA_IN_WIDTH) - 1;
wire    [ DATA_WIDTH_SQUARING-1 :  0 ] x1_2 = x1*x1;
wire    [ DATA_WIDTH_SQUARING-1 :  0 ] x2_2 = x2*x2;

localparam DATA_WIDTH_SUM = DATA_WIDTH_SQUARING+1;
wire    [ DATA_WIDTH_SUM-1 :  0 ] x = x1_2 + x2_2;

assign y[DATA_IN_WIDTH-1] = x[(DATA_WIDTH_SUM-1)-:2] == 2'b00 ? 1'b0 : 1'b1;
genvar k;
generate
    for(k = DATA_IN_WIDTH-2; k >= 0; k = k - 1)
    begin: gen
        assign y[k] = x[(DATA_WIDTH_SUM-1)-:(2*(DATA_IN_WIDTH-k))] < 
        {y[DATA_IN_WIDTH-1:k+1],1'b1}*{y[DATA_IN_WIDTH-1:k+1],1'b1} ? 1'b0 : 1'b1;
    end
endgenerate

endmodule