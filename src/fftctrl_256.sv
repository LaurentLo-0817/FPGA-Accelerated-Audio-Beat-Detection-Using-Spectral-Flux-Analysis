module fftctrl2048(
    input i_clk, 
    input i_rst_n,
    input i_en,
    input i_butteryfly_done,
    output o_addr_enable,
    output o_addr_writemode,
    output o_butterfly_enable,
    output o_mem_num,
    output o_done
);
    parameter IDLE = 0;
    parameter WAIT0 = 1;
    parameter WAIT1 = 2;
    parameter BUTT = 3;
    parameter MEMWRITE0 = 4;
    parameter MEMWRITE1 = 5;
    parameter FINISH = 6;

    logic [3:0] state,state_nxt;
    logic [15:0] counter,counter_nxt;
    logic addr_enable,addr_enable_nxt;
    logic addr_writemode,addr_writemode_nxt;
    logic butterfly_enable,butterfly_enable_nxt;
    logic [3:0] waitcounter;
    logic mem_num, mem_num_nxt;

    assign o_done = (state == FINISH)? 1:0;
    assign o_butterfly_enable = butterfly_enable;
    assign o_mem_num = mem_num;
    // assign o_addr_enable = addr_enable;
    assign o_addr_writemode = addr_writemode;
    assign o_addr_enable = (state == MEMWRITE1)? 1:0;

    always_comb begin
        case(state)
            IDLE:begin
                if(i_en)begin
                    state_nxt = WAIT0;
                    counter_nxt = 0;
                    butterfly_enable_nxt = 0;
                    addr_writemode_nxt =0;
                    addr_enable_nxt =0;
                    mem_num_nxt = 0;
                end
                else begin
                    state_nxt = state;
                    counter_nxt = 0;
                    butterfly_enable_nxt = 0;
                    addr_writemode_nxt =0;
                    addr_enable_nxt =0;
                    mem_num_nxt = mem_num;
                end
            end
            WAIT0:begin
                state_nxt = WAIT1;
                counter_nxt = counter;
                butterfly_enable_nxt = 0;
                addr_writemode_nxt = 0;
                addr_enable_nxt =0;
                mem_num_nxt = 1;
            end
            WAIT1:begin
                state_nxt = BUTT;
                counter_nxt = counter;
                butterfly_enable_nxt = 1;
                addr_writemode_nxt = 0;
                addr_enable_nxt =0;
                mem_num_nxt = 0;
            end

            BUTT:begin
                if(i_butteryfly_done)begin
                    state_nxt = MEMWRITE0;
                    counter_nxt = counter;
                    butterfly_enable_nxt = 0;
                    addr_writemode_nxt =1;
                    addr_enable_nxt = 0;
                    mem_num_nxt = 0;
                end
                else begin
                    state_nxt = state;
                    counter_nxt = counter;
                    butterfly_enable_nxt = 1;
                    addr_writemode_nxt =0;
                    addr_enable_nxt =0;
                    mem_num_nxt = mem_num;
                end
            end
            MEMWRITE0:begin
                state_nxt = MEMWRITE1;
                counter_nxt = counter;
                butterfly_enable_nxt = 0;
                addr_writemode_nxt =1;
                addr_enable_nxt = 0;
                mem_num_nxt = 1;
            end
            MEMWRITE1:begin
                if(counter == 1023) begin
                    state_nxt = FINISH;
                    counter_nxt = 0;
                    butterfly_enable_nxt = 0;
                    addr_writemode_nxt =0;
                    addr_enable_nxt =1;
                    mem_num_nxt = mem_num;
                    
                end
                else begin
                    state_nxt = WAIT0;
                    counter_nxt = counter + 1;
                    butterfly_enable_nxt = 0;
                    addr_writemode_nxt =0;
                    addr_enable_nxt =1;
                    mem_num_nxt = 0;
                end
            end
            FINISH:begin
                state_nxt = IDLE;
                counter_nxt = counter;
                butterfly_enable_nxt = 0;
                addr_writemode_nxt =0;
                addr_enable_nxt =0;
                mem_num_nxt = mem_num;
            end
            default:begin
                state_nxt = state;
                counter_nxt = counter;
                butterfly_enable_nxt = butterfly_enable;
                addr_writemode_nxt =addr_writemode;
                addr_enable_nxt =addr_enable;
                mem_num_nxt = mem_num;
            end
        endcase 
    end
    always_ff@(posedge i_clk or negedge i_rst_n)begin
        if(!i_rst_n)begin
            state <= 0;
            counter <= 0;
            butterfly_enable <= 0;
            addr_writemode <= 0;
            addr_enable <= 0;
            mem_num <= 0;
        end
        else begin
            state <= state_nxt;
            counter <= counter_nxt;
            butterfly_enable <= butterfly_enable_nxt;
            addr_writemode <= addr_writemode_nxt;
            addr_enable <= addr_enable_nxt;
            mem_num <= mem_num_nxt;
        end
    end
    endmodule
