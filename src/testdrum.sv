module testdrum (
    input clk,
    input rst,
    input beat,
    output [3:0] times,
    output reg drum_out
);

    logic [3:0] count,count_nxt;
    logic state,state_nxt;
    logic [31:0] limit,limit_nxt;

    parameter zero = 0 ;
    parameter one = 1 ;

    parameter timelimit = 4000000;

    assign times = count;


    always @(*) begin
        drum_out = 0;
        case (state)

            zero:begin

                limit_nxt = 0;
                
                if(beat) begin

                    state_nxt = one;
                    count_nxt = count + 1;
                    drum_out = 1;
                end
                else begin
                    
                    state_nxt = zero;
                    count_nxt = count;

                end

            end

            one:begin

                count_nxt = count;

                if(limit == timelimit) begin

                    state_nxt = zero;
                    limit_nxt = 0;
                   

                end
                else begin
                    
                    state_nxt = one;
                    limit_nxt = limit + 1;

                end
            end
            
        endcase
        if(count > 9) begin
            count_nxt = 0;
        end

    end
    

    always @(posedge clk or negedge rst) begin

        if(!rst) begin
            state <= 0 ;
            count <= 0 ;
            limit <= 0 ;
        end

        else begin
            state <= state_nxt;
            count <= count_nxt;
            limit <= limit_nxt;
        end
            
    end
endmodule