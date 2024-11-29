module Top(
    input i_clk,
    input i_rst_n,
    input i_key_0,
    input i_key_1,
    input i_key_2,
    input i_drum_in,
    output [15:0] o_score,
    output [11:0] o_perfect_score,
    output [11:0] o_good_score,
    output [11:0] o_miss_score,
    output [3:0] o_vga_state,
    output o_audio_record,
    output o_audio_play,
    output o_audio_stop,
    output o_audio_reset,
    //Emily add//
    output o_perfect,
    output o_good,
    output o_miss,
    output [256:0] o_beat,
    //fft_beat
    input i_fft_beat,
    //fft_control
    output reg o_fft_start,
    output o_fft_reset,
    input i_fft_finish
);

parameter start = 0;
parameter recording = 1;
parameter loading = 2;
parameter ready = 3;
parameter playing = 4;
parameter ending = 5;
parameter TIMES = 200000;
parameter quarter_second = 3000000;
parameter move_time = 46200000;
parameter move_blocks = 231;
parameter one_second = 12000000;
parameter half_second = 6000000;
parameter three_quarter_second = 9000000;
parameter one_third_second = 4000000;

logic [2:0] state, state_next;
logic record, record_next, play, play_next, stop, stop_next, audio_reset, audio_reset_next;
logic done;
logic [29:0] counter, counter_next;
logic [29:0] music_length, music_length_next;
logic perfect_hit, good_hit, miss_hit;

logic [256:0] beat, beat_next;
integer i;
logic [17:0] counter_shift, counter_shift_next;
logic [22:0] counter_drum, counter_drum_next;
logic [25:0] counter_second, counter_second_next;
logic test_fft_beat;
logic perfect, perfect_next, good, good_next, miss, miss_next;
logic [3:0] perfect_one, perfect_two, perfect_three, perfect_one_next, perfect_two_next, perfect_three_next;
logic [3:0] good_one, good_two, good_three, good_one_next, good_two_next, good_three_next;
logic [3:0] miss_one, miss_two, miss_three, miss_one_next, miss_two_next, miss_three_next;
logic [3:0] score_one, score_two, score_three, score_four;
logic [3:0] score_one_next, score_two_next, score_three_next, score_four_next;
logic [22:0] counter_beat, counter_beat_next;

logic fft_reset, fft_reset_next;

//========test
reg [2047:0] test_w;
reg [2047:0] test_r;
//========test

assign o_audio_play = play;
assign o_audio_record = record;
assign o_audio_stop = stop;
assign o_score = {score_four,score_three,score_two,score_one};
assign o_perfect_score = {perfect_three,perfect_two,perfect_one};
assign o_good_score = {good_three,good_two,good_one};
assign o_miss_score = {miss_three,miss_two,miss_one};
assign o_vga_state = state;
assign o_audio_reset = i_rst_n && !audio_reset;
//emily add//
assign o_beat= beat;
assign o_perfect = perfect;
assign o_good = good;
assign o_miss = miss;
//assign o_test = test_r;
//fft_control
assign o_fft_reset = i_rst_n && !fft_reset;


always @(*) begin
    record_next = 0;
    play_next = 0;
    stop_next = 0;
    done = 1;
    counter_next = counter;
    music_length_next = music_length;
    audio_reset_next = 0;
    for(i=0;i<257;i=i+1) begin
        beat_next[i] = beat[i];
    end
    counter_shift_next = counter_shift;
    counter_drum_next = counter_drum;
    counter_second_next = counter_second;
    counter_beat_next = counter_beat;
    perfect_next = perfect;
    good_next = good;
    miss_next = miss;
    perfect_hit = 0;
    good_hit = 0;
    miss_hit = 0;
    //score
    score_one_next = score_one;
    score_two_next = score_two;
    score_three_next = score_three;
    score_four_next = score_four;
    //perfect_score
    perfect_one_next = perfect_one;
    perfect_two_next = perfect_two;
    perfect_three_next = perfect_three;
    //good_score
    good_one_next = good_one;
    good_two_next = good_two;
    good_three_next = good_three;
    //miss_score
    miss_one_next = miss_one;
    miss_two_next = miss_two;
    miss_three_next = miss_three;
    //fft control
    o_fft_start = 0;
    fft_reset_next = 0;
    //test_fft_beat generator
    if(counter_second == three_quarter_second) begin
        counter_second_next = 0;
        test_fft_beat = 1;
    end
    else begin
        counter_second_next = counter_second + 1;
        test_fft_beat = 0;
    end
    //FSM
    case(state)
        start: begin
            if(i_key_0) begin
                state_next = recording;
                record_next = 1;
            end
            else begin
                state_next = start;
            end
        end
        recording: begin
            if(i_key_2) begin
                stop_next = 1;
                music_length_next = counter;
                state_next = loading;
                counter_next = 0;
                fft_reset_next = 1;
            end
            else begin
                state_next = recording;
                counter_next = counter + 1;
            end
        end
        loading: begin
            if(i_fft_finish) begin
                state_next = ready;
                o_fft_start = 0;
            end
            else begin
                state_next = loading;
                o_fft_start = 1;
            end
        end
        ready: begin
            if(i_drum_in) begin
                state_next = playing;
                play_next = 1;
            end 
            else begin
                state_next = ready;
            end
        end
        playing: begin
            counter_shift_next = counter_shift + 1;
            if(counter == music_length) begin
                state_next = ending;
                counter_next = 0;
                stop_next = 1;
                audio_reset_next = 1;
                good_next = 0;
                miss_next = 0;
                perfect_next = 0;
            end 
            else begin
                state_next = playing;
                counter_next = counter + 1;
            end
            // drum instantiate logic
            if(counter_beat == 0) begin
                if(i_fft_beat) begin
                    beat_next[256] = 1;
                    counter_beat_next = counter_beat + 1;
                end
                else begin
                    counter_beat_next = counter_beat;
                end
            end
            else if(counter_beat == one_third_second) begin
                counter_beat_next = 0;
            end
            else begin
                counter_beat_next = counter_beat + 1;
            end
            
            // drum shift logic
            if(counter_shift == TIMES) begin
                counter_shift_next = 0;
                for(i=0;i<256;i=i+1) begin
                    beat_next[i] = beat[i+1];
                end
                beat_next[256] = 0;
            end
            //detect drum hit
            if(i_drum_in) begin 
                counter_drum_next = counter_drum + 1;
                if(beat[23] | beat[24] | beat[25] | beat[26] | beat[27]) begin
                    perfect_next = 1;
                    perfect_hit = 1;
                    for(i=5; i<28; i=i+1) begin
                        beat_next[i] = 0;
                    end
                end
                else if(beat[19] | beat[20] | beat[21] | beat[22] | beat[28] | beat[29] | beat[30] | beat[31]) begin
                    good_next = 1;
                    good_hit = 1;
                    for(i=5; i<32; i=i+1) begin
                        beat_next[i] = 0;
                    end
                end
                else begin
                    miss_next = 1;
                    miss_hit = 1;
                end
            end
            if(beat[9] == 1) begin
                counter_drum_next = counter_drum + 1;
                miss_hit = 1;
                miss_next = 1;
            end
            //
            if(counter_drum == quarter_second) begin
                counter_drum_next = 0;
                perfect_next = 0;
                good_next = 0;
                miss_next = 0;
            end
            else if(counter_drum != 0) begin
                counter_drum_next = counter_drum + 1;
                perfect_next = perfect;
                good_next = good;
                miss_next = miss;
            end
            //score system
            if(perfect_hit) begin
                if(perfect_one == 9) begin
                    perfect_one_next = 0;
                    if(perfect_two == 9) begin
                        perfect_two_next = 0;
                        perfect_three_next = perfect_three + 1;
                    end
                    else begin
                        perfect_two_next = perfect_two + 1;
                    end
                end
                else begin
                    perfect_one_next = perfect_one + 1;
                end
            end
            if(good_hit) begin
                if(good_one == 9) begin
                    good_one_next = 0;
                    if(good_two == 9) begin
                        good_two_next = 0;
                        good_three_next = good_three + 1;
                    end
                    else begin
                        good_two_next = good_two + 1;
                    end
                end
                else begin
                    good_one_next = good_one + 1;
                end
            end
            
            if(miss_hit) begin
                if(miss_one == 9) begin
                    miss_one_next = 0;
                    if(miss_two == 9) begin
                        miss_two_next = 0;
                        miss_three_next = miss_three + 1;
                    end
                    else begin
                        miss_two_next = miss_two + 1;
                    end
                end
                else begin
                    miss_one_next = miss_one + 1;
                end
            end
            if(perfect_hit) begin
                if(score_two == 9) begin
                    score_two_next = 0;
                    if(score_three == 9) begin
                        score_three_next = 0;
                        score_four_next = score_four + 1;
                    end
                    else begin
                        score_three_next = score_three + 1;
                    end
                end
                else begin
                    score_two_next = score_two + 1;
                end
            end
            if(good_hit) begin
                if(score_one == 5) begin
                    score_one_next = 0;
                    if(score_two == 9) begin
                        score_two_next = 0;
                        if(score_three == 9) begin
                            score_three_next = 0;
                            score_four_next = score_four + 1;
                        end
                        else begin
                            score_three_next = score_three + 1;
                        end
                    end
                    else begin
                        score_two_next = score_two + 1;
                    end
                end
                else begin
                    score_one_next = score_one_next + 5;
                end
            end
        end
        ending: begin
            if(i_key_0) begin
                state_next = ready;
                //reset score
                perfect_one_next = 0;
                perfect_two_next = 0;
                perfect_three_next = 0;
                good_one_next = 0;
                good_two_next = 0;
                good_three_next = 0;
                miss_one_next = 0;
                miss_two_next = 0;
                miss_three_next = 0;
                score_one_next = 0;
                score_two_next = 0;
                score_three_next = 0;
                score_four_next = 0;
            end
            else if(i_key_1) begin
                state_next = recording;
                record_next = 1;
                //reset score
                perfect_one_next = 0;
                perfect_two_next = 0;
                perfect_three_next = 0;
                good_one_next = 0;
                good_two_next = 0;
                good_three_next = 0;
                miss_one_next = 0;
                miss_two_next = 0;
                miss_three_next = 0;
                score_one_next = 0;
                score_two_next = 0;
                score_three_next = 0;
                score_four_next = 0;
            end
            else begin
                state_next = ending;
            end
            //reset drum symbol
            for(i=0;i<257;i=i+1) begin
                beat_next[i] = 0;
            end
        end
        default: begin
            state_next = start;
        end
    endcase
end
//emily test//
//===========================test

/*always @(*) begin
    for(i=1;i<2048;i=i+1) begin
        test_w[i] = test_r[i-1];
    end
    test_w[0] = counter_second[0];
end*/
//===========================test
always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n) begin
        counter_shift <= 0;
        for(i=0;i<257;i=i+1)begin
            beat[i] <= 0;
        end
    end
    else begin
        counter_shift <= counter_shift_next;
        for(i=0;i<257;i=i+1)begin
            beat[i] <= beat_next[i];
        end
    end
end


always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n) begin
        state <= 0;
        record <= 0;
        play <= 0;
        stop <= 0;
        counter <= 0;
        music_length <= 0;
        audio_reset <= 1;
        counter_drum <= 0;
        counter_second <= 0;
        counter_beat <= 0;
        perfect <= 0;
        good <= 0;
        miss <= 0;

        perfect_one <= 0;
        perfect_two <= 0;
        perfect_three <= 0;
        good_one <= 0;
        good_two <= 0;
        good_three <= 0;
        miss_one <= 0;
        miss_two <= 0;
        miss_three <= 0;
        score_one <= 0;
        score_two <= 0;
        score_three <= 0;
        score_four <= 0;

        fft_reset <= 1;

        //==============test
        /*for(i=0;i<2048;i=i+1) begin
            test_r[i] <= 0;
        end*/
    end
    else begin
        state <= state_next;
        record <= record_next;
        play <= play_next;
        stop <= stop_next;
        counter <= counter_next;
        music_length <= music_length_next;
        audio_reset <= audio_reset_next;
        counter_drum <= counter_drum_next;
        counter_second <= counter_second_next;
        counter_beat <= counter_beat_next;
        perfect <= perfect_next;
        good <= good_next;
        miss <= miss_next;

        perfect_one <= perfect_one_next;
        perfect_two <= perfect_two_next;
        perfect_three <= perfect_three_next;
        good_one <= good_one_next;
        good_two <= good_two_next;
        good_three <= good_three_next;
        miss_one <= miss_one_next;
        miss_two <= miss_two_next;
        miss_three <= miss_three_next;
        score_one <= score_one_next;
        score_two <= score_two_next;
        score_three <= score_three_next;
        score_four <= score_four_next;

        fft_reset <= fft_reset_next;
        //==============test
        /*for(i=0;i<2048;i=i+1) begin
            test_r[i] <= test_w[i];
        end*/
    end
end

endmodule