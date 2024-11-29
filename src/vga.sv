module vga(
    input i_clk,
    input i_rst_n,
    input [2:0] state,
    input [15:0] score,
    input [11:0] perfect_score,
    input [11:0] good_score,
    input [11:0] miss_score,
    input perfect,
    input good,
    input miss,
    input [256:0] beat,
    output [7:0] o_VGA_R,
    output [7:0] o_VGA_G,
    output [7:0] o_VGA_B,
    output o_VGA_SYNC_N,
    output o_VGA_BLANK_N,
    output o_VGA_HS,
    output o_VGA_VS
);

parameter gamestart = 0;
parameter record = 1;
parameter load = 2;
parameter ready = 3;
parameter play = 4;
parameter ending = 5;

parameter start = 0;
parameter H_sync = 96;
parameter H_back_porch = 144;
parameter H_display_interval = 784;
parameter H_front_porch = 800;
parameter V_sync = 2;
parameter V_back_porch = 35;
parameter V_display_interval = 515;
parameter V_front_porch = 525;

parameter ZERO = 0;
parameter ONE = 1;
parameter TWO = 2;
parameter THREE = 3;
parameter FOUR = 4;
parameter FIVE = 5;
parameter SIX = 6;
parameter SEVEN = 7;
parameter EIGHT = 8;
parameter NINE = 9;

logic [9:0] counter_row_w, counter_row_r;
logic [9:0] counter_column_w, counter_column_r;
logic HS_r, HS_w, VS_w, VS_r;
logic [7:0] VGA_B_w, VGA_B_r;
logic [7:0] VGA_G_w, VGA_G_r;
logic [7:0] VGA_R_w, VGA_R_r;

integer i;

assign o_VGA_HS = HS_r;
assign o_VGA_VS = VS_r;
assign o_VGA_SYNC_N = 1;
assign o_VGA_BLANK_N = 1;
assign o_VGA_B = VGA_B_r;
assign o_VGA_G = VGA_G_r;
assign o_VGA_R = VGA_R_r;

//HS logic
always @(*) begin
    VGA_R_w = 0;
    VGA_G_w = 0;
    VGA_B_w = 0;
    if(counter_column_r == 524) begin
        counter_column_w = 0;
    end
    else begin
        counter_column_w = counter_column_r;
    end

    if(counter_row_r < H_sync) begin
        counter_row_w = counter_row_r + 1;
        HS_w = 0;
    end 
    else if(counter_row_r >= H_sync && counter_row_r < H_back_porch) begin
        counter_row_w = counter_row_r + 1;
        HS_w = 1;
    end 
    else if(counter_row_r >= H_back_porch && counter_row_r < H_display_interval) begin
        counter_row_w = counter_row_r + 1;
        HS_w = 1;

        VGA_R_w = 255;
        VGA_G_w = 255;
        VGA_B_w = 255;

        case (state)
        
            gamestart: begin
                if (counter_column_r >= 257 && counter_column_r <= 263 ) begin
                    if(counter_row_r >= 381 && counter_row_r <= 401 ||
                        counter_row_r >= 409 && counter_row_r <= 443 ||
                        counter_row_r >= 458 && counter_row_r <= 471 ||
                        counter_row_r >= 409 && counter_row_r <= 443 ||
                        counter_row_r >= 486 && counter_row_r <= 506 ||
                        counter_row_r >= 289 && counter_row_r <= 294 ||
                        counter_row_r >= 632 && counter_row_r <= 637 ||
                        counter_row_r >= 521 && counter_row_r <= 555 
                    ) begin
                    
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin

                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;

                    end
                end
                else if (counter_column_r >= 264 && counter_column_r <= 270 ) begin
                    
                    if(counter_row_r >= 374 && counter_row_r <= 380 ||
                        counter_row_r >= 423 && counter_row_r <= 429 ||
                        counter_row_r >= 451 && counter_row_r <= 457 ||
                        counter_row_r >= 472 && counter_row_r <= 478 ||
                        counter_row_r >= 486 && counter_row_r <= 492 ||
                        counter_row_r >= 507 && counter_row_r <= 513 ||
                        counter_row_r >= 289 && counter_row_r <= 294 ||
                        counter_row_r >= 632 && counter_row_r <= 637 ||
                        counter_row_r >= 535 && counter_row_r <= 541
                    ) begin
                    
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin

                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;

                    end
                end
                else if (counter_column_r >= 271 && counter_column_r <= 277 ) begin
                    
                    if(counter_row_r >= 381 && counter_row_r <= 394 ||
                        counter_row_r >= 423 && counter_row_r <= 429 ||
                        counter_row_r >= 451 && counter_row_r <= 478 ||
                        counter_row_r >= 486 && counter_row_r <= 506 ||
                        counter_row_r >= 289 && counter_row_r <= 294 ||
                        counter_row_r >= 632 && counter_row_r <= 637 ||
                        counter_row_r >= 535 && counter_row_r <= 541
                    ) begin
                    
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin

                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;

                    end
                end
                else if (counter_column_r >= 278 && counter_column_r <= 284 ) begin
                    
                    if(
                        counter_row_r >= 395 && counter_row_r <= 401||
                        counter_row_r >= 423 && counter_row_r <= 429 ||
                        counter_row_r >= 451 && counter_row_r <= 457 ||
                        counter_row_r >= 472 && counter_row_r <= 478 ||
                        counter_row_r >= 486 && counter_row_r <= 492 ||
                        counter_row_r >= 500 && counter_row_r <= 506 ||
                        counter_row_r >= 289 && counter_row_r <= 294 ||
                        counter_row_r >= 632 && counter_row_r <= 637 ||
                        counter_row_r >= 535 && counter_row_r <= 541   
                    ) begin
                    
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin

                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;

                    end
                end
                else if (counter_column_r >= 285 && counter_column_r <= 291 ) begin
                    
                    if(counter_row_r >= 374 && counter_row_r <= 394 ||
                        counter_row_r >= 423 && counter_row_r <= 429 ||
                        counter_row_r >= 451 && counter_row_r <= 457 ||
                        counter_row_r >= 472 && counter_row_r <= 478 ||
                        counter_row_r >= 486 && counter_row_r <= 492 ||
                        counter_row_r >= 507 && counter_row_r <= 513 ||
                        counter_row_r >= 289 && counter_row_r <= 294 ||
                        counter_row_r >= 632 && counter_row_r <= 637 ||
                        counter_row_r >= 535 && counter_row_r <= 541   
                    ) begin
                    
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin

                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;

                    end
                end
                
                //frame    
                else if (counter_column_r >= 201 && counter_column_r <= 206 || counter_column_r >= 340 && counter_column_r <= 345) begin
                    if(counter_row_r >= 289 && counter_row_r <= 637) begin
                        
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;

                    end

                    else begin

                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;

                    end
                end
                else if (counter_column_r >= 207 && counter_column_r <= 256 || counter_column_r >= 292 && counter_column_r <= 339) begin
                    if(counter_row_r >= 289 && counter_row_r <= 294 || counter_row_r >= 632 && counter_row_r <= 637) begin

                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;

                    end

                    else begin

                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;

                    end
                end
                else begin
                    VGA_R_w = 255;
                    VGA_G_w = 255;
                    VGA_B_w = 255;
                end
            end

            record: begin
                //1
                if (counter_column_r >= 257 && counter_column_r <= 263 ) begin
                    if(counter_row_r >= 278 && counter_row_r <= 298 ||
                       counter_row_r >= 313 && counter_row_r <= 340 ||
                       counter_row_r >= 355 && counter_row_r <= 368 ||
                       counter_row_r >= 390 && counter_row_r <= 403 ||
                       counter_row_r >= 418 && counter_row_r <= 438 ||
                       counter_row_r >= 453 && counter_row_r <= 473 ||
                       counter_row_r >= 488 && counter_row_r <= 508 ||
                       counter_row_r >= 516 && counter_row_r <= 522 ||
                       counter_row_r >= 537 && counter_row_r <= 543 ||
                       counter_row_r >= 558 && counter_row_r <= 571 
                    ) begin
                    
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //2
                else if (counter_column_r >= 264 && counter_column_r <= 270 ) begin
                    if(counter_row_r >= 278 && counter_row_r <= 284 ||
                       counter_row_r >= 299 && counter_row_r <= 305 ||
                       counter_row_r >= 313 && counter_row_r <= 319 ||
                       counter_row_r >= 348 && counter_row_r <= 354 ||
                       counter_row_r >= 369 && counter_row_r <= 375 ||
                       counter_row_r >= 383 && counter_row_r <= 389 ||
                       counter_row_r >= 404 && counter_row_r <= 410 ||
                       counter_row_r >= 418 && counter_row_r <= 424 ||
                       counter_row_r >= 439 && counter_row_r <= 445 ||
                       counter_row_r >= 453 && counter_row_r <= 459 ||
                       counter_row_r >= 474 && counter_row_r <= 480 ||
                       counter_row_r >= 495 && counter_row_r <= 501 ||
                       counter_row_r >= 516 && counter_row_r <= 529 ||
                       counter_row_r >= 537 && counter_row_r <= 543 ||
                       counter_row_r >= 551 && counter_row_r <= 557 
                    ) begin
                    
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //3
                else if (counter_column_r >= 271 && counter_column_r <= 277 ) begin                    
                    if(counter_row_r >= 278 && counter_row_r <= 298 ||  
                       counter_row_r >= 313 && counter_row_r <= 333 ||
                       counter_row_r >= 348 && counter_row_r <= 354 || 
                       counter_row_r >= 383 && counter_row_r <= 389 || 
                       counter_row_r >= 404 && counter_row_r <= 410 ||
                       counter_row_r >= 418 && counter_row_r <= 438 ||
                       counter_row_r >= 453 && counter_row_r <= 459 ||
                       counter_row_r >= 474 && counter_row_r <= 480 ||
                       counter_row_r >= 495 && counter_row_r <= 501 ||
                       counter_row_r >= 516 && counter_row_r <= 522 ||
                       counter_row_r >= 530 && counter_row_r <= 543 ||
                       counter_row_r >= 551 && counter_row_r <= 557 ||
                       counter_row_r >= 565 && counter_row_r <= 578 
                    ) begin
                    
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //4
                else if (counter_column_r >= 278 && counter_column_r <= 284 ) begin     
                    if(counter_row_r >= 278 && counter_row_r <= 284 ||
                       counter_row_r >= 292 && counter_row_r <= 298 ||
                       counter_row_r >= 313 && counter_row_r <= 319 ||
                       counter_row_r >= 348 && counter_row_r <= 354 ||
                       counter_row_r >= 369 && counter_row_r <= 375 ||
                       counter_row_r >= 383 && counter_row_r <= 389 ||
                       counter_row_r >= 404 && counter_row_r <= 410 ||
                       counter_row_r >= 418 && counter_row_r <= 424 ||
                       counter_row_r >= 432 && counter_row_r <= 438 ||
                       counter_row_r >= 453 && counter_row_r <= 459 ||
                       counter_row_r >= 474 && counter_row_r <= 480 ||
                       counter_row_r >= 495 && counter_row_r <= 501 ||
                       counter_row_r >= 516 && counter_row_r <= 522 ||
                       counter_row_r >= 537 && counter_row_r <= 543 ||
                       counter_row_r >= 551 && counter_row_r <= 557 ||
                       counter_row_r >= 572 && counter_row_r <= 578 
                    ) begin
                    
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //5
                else if (counter_column_r >= 285 && counter_column_r <= 291 ) begin                    
                    if(counter_row_r >= 278 && counter_row_r <= 284 ||
                       counter_row_r >= 299 && counter_row_r <= 305 ||
                       counter_row_r >= 313 && counter_row_r <= 340 ||
                       counter_row_r >= 355 && counter_row_r <= 368 ||
                       counter_row_r >= 390 && counter_row_r <= 403 ||
                       counter_row_r >= 418 && counter_row_r <= 424 ||
                       counter_row_r >= 439 && counter_row_r <= 445 ||
                       counter_row_r >= 453 && counter_row_r <= 473 ||
                       counter_row_r >= 488 && counter_row_r <= 508 ||
                       counter_row_r >= 516 && counter_row_r <= 522 ||
                       counter_row_r >= 537 && counter_row_r <= 543 ||
                       counter_row_r >= 558 && counter_row_r <= 571 ||
                       counter_row_r >= 593 && counter_row_r <= 599 ||
                       counter_row_r >= 621 && counter_row_r <= 627 ||
                       counter_row_r >= 649 && counter_row_r <= 655 
                    ) begin
                    
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
               
                else begin
                    VGA_R_w = 255;
                    VGA_G_w = 255;
                    VGA_B_w = 255;
                end
            end

            load: begin
                //1
                if (counter_column_r >= 239 && counter_column_r <= 245 ) begin
                    if(counter_row_r >= 349 && counter_row_r <= 355 ||
                       counter_row_r >= 391 && counter_row_r <= 404 ||
                       counter_row_r >= 426 && counter_row_r <= 439 ||
                       counter_row_r >= 454 && counter_row_r <= 474 ||
                       counter_row_r >= 489 && counter_row_r <= 509 ||
                       counter_row_r >= 517 && counter_row_r <= 523 ||
                       counter_row_r >= 538 && counter_row_r <= 544 ||
                       counter_row_r >= 559 && counter_row_r <= 572 
                    ) begin
                    
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //2
                else if (counter_column_r >= 246 && counter_column_r <= 252 ) begin
                    if(counter_row_r >= 349 && counter_row_r <= 355 ||
                       counter_row_r >= 384 && counter_row_r <= 390 ||
                       counter_row_r >= 405 && counter_row_r <= 411 ||
                       counter_row_r >= 419 && counter_row_r <= 425 ||
                       counter_row_r >= 440 && counter_row_r <= 446 ||
                       counter_row_r >= 454 && counter_row_r <= 460 ||
                       counter_row_r >= 475 && counter_row_r <= 481 ||
                       counter_row_r >= 496 && counter_row_r <= 502 ||
                       counter_row_r >= 517 && counter_row_r <= 530 ||
                       counter_row_r >= 538 && counter_row_r <= 544 ||
                       counter_row_r >= 552 && counter_row_r <= 558 
                    ) begin
                    
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //3
                else if (counter_column_r >= 253 && counter_column_r <= 259 ) begin                    
                    if(counter_row_r >= 349 && counter_row_r <= 355 ||
                       counter_row_r >= 384 && counter_row_r <= 390 ||
                       counter_row_r >= 405 && counter_row_r <= 411 ||
                       counter_row_r >= 419 && counter_row_r <= 446 ||
                       counter_row_r >= 454 && counter_row_r <= 460 ||
                       counter_row_r >= 475 && counter_row_r <= 481 ||
                       counter_row_r >= 496 && counter_row_r <= 502 ||
                       counter_row_r >= 517 && counter_row_r <= 523 ||
                       counter_row_r >= 531 && counter_row_r <= 544 ||
                       counter_row_r >= 552 && counter_row_r <= 558 ||
                       counter_row_r >= 566 && counter_row_r <= 579 
                    ) begin
                    
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //4
                else if (counter_column_r >= 260 && counter_column_r <= 266 ) begin     
                    if(counter_row_r >= 349 && counter_row_r <= 355 ||
                       counter_row_r >= 384 && counter_row_r <= 390 ||
                       counter_row_r >= 405 && counter_row_r <= 411 ||
                       counter_row_r >= 419 && counter_row_r <= 425 ||
                       counter_row_r >= 440 && counter_row_r <= 446 ||
                       counter_row_r >= 454 && counter_row_r <= 460 ||
                       counter_row_r >= 475 && counter_row_r <= 481 ||
                       counter_row_r >= 496 && counter_row_r <= 502 ||
                       counter_row_r >= 517 && counter_row_r <= 523 ||
                       counter_row_r >= 538 && counter_row_r <= 544 ||
                       counter_row_r >= 552 && counter_row_r <= 558 ||
                       counter_row_r >= 573 && counter_row_r <= 579 
                    ) begin
                    
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //5
                else if (counter_column_r >= 267 && counter_column_r <= 273 ) begin                    
                    if(counter_row_r >= 349 && counter_row_r <= 376 ||
                       counter_row_r >= 391 && counter_row_r <= 404 ||
                       counter_row_r >= 419 && counter_row_r <= 425 ||
                       counter_row_r >= 440 && counter_row_r <= 446 ||
                       counter_row_r >= 454 && counter_row_r <= 474 ||
                       counter_row_r >= 489 && counter_row_r <= 509 ||
                       counter_row_r >= 517 && counter_row_r <= 523 ||
                       counter_row_r >= 538 && counter_row_r <= 544 ||
                       counter_row_r >= 559 && counter_row_r <= 572 
                    ) begin
                    
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //frame
                else if (counter_column_r >= 285 && counter_column_r <= 290 || counter_column_r >= 317 && counter_column_r <= 322 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 617 ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //crossline
                else if (counter_column_r == 286 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 371 && counter_row_r <= 390 ||
                       counter_row_r >= 454 && counter_row_r <= 473 ||
                       counter_row_r >= 543 && counter_row_r <= 562                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end 
                else if (counter_column_r == 287 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 370 && counter_row_r <= 389 ||
                       counter_row_r >= 453 && counter_row_r <= 472 ||
                       counter_row_r >= 542 && counter_row_r <= 561                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r == 288 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 369 && counter_row_r <= 388 ||
                       counter_row_r >= 452 && counter_row_r <= 471 ||
                       counter_row_r >= 541 && counter_row_r <= 560                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r == 289 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 368 && counter_row_r <= 387 ||
                       counter_row_r >= 451 && counter_row_r <= 470 ||
                       counter_row_r >= 540 && counter_row_r <= 559                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r == 290 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 367 && counter_row_r <= 386 ||
                       counter_row_r >= 450 && counter_row_r <= 469 ||
                       counter_row_r >= 539 && counter_row_r <= 558                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r == 291 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 366 && counter_row_r <= 385 ||
                       counter_row_r >= 449 && counter_row_r <= 468 ||
                       counter_row_r >= 538 && counter_row_r <= 557                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r == 292 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 365 && counter_row_r <= 384 ||
                       counter_row_r >= 448 && counter_row_r <= 467 ||
                       counter_row_r >= 537 && counter_row_r <= 556                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r == 293 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 364 && counter_row_r <= 383 ||
                       counter_row_r >= 447 && counter_row_r <= 466 ||
                       counter_row_r >= 536 && counter_row_r <= 555                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r == 294 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 363 && counter_row_r <= 382 ||
                       counter_row_r >= 446 && counter_row_r <= 465 ||
                       counter_row_r >= 535 && counter_row_r <= 554                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r == 295 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 362 && counter_row_r <= 381 ||
                       counter_row_r >= 445 && counter_row_r <= 464 ||
                       counter_row_r >= 534 && counter_row_r <= 553                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r == 296 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 361 && counter_row_r <= 380 ||
                       counter_row_r >= 444 && counter_row_r <= 463 ||
                       counter_row_r >= 533 && counter_row_r <= 552                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r == 297 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 360 && counter_row_r <= 379 ||
                       counter_row_r >= 443 && counter_row_r <= 462 ||
                       counter_row_r >= 532 && counter_row_r <= 551                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r == 298 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 359 && counter_row_r <= 378 ||
                       counter_row_r >= 442 && counter_row_r <= 461 ||
                       counter_row_r >= 531 && counter_row_r <= 550                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r == 299 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 358 && counter_row_r <= 377 ||
                       counter_row_r >= 441 && counter_row_r <= 460 ||
                       counter_row_r >= 530 && counter_row_r <= 549                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r == 300 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 357 && counter_row_r <= 376 ||
                       counter_row_r >= 440 && counter_row_r <= 459 ||
                       counter_row_r >= 529 && counter_row_r <= 548                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r == 301 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 356 && counter_row_r <= 375 ||
                       counter_row_r >= 439 && counter_row_r <= 458 ||
                       counter_row_r >= 528 && counter_row_r <= 547                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r == 302 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 355 && counter_row_r <= 374 ||
                       counter_row_r >= 438 && counter_row_r <= 457 ||
                       counter_row_r >= 527 && counter_row_r <= 546                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r == 303 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 354 && counter_row_r <= 373 ||
                       counter_row_r >= 437 && counter_row_r <= 456 ||
                       counter_row_r >= 526 && counter_row_r <= 545                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r == 304 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 353 && counter_row_r <= 372 ||
                       counter_row_r >= 436 && counter_row_r <= 455 ||
                       counter_row_r >= 525 && counter_row_r <= 544                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r == 305 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 352 && counter_row_r <= 371 ||
                       counter_row_r >= 435 && counter_row_r <= 454 ||
                       counter_row_r >= 524 && counter_row_r <= 543                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r == 306 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 351 && counter_row_r <= 370 ||
                       counter_row_r >= 434 && counter_row_r <= 453 ||
                       counter_row_r >= 523 && counter_row_r <= 542                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r == 307 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 350 && counter_row_r <= 369 ||
                       counter_row_r >= 433 && counter_row_r <= 452 ||
                       counter_row_r >= 522 && counter_row_r <= 541                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r == 308 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 349 && counter_row_r <= 368 ||
                       counter_row_r >= 432 && counter_row_r <= 451 ||
                       counter_row_r >= 521 && counter_row_r <= 540                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r == 309 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 348 && counter_row_r <= 367 ||
                       counter_row_r >= 431 && counter_row_r <= 450 ||
                       counter_row_r >= 520 && counter_row_r <= 539                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r == 310 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 347 && counter_row_r <= 366 ||
                       counter_row_r >= 430 && counter_row_r <= 449 ||
                       counter_row_r >= 519 && counter_row_r <= 538                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r == 311 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 346 && counter_row_r <= 365 ||
                       counter_row_r >= 429 && counter_row_r <= 448 ||
                       counter_row_r >= 518 && counter_row_r <= 537                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r == 312 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 345 && counter_row_r <= 364 ||
                       counter_row_r >= 428 && counter_row_r <= 447 ||
                       counter_row_r >= 517 && counter_row_r <= 536                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r == 313 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 344 && counter_row_r <= 363 ||
                       counter_row_r >= 427 && counter_row_r <= 446 ||
                       counter_row_r >= 516 && counter_row_r <= 535                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r == 314 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 343 && counter_row_r <= 362 ||
                       counter_row_r >= 426 && counter_row_r <= 445 ||
                       counter_row_r >= 515 && counter_row_r <= 534                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r == 315 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 342 && counter_row_r <= 361 ||
                       counter_row_r >= 425 && counter_row_r <= 444 ||
                       counter_row_r >= 514 && counter_row_r <= 533                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r == 316 ) begin                    
                    if(counter_row_r >= 306 && counter_row_r <= 311 ||
                       counter_row_r >= 612 && counter_row_r <= 617 ||
                       counter_row_r >= 341 && counter_row_r <= 360 ||
                       counter_row_r >= 424 && counter_row_r <= 443 ||
                       counter_row_r >= 513 && counter_row_r <= 532                     
                     ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
               
                else begin
                    VGA_R_w = 255;
                    VGA_G_w = 255;
                    VGA_B_w = 255;
                end
            end

            ready: begin
                //1
                if (counter_column_r >= 257 && counter_column_r <= 263 ) begin
                    if(counter_row_r >= 333 && counter_row_r <= 353 ||
                       counter_row_r >= 368 && counter_row_r <= 395 ||
                       counter_row_r >= 410 && counter_row_r <= 423 ||
                       counter_row_r >= 438 && counter_row_r <= 458 ||
                       counter_row_r >= 473 && counter_row_r <= 479 ||
                       counter_row_r >= 501 && counter_row_r <= 507 ||
                       counter_row_r >= 522 && counter_row_r <= 528 ||
                       counter_row_r >= 550 && counter_row_r <= 556 ||
                       counter_row_r >= 578 && counter_row_r <= 584 
                    ) begin
                    
                        VGA_R_w = 255;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //2
                else if (counter_column_r >= 264 && counter_column_r <= 270 ) begin
                    if(counter_row_r >= 333 && counter_row_r <= 339 ||
                       counter_row_r >= 354 && counter_row_r <= 360 ||
                       counter_row_r >= 368 && counter_row_r <= 374 ||
                       counter_row_r >= 403 && counter_row_r <= 409 ||
                       counter_row_r >= 403 && counter_row_r <= 409 ||
                       counter_row_r >= 424 && counter_row_r <= 430 ||
                       counter_row_r >= 438 && counter_row_r <= 444 ||
                       counter_row_r >= 459 && counter_row_r <= 465 ||
                       counter_row_r >= 473 && counter_row_r <= 479 ||
                       counter_row_r >= 501 && counter_row_r <= 507 ||
                       counter_row_r >= 522 && counter_row_r <= 528 ||
                       counter_row_r >= 550 && counter_row_r <= 556 ||
                       counter_row_r >= 578 && counter_row_r <= 584 
                    ) begin
                    
                        VGA_R_w = 255;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //3
                else if (counter_column_r >= 271 && counter_column_r <= 277 ) begin                    
                    if(counter_row_r >= 333 && counter_row_r <= 353 ||
                       counter_row_r >= 368 && counter_row_r <= 388 ||
                       counter_row_r >= 403 && counter_row_r <= 430 ||
                       counter_row_r >= 438 && counter_row_r <= 444 ||
                       counter_row_r >= 459 && counter_row_r <= 465 ||
                       counter_row_r >= 480 && counter_row_r <= 500 ||
                       counter_row_r >= 522 && counter_row_r <= 528 ||
                       counter_row_r >= 550 && counter_row_r <= 556 ||
                       counter_row_r >= 578 && counter_row_r <= 584 
                    ) begin
                    
                        VGA_R_w = 255;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //4
                else if (counter_column_r >= 278 && counter_column_r <= 284 ) begin     
                    if(counter_row_r >= 333 && counter_row_r <= 339 ||
                       counter_row_r >= 347 && counter_row_r <= 353 ||
                       counter_row_r >= 368 && counter_row_r <= 374 ||
                       counter_row_r >= 403 && counter_row_r <= 409 ||
                       counter_row_r >= 424 && counter_row_r <= 430 ||
                       counter_row_r >= 438 && counter_row_r <= 444 ||
                       counter_row_r >= 459 && counter_row_r <= 465 ||
                       counter_row_r >= 487 && counter_row_r <= 493 
                    ) begin
                    
                        VGA_R_w = 255;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //5
                else if (counter_column_r >= 285 && counter_column_r <= 291 ) begin                    
                    if(counter_row_r >= 333 && counter_row_r <= 339 ||
                       counter_row_r >= 354 && counter_row_r <= 360 ||
                       counter_row_r >= 368 && counter_row_r <= 395 ||
                       counter_row_r >= 403 && counter_row_r <= 409 ||
                       counter_row_r >= 424 && counter_row_r <= 430 ||
                       counter_row_r >= 438 && counter_row_r <= 458 ||
                       counter_row_r >= 487 && counter_row_r <= 493 ||
                       counter_row_r >= 522 && counter_row_r <= 528 ||
                       counter_row_r >= 550 && counter_row_r <= 556 ||
                       counter_row_r >= 578 && counter_row_r <= 584 
                    ) begin
                    
                        VGA_R_w = 255;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
               
                else begin
                    VGA_R_w = 255;
                    VGA_G_w = 255;
                    VGA_B_w = 255;
                end
            end

            ending: begin
                //1
                if (counter_column_r >= 351 && counter_column_r <= 355 ) begin
                    if(counter_row_r >= 398 && counter_row_r <= 412 ||
                       counter_row_r >= 423 && counter_row_r <= 437 ||
                       counter_row_r >= 448 && counter_row_r <= 467 ||
                       counter_row_r >= 478 && counter_row_r <= 492 ||
                       counter_row_r >= 503 && counter_row_r <= 517 
                       
                    ) begin
                    
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //2
                else if (counter_column_r >= 356 && counter_column_r <= 360 ) begin
                    if(counter_row_r >= 398 && counter_row_r <= 402 ||
                       counter_row_r >= 413 && counter_row_r <= 417 ||
                       counter_row_r >= 423 && counter_row_r <= 427 ||
                       counter_row_r >= 438 && counter_row_r <= 442 ||
                       counter_row_r >= 448 && counter_row_r <= 452 ||
                       counter_row_r >= 473 && counter_row_r <= 477 ||
                       counter_row_r >= 498 && counter_row_r <= 502   
                    ) begin                   
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //3
                else if (counter_column_r >= 361 && counter_column_r <= 365 ) begin
                    if(counter_row_r >= 398 && counter_row_r <= 412 ||
                       counter_row_r >= 423 && counter_row_r <= 437 ||
                       counter_row_r >= 448 && counter_row_r <= 462 ||
                       counter_row_r >= 478 && counter_row_r <= 487 ||
                       counter_row_r >= 503 && counter_row_r <= 512 
                    ) begin                   
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //4
                else if (counter_column_r >= 366 && counter_column_r <= 370 ) begin
                    if(counter_row_r >= 398 && counter_row_r <= 402 ||
                       counter_row_r >= 423 && counter_row_r <= 427 ||
                       counter_row_r >= 433 && counter_row_r <= 437 ||
                       counter_row_r >= 448 && counter_row_r <= 452 ||
                       counter_row_r >= 488 && counter_row_r <= 492 ||
                       counter_row_r >= 513 && counter_row_r <= 517                        
                    ) begin                   
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //5
                else if (counter_column_r >= 371 && counter_column_r <= 375 ) begin
                    if(counter_row_r >= 398 && counter_row_r <= 402 ||
                       counter_row_r >= 423 && counter_row_r <= 427 ||
                       counter_row_r >= 438 && counter_row_r <= 442 ||
                       counter_row_r >= 448 && counter_row_r <= 467 ||
                       counter_row_r >= 473 && counter_row_r <= 487 ||
                       counter_row_r >= 498 && counter_row_r <= 512                        
                    ) begin                   
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //////////////
                //1
                else if (counter_column_r >= 392 && counter_column_r <= 396 ) begin
                    if(counter_row_r >= 351 && counter_row_r <= 360 ||
                       counter_row_r >= 426 && counter_row_r <= 440 ||   
                       counter_row_r >= 451 && counter_row_r <= 470 || 
                       counter_row_r >= 476 && counter_row_r <= 490 || 
                       counter_row_r >= 501 && counter_row_r <= 505 ||   
                       counter_row_r >= 531 && counter_row_r <= 540 ||
                       counter_row_r >= 551 && counter_row_r <= 555 ||
                       counter_row_r >= 571 && counter_row_r <= 575                               
                    ) begin                   
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //2
                else if (counter_column_r >= 397 && counter_column_r <= 401 ) begin
                    if(counter_row_r >= 346 && counter_row_r <= 350 ||  
                       counter_row_r >= 361 && counter_row_r <= 365 ||   
                       counter_row_r >= 401 && counter_row_r <= 405 ||  
                       counter_row_r >= 426 && counter_row_r <= 430 ||  
                       counter_row_r >= 441 && counter_row_r <= 445 ||  
                       counter_row_r >= 451 && counter_row_r <= 455 || 
                       counter_row_r >= 476 && counter_row_r <= 480 ||    
                       counter_row_r >= 491 && counter_row_r <= 495 ||  
                       counter_row_r >= 501 && counter_row_r <= 505 ||  
                       counter_row_r >= 526 && counter_row_r <= 530 || 
                       counter_row_r >= 541 && counter_row_r <= 545 || 
                       counter_row_r >= 551 && counter_row_r <= 555 ||
                       counter_row_r >= 571 && counter_row_r <= 575     
                    ) begin                   
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //3
                else if (counter_column_r >= 402 && counter_column_r <= 406 ) begin
                    if(counter_row_r >= 346 && counter_row_r <= 350 ||  
                       counter_row_r >= 361 && counter_row_r <= 365 ||
                       counter_row_r >= 381 && counter_row_r <= 395 ||
                       counter_row_r >= 406 && counter_row_r <= 410 || 
                       counter_row_r >= 426 && counter_row_r <= 440 ||    
                       counter_row_r >= 451 && counter_row_r <= 465 ||
                       counter_row_r >= 476 && counter_row_r <= 490 ||
                       counter_row_r >= 501 && counter_row_r <= 505 ||
                       counter_row_r >= 526 && counter_row_r <= 545 ||
                       counter_row_r >= 556 && counter_row_r <= 570                   
                    ) begin                   
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //4
                else if (counter_column_r >= 407 && counter_column_r <= 411 ) begin
                    if(counter_row_r >= 346 && counter_row_r <= 350 ||  
                       counter_row_r >= 361 && counter_row_r <= 365 || 
                       counter_row_r >= 401 && counter_row_r <= 405 ||
                       counter_row_r >= 426 && counter_row_r <= 430 ||  
                       counter_row_r >= 436 && counter_row_r <= 440 ||
                       counter_row_r >= 451 && counter_row_r <= 455 ||  
                       counter_row_r >= 476 && counter_row_r <= 480 ||
                       counter_row_r >= 501 && counter_row_r <= 505 || 
                       counter_row_r >= 526 && counter_row_r <= 530 || 
                       counter_row_r >= 541 && counter_row_r <= 545 || 
                       counter_row_r >= 561 && counter_row_r <= 565                                  
                    ) begin                   
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //5
                else if (counter_column_r >= 412 && counter_column_r <= 416 ) begin
                    if(counter_row_r >= 351 && counter_row_r <= 360 ||   
                       counter_row_r >= 426 && counter_row_r <= 430 || 
                       counter_row_r >= 441 && counter_row_r <= 445 ||   
                       counter_row_r >= 451 && counter_row_r <= 470 ||
                       counter_row_r >= 476 && counter_row_r <= 480 || 
                       counter_row_r >= 501 && counter_row_r <= 520 || 
                       counter_row_r >= 526 && counter_row_r <= 530 || 
                       counter_row_r >= 541 && counter_row_r <= 545 || 
                       counter_row_r >= 561 && counter_row_r <= 565        
                    ) begin                   
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //////////////
                //1
                else if (counter_column_r >= 433 && counter_column_r <= 437 ) begin
                    if(counter_row_r >= 344 && counter_row_r <= 348 ||
                       counter_row_r >= 414 && counter_row_r <= 418 ||
                       counter_row_r >= 429 && counter_row_r <= 433 ||
                       counter_row_r >= 439 && counter_row_r <= 458 ||
                       counter_row_r >= 464 && counter_row_r <= 468 ||   
                       counter_row_r >= 484 && counter_row_r <= 488 ||   
                       counter_row_r >= 509 && counter_row_r <= 523 || 
                       counter_row_r >= 534 && counter_row_r <= 543 ||  
                       counter_row_r >= 554 && counter_row_r <= 558 ||  
                       counter_row_r >= 569 && counter_row_r <= 573 || 
                       counter_row_r >= 584 && counter_row_r <= 593  
                    ) begin                   
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //2
                else if (counter_column_r >= 438 && counter_column_r <= 442 ) begin
                    if(counter_row_r >= 339 && counter_row_r <= 348 ||
                       counter_row_r >= 389 && counter_row_r <= 393 ||
                       counter_row_r >= 429 && counter_row_r <= 433 ||
                       counter_row_r >= 414 && counter_row_r <= 423 ||
                       counter_row_r >= 439 && counter_row_r <= 443 ||
                       counter_row_r >= 464 && counter_row_r <= 468 ||   
                       counter_row_r >= 484 && counter_row_r <= 488 || 
                       counter_row_r >= 504 && counter_row_r <= 508 ||  
                       counter_row_r >= 529 && counter_row_r <= 533 ||  
                       counter_row_r >= 544 && counter_row_r <= 548 ||   
                       counter_row_r >= 554 && counter_row_r <= 563 ||
                       counter_row_r >= 569 && counter_row_r <= 573 ||
                       counter_row_r >= 579 && counter_row_r <= 583 
                    ) begin                   
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //3
                else if (counter_column_r >= 443 && counter_column_r <= 447 ) begin
                    if(counter_row_r >= 344 && counter_row_r <= 348 ||
                       counter_row_r >= 369 && counter_row_r <= 383 ||
                       counter_row_r >= 394 && counter_row_r <= 398 ||
                       counter_row_r >= 414 && counter_row_r <= 418 ||
                       counter_row_r >= 424 && counter_row_r <= 433 ||
                       counter_row_r >= 439 && counter_row_r <= 453 ||
                       counter_row_r >= 464 && counter_row_r <= 468 ||   
                       counter_row_r >= 484 && counter_row_r <= 488 ||        
                       counter_row_r >= 474 && counter_row_r <= 478 || 
                       counter_row_r >= 509 && counter_row_r <= 518 || 
                       counter_row_r >= 529 && counter_row_r <= 533 ||  
                       counter_row_r >= 544 && counter_row_r <= 548 ||   
                       counter_row_r >= 554 && counter_row_r <= 558 || 
                       counter_row_r >= 564 && counter_row_r <= 573 || 
                       counter_row_r >= 579 && counter_row_r <= 583 || 
                       counter_row_r >= 589 && counter_row_r <= 598 
                    ) begin                   
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //4
                else if (counter_column_r >= 448 && counter_column_r <= 452 ) begin
                    if(counter_row_r >= 344 && counter_row_r <= 348 ||
                       counter_row_r >= 389 && counter_row_r <= 393 ||
                       counter_row_r >= 414 && counter_row_r <= 418 ||  
                       counter_row_r >= 429 && counter_row_r <= 433 ||
                       counter_row_r >= 439 && counter_row_r <= 443 || 
                       counter_row_r >= 464 && counter_row_r <= 473 ||
                       counter_row_r >= 479 && counter_row_r <= 488 || 
                       counter_row_r >= 519 && counter_row_r <= 523 ||  
                       counter_row_r >= 529 && counter_row_r <= 533 ||  
                       counter_row_r >= 544 && counter_row_r <= 548 ||
                       counter_row_r >= 554 && counter_row_r <= 558 ||  
                       counter_row_r >= 569 && counter_row_r <= 573 || 
                       counter_row_r >= 579 && counter_row_r <= 583 ||
                       counter_row_r >= 594 && counter_row_r <= 598          
                    ) begin                   
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //5
                else if (counter_column_r >= 453 && counter_column_r <= 457 ) begin
                    if(counter_row_r >= 339 && counter_row_r <= 353 ||
                       counter_row_r >= 414 && counter_row_r <= 418 || 
                       counter_row_r >= 429 && counter_row_r <= 433 ||
                       counter_row_r >= 439 && counter_row_r <= 458 ||
                       counter_row_r >= 464 && counter_row_r <= 468 ||   
                       counter_row_r >= 484 && counter_row_r <= 488 ||
                       counter_row_r >= 504 && counter_row_r <= 518 ||  
                       counter_row_r >= 534 && counter_row_r <= 543 ||
                       counter_row_r >= 554 && counter_row_r <= 558 ||  
                       counter_row_r >= 569 && counter_row_r <= 573 || 
                       counter_row_r >= 584 && counter_row_r <= 593                   
                    ) begin                   
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //frame
                else if (counter_column_r >= 88 && counter_column_r <= 93 || counter_column_r >= 302 && counter_column_r <= 307 ) begin
                    if(counter_row_r >= 204 && counter_row_r <= 729) begin                   
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                else if (counter_column_r >= 94 && counter_column_r <= 127 || 
                         counter_column_r >= 153 && counter_column_r <= 169 ||
                         counter_column_r >= 195 && counter_column_r <= 207 ||
                         counter_column_r >= 233 && counter_column_r <= 243 ||
                         counter_column_r >= 269 && counter_column_r <= 301 
                        ) begin
                    if(counter_row_r >= 724 && counter_row_r <= 729 || counter_row_r >= 204 && counter_row_r <= 209) begin                   
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    else begin
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;
                    end
                end
                //score
                //1
                else if (counter_column_r >= 128 && counter_column_r <= 132 ) begin
                    if(counter_row_r >= 352 && counter_row_r <= 366 ||
                       counter_row_r >= 377 && counter_row_r <= 386 ||
                       counter_row_r >= 402 && counter_row_r <= 411 ||
                       counter_row_r >= 422 && counter_row_r <= 436 ||
                       counter_row_r >= 447 && counter_row_r <= 466 ||
                       counter_row_r >= 724 && counter_row_r <= 729 || 
                       counter_row_r >= 204 && counter_row_r <= 209
                    ) begin                   
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    case(score[15:12])
                        ZERO:begin
                            if(counter_row_r >= 497 && counter_row_r <= 506 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 500 && counter_row_r <= 504 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 497 && counter_row_r <= 506 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 497 && counter_row_r <= 506 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 502 && counter_row_r <= 506) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 492 && counter_row_r <= 511) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 497 && counter_row_r <= 506 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 492 && counter_row_r <= 506) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 497 && counter_row_r <= 506 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 497 && counter_row_r <= 506 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                    endcase
                    case(score[11:8])
                        ZERO:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 524 && counter_row_r <= 528 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 527 && counter_row_r <= 531) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 517 && counter_row_r <= 536) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 517 && counter_row_r <= 531) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                    endcase
                    case(score[7:4])
                        ZERO:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 551 && counter_row_r <= 555 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 552 && counter_row_r <= 556) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 542 && counter_row_r <= 561) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 542 && counter_row_r <= 556) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                    endcase
                    case(score[3:0])
                        ZERO:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 576 && counter_row_r <= 580 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 577 && counter_row_r <= 581) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 567 && counter_row_r <= 586) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 567 && counter_row_r <= 581) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                    endcase
                end
                //2
                else if (counter_column_r >= 133 && counter_column_r <= 137 ) begin
                    if(counter_row_r >= 347 && counter_row_r <= 351 ||
                       counter_row_r >= 372 && counter_row_r <= 376 ||
                       counter_row_r >= 387 && counter_row_r <= 391 ||
                       counter_row_r >= 397 && counter_row_r <= 401 ||
                       counter_row_r >= 412 && counter_row_r <= 416 ||
                       counter_row_r >= 422 && counter_row_r <= 426 ||
                       counter_row_r >= 437 && counter_row_r <= 441 ||
                       counter_row_r >= 447 && counter_row_r <= 451 ||
                       counter_row_r >= 477 && counter_row_r <= 481 ||
                       counter_row_r >= 724 && counter_row_r <= 729 || 
                       counter_row_r >= 204 && counter_row_r <= 209
                    ) begin                   
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    case(score[15:12])
                        ZERO:begin
                            if(counter_row_r >= 492 && counter_row_r <= 496 ||
                               counter_row_r >= 507 && counter_row_r <= 511 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 495 && counter_row_r <= 504) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 492 && counter_row_r <= 496 ||
                               counter_row_r >= 507 && counter_row_r <= 511 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 492 && counter_row_r <= 496 ||
                               counter_row_r >= 507 && counter_row_r <= 511 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 497 && counter_row_r <= 506 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 492 && counter_row_r <= 496) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 492 && counter_row_r <= 496 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 507 && counter_row_r <= 511) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 492 && counter_row_r <= 496 ||
                               counter_row_r >= 507 && counter_row_r <= 511 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 492 && counter_row_r <= 496 ||
                               counter_row_r >= 507 && counter_row_r <= 511 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                    endcase
                    case(score[11:8])
                        ZERO:begin
                            if(counter_row_r >= 517 && counter_row_r <= 521 ||
                               counter_row_r >= 532 && counter_row_r <= 536 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 519 && counter_row_r <= 528 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536 ||
                               counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536 ||
                               counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 517 && counter_row_r <= 521) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536 ||
                               counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536 ||
                               counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                    endcase
                    case(score[7:4])
                        ZERO:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 546 && counter_row_r <= 555 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 557 && counter_row_r <= 561) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                    endcase
                    case(score[3:0])
                        ZERO:begin
                            if(counter_row_r >= 567 && counter_row_r <= 571 ||
                               counter_row_r >= 582 && counter_row_r <= 586  ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 571 && counter_row_r <= 580 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586 ||
                               counter_row_r >= 567 && counter_row_r <= 571 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586 ||
                               counter_row_r >= 567 && counter_row_r <= 571 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 567 && counter_row_r <= 571) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 567 && counter_row_r <= 571) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586 ||
                               counter_row_r >= 567 && counter_row_r <= 571 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586 ||
                               counter_row_r >= 567 && counter_row_r <= 571 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                    endcase
                end
                //3
                else if (counter_column_r >= 138 && counter_column_r <= 142 ) begin
                    if(counter_row_r >= 352 && counter_row_r <= 361 ||
                       counter_row_r >= 372 && counter_row_r <= 376 ||
                       counter_row_r >= 397 && counter_row_r <= 401 ||
                       counter_row_r >= 412 && counter_row_r <= 416 ||
                       counter_row_r >= 422 && counter_row_r <= 436 ||
                       counter_row_r >= 447 && counter_row_r <= 461 ||
                       counter_row_r >= 724 && counter_row_r <= 729 || 
                       counter_row_r >= 204 && counter_row_r <= 209
                          
                    ) begin                   
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    case(score[15:12])
                        ZERO:begin
                            if(counter_row_r >= 492 && counter_row_r <= 496 ||
                               counter_row_r >= 507 && counter_row_r <= 511 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 500 && counter_row_r <= 504) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 502 && counter_row_r <= 506) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 502 && counter_row_r <= 506) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 492 && counter_row_r <= 496 ||
                               counter_row_r >= 502 && counter_row_r <= 506 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 492 && counter_row_r <= 506) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 492 && counter_row_r <= 506) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 507 && counter_row_r <= 511) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 497 && counter_row_r <= 506 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 496 && counter_row_r <= 511) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                    endcase
                    case(score[11:8])
                        ZERO:begin
                            if(counter_row_r >= 517 && counter_row_r <= 521 ||
                               counter_row_r >= 532 && counter_row_r <= 536 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 524 && counter_row_r <= 528 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 527 && counter_row_r <= 531) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 527 && counter_row_r <= 531) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 517 && counter_row_r <= 521 ||
                               counter_row_r >= 527 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 517 && counter_row_r <= 531) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 517 && counter_row_r <= 531) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 521 && counter_row_r <= 536) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                    endcase
                    case(score[7:4])
                        ZERO:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 551 && counter_row_r <= 555 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 552 && counter_row_r <= 556) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 552 && counter_row_r <= 556) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 552 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 542 && counter_row_r <= 556) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 542 && counter_row_r <= 556) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 557 && counter_row_r <= 561) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 546 && counter_row_r <= 561) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                    endcase
                    case(score[3:0])
                        ZERO:begin
                            if(counter_row_r >= 567 && counter_row_r <= 571 ||
                               counter_row_r >= 582 && counter_row_r <= 586  ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 576 && counter_row_r <= 580 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 577 && counter_row_r <= 581) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 577 && counter_row_r <= 581) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 567 && counter_row_r <= 571 ||
                               counter_row_r >= 577 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 567 && counter_row_r <= 581) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 567 && counter_row_r <= 581) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 571 && counter_row_r <= 586) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                    endcase
                end
                //4
                else if (counter_column_r >= 143 && counter_column_r <= 147 ) begin
                    if(counter_row_r >= 362 && counter_row_r <= 366 ||
                       counter_row_r >= 372 && counter_row_r <= 376 ||
                       counter_row_r >= 387 && counter_row_r <= 391 ||
                       counter_row_r >= 397 && counter_row_r <= 401 ||
                       counter_row_r >= 412 && counter_row_r <= 416 ||
                       counter_row_r >= 422 && counter_row_r <= 426 ||
                       counter_row_r >= 432 && counter_row_r <= 436 ||
                       counter_row_r >= 447 && counter_row_r <= 451 ||
                       counter_row_r >= 477 && counter_row_r <= 481 ||
                       counter_row_r >= 724 && counter_row_r <= 729 || 
                       counter_row_r >= 204 && counter_row_r <= 209
                    ) begin                   
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    case(score[15:12])
                        ZERO:begin
                            if(counter_row_r >= 492 && counter_row_r <= 496 ||
                               counter_row_r >= 507 && counter_row_r <= 511 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 500 && counter_row_r <= 504) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 497 && counter_row_r <= 501) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 492 && counter_row_r <= 496 ||
                               counter_row_r >= 507 && counter_row_r <= 511 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 492 && counter_row_r <= 511) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 507 && counter_row_r <= 511) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 492 && counter_row_r <= 496 ||
                               counter_row_r >= 507 && counter_row_r <= 511 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 502 && counter_row_r <= 506) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 492 && counter_row_r <= 496 ||
                               counter_row_r >= 507 && counter_row_r <= 511 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 507 && counter_row_r <= 511) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                    endcase
                    case(score[11:8])
                        ZERO:begin
                            if(counter_row_r >= 517 && counter_row_r <= 521 ||
                               counter_row_r >= 532 && counter_row_r <= 536 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 524 && counter_row_r <= 528 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 522 && counter_row_r <= 526) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536 ||
                               counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 517 && counter_row_r <= 536) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536 ||
                               counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 527 && counter_row_r <= 531) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536 ||
                               counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                    endcase
                    case(score[7:4])
                        ZERO:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 551 && counter_row_r <= 555 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 547 && counter_row_r <= 551) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 542 && counter_row_r <= 561) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 557 && counter_row_r <= 561) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 552 && counter_row_r <= 556) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 557 && counter_row_r <= 561) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                    endcase
                    case(score[3:0])
                        ZERO:begin
                            if(counter_row_r >= 567 && counter_row_r <= 571 ||
                               counter_row_r >= 582 && counter_row_r <= 586  ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 576 && counter_row_r <= 580 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 572 && counter_row_r <= 576) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586 ||
                               counter_row_r >= 567 && counter_row_r <= 571 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 567 && counter_row_r <= 586) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586 ||
                               counter_row_r >= 567 && counter_row_r <= 571 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 577 && counter_row_r <= 581) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586 ||
                               counter_row_r >= 567 && counter_row_r <= 571 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                    endcase
                end
                //5
                else if (counter_column_r >= 148 && counter_column_r <= 152 ) begin
                    if(counter_row_r >= 347 && counter_row_r <= 361 ||
                       counter_row_r >= 377 && counter_row_r <= 386 ||
                       counter_row_r >= 402 && counter_row_r <= 411 ||
                       counter_row_r >= 422 && counter_row_r <= 426 ||
                       counter_row_r >= 437 && counter_row_r <= 441 ||
                       counter_row_r >= 447 && counter_row_r <= 466 ||
                       counter_row_r >= 724 && counter_row_r <= 729 || 
                       counter_row_r >= 204 && counter_row_r <= 209
                    ) begin                   
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                    end
                    case(score[15:12])
                        ZERO:begin
                            if(counter_row_r >= 497 && counter_row_r <= 506 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 495 && counter_row_r <= 509 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 492 && counter_row_r <= 511) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 497 && counter_row_r <= 506 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 502 && counter_row_r <= 506) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 492 && counter_row_r <= 506) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 497 && counter_row_r <= 506 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 502 && counter_row_r <= 506) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 497 && counter_row_r <= 506 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 502 && counter_row_r <= 506) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                    endcase
                    case(score[11:8])
                        ZERO:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 519 && counter_row_r <= 533 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 517 && counter_row_r <= 536) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 527 && counter_row_r <= 531) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 517 && counter_row_r <= 531) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 527 && counter_row_r <= 531) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 527 && counter_row_r <= 531) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                    endcase
                    case(score[7:4])
                        ZERO:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 546 && counter_row_r <= 560 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 542 && counter_row_r <= 561) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 552 && counter_row_r <= 556) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 542 && counter_row_r <= 556) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 552 && counter_row_r <= 556) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 552 && counter_row_r <= 556) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                    endcase
                    case(score[3:0])
                        ZERO:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 571 && counter_row_r <= 585 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 567 && counter_row_r <= 586) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 577 && counter_row_r <= 581) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 567 && counter_row_r <= 581) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 577 && counter_row_r <= 581) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 577 && counter_row_r <= 581) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;
                            end
                        end
                    endcase
                end
                //perfect
                //1
                else if (counter_column_r >= 170 && counter_column_r <= 174 ) begin
                    if(counter_row_r >= 724 && counter_row_r <= 729 || 
                       counter_row_r >= 204 && counter_row_r <= 209) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                       
                    end
                    else if(counter_row_r >= 292 && counter_row_r <= 306 ||
                       counter_row_r >= 317 && counter_row_r <= 336 ||
                       counter_row_r >= 342 && counter_row_r <= 356 ||
                       counter_row_r >= 367 && counter_row_r <= 386 ||
                       counter_row_r >= 392 && counter_row_r <= 411 ||
                       counter_row_r >= 422 && counter_row_r <= 431 ||
                       counter_row_r >= 442 && counter_row_r <= 466 
                    ) begin                   
                        VGA_R_w = 237;
                        VGA_G_w = 28;
                        VGA_B_w = 35;
                    end
                    case(perfect_score[11:8])
                        ZERO:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 524 && counter_row_r <= 528 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 527 && counter_row_r <= 531) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 517 && counter_row_r <= 536) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 517 && counter_row_r <= 531) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                    endcase
                    case(perfect_score[7:4])
                        ZERO:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 551 && counter_row_r <= 555 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 552 && counter_row_r <= 556) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 542 && counter_row_r <= 561) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 542 && counter_row_r <= 556) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                    endcase
                    case(perfect_score[3:0])
                        ZERO:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 576 && counter_row_r <= 580 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 577 && counter_row_r <= 581) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 567 && counter_row_r <= 586) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 567 && counter_row_r <= 581) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                    endcase
                end
                //2
                else if (counter_column_r >= 175 && counter_column_r <= 179 ) begin
                    if(counter_row_r >= 724 && counter_row_r <= 729 || 
                       counter_row_r >= 204 && counter_row_r <= 209) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                       
                    end
                    else if(counter_row_r >= 292 && counter_row_r <= 296 ||
                       counter_row_r >= 307 && counter_row_r <= 311 ||
                       counter_row_r >= 317 && counter_row_r <= 321 ||
                       counter_row_r >= 342 && counter_row_r <= 346 ||
                       counter_row_r >= 357 && counter_row_r <= 361 ||
                       counter_row_r >= 367 && counter_row_r <= 371 ||
                       counter_row_r >= 392 && counter_row_r <= 396 ||
                       counter_row_r >= 417 && counter_row_r <= 421 ||
                       counter_row_r >= 432 && counter_row_r <= 436 ||
                       counter_row_r >= 452 && counter_row_r <= 456 ||
                       counter_row_r >= 477 && counter_row_r <= 481
                    ) begin                   
                        VGA_R_w = 237;
                        VGA_G_w = 28;
                        VGA_B_w = 35;
                    end
                    case(perfect_score[11:8])
                        ZERO:begin
                            if(counter_row_r >= 517 && counter_row_r <= 521 ||
                               counter_row_r >= 532 && counter_row_r <= 536 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 519 && counter_row_r <= 528 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536 ||
                               counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536 ||
                               counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 517 && counter_row_r <= 521) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536 ||
                               counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536 ||
                               counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                    endcase
                    case(perfect_score[7:4])
                        ZERO:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        ONE: begin
                            if(counter_row_r >= 546 && counter_row_r <= 555 ) begin                   
                                    VGA_R_w = 237;
                                    VGA_G_w = 28;
                                    VGA_B_w = 35;
                                end
                        end
                        TWO:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 557 && counter_row_r <= 561) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                    endcase
                    case(perfect_score[3:0])
                        ZERO:begin
                            if(counter_row_r >= 567 && counter_row_r <= 571 ||
                               counter_row_r >= 582 && counter_row_r <= 586  ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 571 && counter_row_r <= 580 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586 ||
                               counter_row_r >= 567 && counter_row_r <= 571 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586 ||
                               counter_row_r >= 567 && counter_row_r <= 571 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 567 && counter_row_r <= 571) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 567 && counter_row_r <= 571) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586 ||
                               counter_row_r >= 567 && counter_row_r <= 571 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586 ||
                               counter_row_r >= 567 && counter_row_r <= 571 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                    endcase
                end
                //3
                else if (counter_column_r >= 180 && counter_column_r <= 184 ) begin
                    if(counter_row_r >= 724 && counter_row_r <= 729 || 
                       counter_row_r >= 204 && counter_row_r <= 209) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                       
                    end
                    else if(counter_row_r >= 292 && counter_row_r <= 306 ||
                       counter_row_r >= 317 && counter_row_r <= 331 ||
                       counter_row_r >= 342 && counter_row_r <= 356 ||
                       counter_row_r >= 367 && counter_row_r <= 381 ||
                       counter_row_r >= 392 && counter_row_r <= 406 ||
                       counter_row_r >= 417 && counter_row_r <= 421 ||
                       counter_row_r >= 452 && counter_row_r <= 456 
                    ) begin                   
                        VGA_R_w = 237;
                        VGA_G_w = 28;
                        VGA_B_w = 35;
                    end
                    case(perfect_score[11:8])
                        ZERO:begin
                            if(counter_row_r >= 517 && counter_row_r <= 521 ||
                               counter_row_r >= 532 && counter_row_r <= 536 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 524 && counter_row_r <= 528 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 527 && counter_row_r <= 531) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 527 && counter_row_r <= 531) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 517 && counter_row_r <= 521 ||
                               counter_row_r >= 527 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 517 && counter_row_r <= 531) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 517 && counter_row_r <= 531) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 521 && counter_row_r <= 535) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                    endcase
                    case(perfect_score[7:4])
                        ZERO:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 551 && counter_row_r <= 555 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 552 && counter_row_r <= 556) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 552 && counter_row_r <= 556) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 552 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 542 && counter_row_r <= 556) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 542 && counter_row_r <= 556) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 557 && counter_row_r <= 561) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 546 && counter_row_r <= 560) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                    endcase
                    case(perfect_score[3:0])
                        ZERO:begin
                            if(counter_row_r >= 567 && counter_row_r <= 571 ||
                               counter_row_r >= 582 && counter_row_r <= 586  ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 576 && counter_row_r <= 580 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 577 && counter_row_r <= 581) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 577 && counter_row_r <= 581) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 567 && counter_row_r <= 571 ||
                               counter_row_r >= 577 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 567 && counter_row_r <= 581) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 567 && counter_row_r <= 581) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 571 && counter_row_r <= 585) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                    endcase
                end
                //4
                else if (counter_column_r >= 185 && counter_column_r <= 190 ) begin
                    if(counter_row_r >= 724 && counter_row_r <= 729 || 
                       counter_row_r >= 204 && counter_row_r <= 209) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                       
                    end
                    else if(counter_row_r >= 292 && counter_row_r <= 296 ||
                       counter_row_r >= 317 && counter_row_r <= 321 ||
                       counter_row_r >= 342 && counter_row_r <= 346 ||
                       counter_row_r >= 352 && counter_row_r <= 356 ||
                       counter_row_r >= 367 && counter_row_r <= 371 ||
                       counter_row_r >= 392 && counter_row_r <= 396 ||
                       counter_row_r >= 417 && counter_row_r <= 421 ||
                       counter_row_r >= 432 && counter_row_r <= 436 ||
                       counter_row_r >= 452 && counter_row_r <= 456 ||
                       counter_row_r >= 477 && counter_row_r <= 481 
                    ) begin                   
                        VGA_R_w = 237;
                        VGA_G_w = 28;
                        VGA_B_w = 35;
                    end
                    case(perfect_score[11:8])
                        ZERO:begin
                            if(counter_row_r >= 517 && counter_row_r <= 521 ||
                               counter_row_r >= 532 && counter_row_r <= 536 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 524 && counter_row_r <= 528 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 522 && counter_row_r <= 526) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536 ||
                               counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 517 && counter_row_r <= 536) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536 ||
                               counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 527 && counter_row_r <= 531) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536 ||
                               counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                    endcase
                    case(perfect_score[7:4])
                        ZERO:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 551 && counter_row_r <= 555 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 547 && counter_row_r <= 551) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 542 && counter_row_r <= 561) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 557 && counter_row_r <= 561) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 552 && counter_row_r <= 556) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 557 && counter_row_r <= 561) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                    endcase
                    case(perfect_score[3:0])
                        ZERO:begin
                            if(counter_row_r >= 567 && counter_row_r <= 571 ||
                               counter_row_r >= 582 && counter_row_r <= 586  ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 576 && counter_row_r <= 580 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 572 && counter_row_r <= 576) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586 ||
                               counter_row_r >= 567 && counter_row_r <= 571 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 567 && counter_row_r <= 586) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586 ||
                               counter_row_r >= 567 && counter_row_r <= 571 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 577 && counter_row_r <= 581) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586 ||
                               counter_row_r >= 567 && counter_row_r <= 571 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                    endcase
                end
                //5
                else if (counter_column_r >= 191 && counter_column_r <= 194 ) begin
                    if(counter_row_r >= 724 && counter_row_r <= 729 || 
                       counter_row_r >= 204 && counter_row_r <= 209) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                       
                    end
                    else if(counter_row_r >= 292 && counter_row_r <= 296 ||
                       counter_row_r >= 317 && counter_row_r <= 336 ||
                       counter_row_r >= 342 && counter_row_r <= 346 ||
                       counter_row_r >= 357 && counter_row_r <= 361 ||
                       counter_row_r >= 367 && counter_row_r <= 371 ||
                       counter_row_r >= 392 && counter_row_r <= 411 ||
                       counter_row_r >= 422 && counter_row_r <= 431 ||
                       counter_row_r >= 452 && counter_row_r <= 456 
                    ) begin                   
                        VGA_R_w = 237;
                        VGA_G_w = 28;
                        VGA_B_w = 35;
                    end
                    case(perfect_score[11:8])
                        ZERO:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 519 && counter_row_r <= 533 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 517 && counter_row_r <= 536) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 527 && counter_row_r <= 531) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 517 && counter_row_r <= 531) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 527 && counter_row_r <= 531) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 527 && counter_row_r <= 531) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                    endcase
                    case(perfect_score[7:4])
                        ZERO:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 546 && counter_row_r <= 560 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 542 && counter_row_r <= 561) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 552 && counter_row_r <= 556) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 542 && counter_row_r <= 556) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 552 && counter_row_r <= 556) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 552 && counter_row_r <= 556) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                    endcase
                    case(perfect_score[3:0])
                        ZERO:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 571 && counter_row_r <= 585 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 567 && counter_row_r <= 586) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 577 && counter_row_r <= 581) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 567 && counter_row_r <= 581) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 577 && counter_row_r <= 581) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 577 && counter_row_r <= 581) begin                   
                                VGA_R_w = 237;
                                VGA_G_w = 28;
                                VGA_B_w = 35;
                            end
                        end
                    endcase
                end
                //good
                //1
                else if (counter_column_r >= 208 && counter_column_r <= 212 ) begin
                    if(counter_row_r >= 724 && counter_row_r <= 729 || 
                       counter_row_r >= 204 && counter_row_r <= 209) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                       
                    end
                    else if(counter_row_r >= 377 && counter_row_r <= 386 ||
                       counter_row_r >= 402 && counter_row_r <= 411 ||
                       counter_row_r >= 427 && counter_row_r <= 436 ||
                       counter_row_r >= 447 && counter_row_r <= 461 
                    ) begin                   
                        VGA_R_w = 0;
                        VGA_G_w = 183;
                        VGA_B_w = 239;
                    end
                    case(good_score[11:8])
                        ZERO:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 524 && counter_row_r <= 528 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 527 && counter_row_r <= 531) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 517 && counter_row_r <= 536) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 517 && counter_row_r <= 531) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                    endcase
                    case(good_score[7:4])
                        ZERO:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 551 && counter_row_r <= 555 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 552 && counter_row_r <= 556) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 542 && counter_row_r <= 561) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 542 && counter_row_r <= 556) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                    endcase
                    case(good_score[3:0])
                        ZERO:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 576 && counter_row_r <= 580 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 577 && counter_row_r <= 581) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 567 && counter_row_r <= 586) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 567 && counter_row_r <= 581) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                    endcase
                end
                //2
                else if (counter_column_r >= 213 && counter_column_r <= 217 ) begin
                    if(counter_row_r >= 724 && counter_row_r <= 729 || 
                       counter_row_r >= 204 && counter_row_r <= 209) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                       
                    end
                    else if(counter_row_r >= 372 && counter_row_r <= 376 ||
                       counter_row_r >= 397 && counter_row_r <= 401 ||
                       counter_row_r >= 412 && counter_row_r <= 416 ||
                       counter_row_r >= 422 && counter_row_r <= 426 ||
                       counter_row_r >= 437 && counter_row_r <= 441 ||
                       counter_row_r >= 447 && counter_row_r <= 451 ||
                       counter_row_r >= 462 && counter_row_r <= 466 ||
                       counter_row_r >= 477 && counter_row_r <= 481 
                    ) begin                   
                        VGA_R_w = 0;
                        VGA_G_w = 183;
                        VGA_B_w = 239;
                    end
                    case(good_score[11:8])
                        ZERO:begin
                            if(counter_row_r >= 517 && counter_row_r <= 521 ||
                               counter_row_r >= 532 && counter_row_r <= 536 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 519 && counter_row_r <= 528 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536 ||
                               counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536 ||
                               counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 517 && counter_row_r <= 521) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536 ||
                               counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536 ||
                               counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                    endcase
                    case(good_score[7:4])
                        ZERO:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 546 && counter_row_r <= 555 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 557 && counter_row_r <= 561) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                    endcase
                    case(good_score[3:0])
                        ZERO:begin
                            if(counter_row_r >= 567 && counter_row_r <= 571 ||
                               counter_row_r >= 582 && counter_row_r <= 586  ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 571 && counter_row_r <= 580 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586 ||
                               counter_row_r >= 567 && counter_row_r <= 571 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586 ||
                               counter_row_r >= 567 && counter_row_r <= 571 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 567 && counter_row_r <= 571) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 567 && counter_row_r <= 571) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586 ||
                               counter_row_r >= 567 && counter_row_r <= 571 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586 ||
                               counter_row_r >= 567 && counter_row_r <= 571 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                    endcase
                end
                //3
                else if (counter_column_r >= 218 && counter_column_r <= 222 ) begin
                    if(counter_row_r >= 724 && counter_row_r <= 729 || 
                       counter_row_r >= 204 && counter_row_r <= 209) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                       
                    end
                    else if(counter_row_r >= 372 && counter_row_r <= 376 ||
                       counter_row_r >= 382 && counter_row_r <= 391 ||
                       counter_row_r >= 397 && counter_row_r <= 401 ||
                       counter_row_r >= 412 && counter_row_r <= 416 ||
                       counter_row_r >= 422 && counter_row_r <= 426 ||
                       counter_row_r >= 437 && counter_row_r <= 441 ||
                       counter_row_r >= 447 && counter_row_r <= 451 ||
                       counter_row_r >= 462 && counter_row_r <= 466 
                    ) begin                   
                        VGA_R_w = 0;
                        VGA_G_w = 183;
                        VGA_B_w = 239;
                    end
                    case(good_score[11:8])
                        ZERO:begin
                            if(counter_row_r >= 517 && counter_row_r <= 521 ||
                               counter_row_r >= 532 && counter_row_r <= 536 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 524 && counter_row_r <= 528 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 527 && counter_row_r <= 531) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 527 && counter_row_r <= 531) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 517 && counter_row_r <= 521 ||
                               counter_row_r >= 527 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 517 && counter_row_r <= 531) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 517 && counter_row_r <= 531) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 521 && counter_row_r <= 535) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                    endcase
                    case(good_score[7:4])
                        ZERO:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 551 && counter_row_r <= 555 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 552 && counter_row_r <= 556) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 552 && counter_row_r <= 556) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 552 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 542 && counter_row_r <= 556) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 542 && counter_row_r <= 556) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 557 && counter_row_r <= 561) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 546 && counter_row_r <= 560) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                    endcase
                    case(good_score[3:0])
                        ZERO:begin
                            if(counter_row_r >= 567 && counter_row_r <= 571 ||
                               counter_row_r >= 582 && counter_row_r <= 586  ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 576 && counter_row_r <= 580 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 577 && counter_row_r <= 581) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 577 && counter_row_r <= 581) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 567 && counter_row_r <= 571 ||
                               counter_row_r >= 577 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 567 && counter_row_r <= 581) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 567 && counter_row_r <= 581) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 571 && counter_row_r <= 585) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                    endcase
                end
                //4
                else if (counter_column_r >= 223 && counter_column_r <= 227 ) begin
                    if(counter_row_r >= 724 && counter_row_r <= 729 || 
                       counter_row_r >= 204 && counter_row_r <= 209) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                       
                    end
                    else if(counter_row_r >= 372 && counter_row_r <= 376 ||
                       counter_row_r >= 387 && counter_row_r <= 391 ||
                       counter_row_r >= 397 && counter_row_r <= 401 ||
                       counter_row_r >= 412 && counter_row_r <= 416 ||
                       counter_row_r >= 422 && counter_row_r <= 426 ||
                       counter_row_r >= 437 && counter_row_r <= 441 ||
                       counter_row_r >= 447 && counter_row_r <= 451 ||
                       counter_row_r >= 462 && counter_row_r <= 466 ||
                       counter_row_r >= 477 && counter_row_r <= 481 
                    ) begin                   
                        VGA_R_w = 0;
                        VGA_G_w = 183;
                        VGA_B_w = 239;
                    end
                    case(good_score[11:8])
                        ZERO:begin
                            if(counter_row_r >= 517 && counter_row_r <= 521 ||
                               counter_row_r >= 532 && counter_row_r <= 536 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 524 && counter_row_r <= 528 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 522 && counter_row_r <= 526) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536 ||
                               counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 517 && counter_row_r <= 536) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536 ||
                               counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 527 && counter_row_r <= 531) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536 ||
                               counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                    endcase
                    case(good_score[7:4])
                        ZERO:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 551 && counter_row_r <= 555 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 547 && counter_row_r <= 551) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 542 && counter_row_r <= 561) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 557 && counter_row_r <= 561) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 552 && counter_row_r <= 556) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 557 && counter_row_r <= 561) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                    endcase
                    case(good_score[3:0])
                        ZERO:begin
                            if(counter_row_r >= 567 && counter_row_r <= 571 ||
                               counter_row_r >= 582 && counter_row_r <= 586  ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 576 && counter_row_r <= 580 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 572 && counter_row_r <= 576) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586 ||
                               counter_row_r >= 567 && counter_row_r <= 571 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 567 && counter_row_r <= 586) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586 ||
                               counter_row_r >= 567 && counter_row_r <= 571 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 577 && counter_row_r <= 581) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586 ||
                               counter_row_r >= 567 && counter_row_r <= 571 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                    endcase
                end
                //5
                else if (counter_column_r >= 228 && counter_column_r <= 232 ) begin
                    if(counter_row_r >= 724 && counter_row_r <= 729 || 
                       counter_row_r >= 204 && counter_row_r <= 209) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                       
                    end
                    else if(counter_row_r >= 377 && counter_row_r <= 386 ||
                       counter_row_r >= 387 && counter_row_r <= 376 ||
                       counter_row_r >= 402 && counter_row_r <= 411 ||
                       counter_row_r >= 427 && counter_row_r <= 436 ||
                       counter_row_r >= 447 && counter_row_r <= 461 
                    ) begin                   
                        VGA_R_w = 0;
                        VGA_G_w = 183;
                        VGA_B_w = 239;
                    end
                    case(good_score[11:8])
                        ZERO:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 519 && counter_row_r <= 533 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 517 && counter_row_r <= 536) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 527 && counter_row_r <= 531) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 517 && counter_row_r <= 531) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 527 && counter_row_r <= 531) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 527 && counter_row_r <= 531) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                    endcase
                    case(good_score[7:4])
                        ZERO:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 546 && counter_row_r <= 560 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 542 && counter_row_r <= 561) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 552 && counter_row_r <= 556) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 542 && counter_row_r <= 556) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 552 && counter_row_r <= 556) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 552 && counter_row_r <= 556) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                    endcase
                    case(good_score[3:0])
                        ZERO:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 571 && counter_row_r <= 585 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 567 && counter_row_r <= 586) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 577 && counter_row_r <= 581) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 567 && counter_row_r <= 581) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 577 && counter_row_r <= 581) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 577 && counter_row_r <= 581) begin                   
                                VGA_R_w = 0;
                                VGA_G_w = 183;
                                VGA_B_w = 239;
                            end
                        end
                    endcase
                end
                //Miss
                //1
                else if (counter_column_r >= 244 && counter_column_r <= 248 ) begin
                    if(counter_row_r >= 724 && counter_row_r <= 729 || 
                       counter_row_r >= 204 && counter_row_r <= 209) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                       
                    end
                    else if(counter_row_r >= 372 && counter_row_r <= 376 ||
                       counter_row_r >= 392 && counter_row_r <= 396 ||
                       counter_row_r >= 402 && counter_row_r <= 416 ||
                       counter_row_r >= 427 && counter_row_r <= 441 ||
                       counter_row_r >= 452 && counter_row_r <= 466 
                    ) begin                   
                        VGA_R_w = 34;
                        VGA_G_w = 177;
                        VGA_B_w = 77;
                    end

                    case(miss_score[11:8])
                        ZERO:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 524 && counter_row_r <= 528 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 527 && counter_row_r <= 531) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 517 && counter_row_r <= 536) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 517 && counter_row_r <= 531) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                    endcase
                    case(miss_score[7:4])
                        ZERO:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 551 && counter_row_r <= 555 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 552 && counter_row_r <= 556) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 542 && counter_row_r <= 561) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 542 && counter_row_r <= 556) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                    endcase
                    case(miss_score[3:0])
                        ZERO:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 576 && counter_row_r <= 580 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 577 && counter_row_r <= 581) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 567 && counter_row_r <= 586) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 567 && counter_row_r <= 581) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                    endcase
                end
                //2
                else if (counter_column_r >= 249 && counter_column_r <= 253 ) begin
                    if(counter_row_r >= 724 && counter_row_r <= 729 || 
                       counter_row_r >= 204 && counter_row_r <= 209) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                       
                    end
                    else if(counter_row_r >= 372 && counter_row_r <= 381 ||
                       counter_row_r >= 387 && counter_row_r <= 396 ||
                       counter_row_r >= 407 && counter_row_r <= 411 ||
                       counter_row_r >= 422 && counter_row_r <= 426 ||
                       counter_row_r >= 447 && counter_row_r <= 451 ||
                       counter_row_r >= 477 && counter_row_r <= 481
                    ) begin                   
                        VGA_R_w = 34;
                        VGA_G_w = 177;
                        VGA_B_w = 77;
                    end
                    case(miss_score[11:8])
                        ZERO:begin
                            if(counter_row_r >= 517 && counter_row_r <= 521 ||
                               counter_row_r >= 532 && counter_row_r <= 536 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 519 && counter_row_r <= 528 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536 ||
                               counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536 ||
                               counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 517 && counter_row_r <= 521) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536 ||
                               counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536 ||
                               counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                    endcase
                    case(miss_score[7:4])
                        ZERO:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 546 && counter_row_r <= 555 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 557 && counter_row_r <= 561) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        
                    endcase
                    case(miss_score[3:0])
                        ZERO:begin
                            if(counter_row_r >= 567 && counter_row_r <= 571 ||
                               counter_row_r >= 582 && counter_row_r <= 586  ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 571 && counter_row_r <= 580 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586 ||
                               counter_row_r >= 567 && counter_row_r <= 571 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586 ||
                               counter_row_r >= 567 && counter_row_r <= 571 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 567 && counter_row_r <= 571) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 567 && counter_row_r <= 571) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586 ||
                               counter_row_r >= 567 && counter_row_r <= 571 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586 ||
                               counter_row_r >= 567 && counter_row_r <= 571 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                    endcase
                end
                //3
                else if (counter_column_r >= 254 && counter_column_r <= 258 ) begin
                    if(counter_row_r >= 724 && counter_row_r <= 729 || 
                       counter_row_r >= 204 && counter_row_r <= 209) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                       
                    end
                    else if(counter_row_r >= 372 && counter_row_r <= 376 ||
                       counter_row_r >= 392 && counter_row_r <= 396 ||
                       counter_row_r >= 382 && counter_row_r <= 386 ||
                       counter_row_r >= 407 && counter_row_r <= 411 ||
                       counter_row_r >= 427 && counter_row_r <= 436 ||
                       counter_row_r >= 452 && counter_row_r <= 461 
                    ) begin                   
                        VGA_R_w = 34;
                        VGA_G_w = 177;
                        VGA_B_w = 77;
                    end
                    case(miss_score[11:8])
                        ZERO:begin
                            if(counter_row_r >= 517 && counter_row_r <= 521 ||
                               counter_row_r >= 532 && counter_row_r <= 536 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 524 && counter_row_r <= 528 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 527 && counter_row_r <= 531) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 527 && counter_row_r <= 531) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 517 && counter_row_r <= 521 ||
                               counter_row_r >= 527 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 517 && counter_row_r <= 531) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 517 && counter_row_r <= 531) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 521 && counter_row_r <= 535) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                    endcase
                    case(miss_score[7:4])
                        ZERO:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 551 && counter_row_r <= 555 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 552 && counter_row_r <= 556) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 552 && counter_row_r <= 556) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 552 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 542 && counter_row_r <= 556) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 542 && counter_row_r <= 556) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 557 && counter_row_r <= 561) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 546 && counter_row_r <= 560) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                    endcase
                    case(miss_score[3:0])
                        ZERO:begin
                            if(counter_row_r >= 567 && counter_row_r <= 571 ||
                               counter_row_r >= 582 && counter_row_r <= 586  ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 576 && counter_row_r <= 580 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 577 && counter_row_r <= 581) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 577 && counter_row_r <= 581) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 567 && counter_row_r <= 571 ||
                               counter_row_r >= 577 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 567 && counter_row_r <= 581) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 567 && counter_row_r <= 581) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 571 && counter_row_r <= 585) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                    endcase
                end
                //4
                else if (counter_column_r >= 259 && counter_column_r <= 263 ) begin
                    if(counter_row_r >= 724 && counter_row_r <= 729 || 
                       counter_row_r >= 204 && counter_row_r <= 209) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                       
                    end
                    else if(counter_row_r >= 372 && counter_row_r <= 376 ||
                       counter_row_r >= 392 && counter_row_r <= 396 ||
                       counter_row_r >= 407 && counter_row_r <= 411 ||
                       counter_row_r >= 437 && counter_row_r <= 441 ||
                       counter_row_r >= 462 && counter_row_r <= 466 ||
                       counter_row_r >= 477 && counter_row_r <= 481 
                    ) begin                   
                        VGA_R_w = 34;
                        VGA_G_w = 177;
                        VGA_B_w = 77;
                    end
                    case(miss_score[11:8])
                        ZERO:begin
                            if(counter_row_r >= 517 && counter_row_r <= 521 ||
                               counter_row_r >= 532 && counter_row_r <= 536 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 524 && counter_row_r <= 528 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 522 && counter_row_r <= 526) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536 ||
                               counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 517 && counter_row_r <= 536) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536 ||
                               counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 527 && counter_row_r <= 531) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536 ||
                               counter_row_r >= 517 && counter_row_r <= 521 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 532 && counter_row_r <= 536) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                    endcase
                    case(miss_score[7:4])
                        ZERO:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 551 && counter_row_r <= 555 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 547 && counter_row_r <= 551) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 542 && counter_row_r <= 561) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 557 && counter_row_r <= 561) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 552 && counter_row_r <= 556) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 542 && counter_row_r <= 546 ||
                               counter_row_r >= 557 && counter_row_r <= 561 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 557 && counter_row_r <= 561) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                    endcase
                    case(miss_score[3:0])
                        ZERO:begin
                            if(counter_row_r >= 567 && counter_row_r <= 571 ||
                               counter_row_r >= 582 && counter_row_r <= 586  ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 576 && counter_row_r <= 580 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 572 && counter_row_r <= 576) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586 ||
                               counter_row_r >= 567 && counter_row_r <= 571 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 567 && counter_row_r <= 586) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586 ||
                               counter_row_r >= 567 && counter_row_r <= 571 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 577 && counter_row_r <= 581) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586 ||
                               counter_row_r >= 567 && counter_row_r <= 571 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 582 && counter_row_r <= 586) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                    endcase
                end
                //5
                else if (counter_column_r >= 264 && counter_column_r <= 268 ) begin
                    if(counter_row_r >= 724 && counter_row_r <= 729 || 
                       counter_row_r >= 204 && counter_row_r <= 209) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;
                       
                    end
                    else if(counter_row_r >= 372 && counter_row_r <= 376 ||
                       counter_row_r >= 392 && counter_row_r <= 396 ||
                       counter_row_r >= 402 && counter_row_r <= 416 ||
                       counter_row_r >= 422 && counter_row_r <= 436 ||
                       counter_row_r >= 447 && counter_row_r <= 461 
                    ) begin                   
                        VGA_R_w = 34;
                        VGA_G_w = 177;
                        VGA_B_w = 77;
                    end
                    
                    case(miss_score[11:8])
                        ZERO:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 519 && counter_row_r <= 533 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 517 && counter_row_r <= 536) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 527 && counter_row_r <= 531) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 517 && counter_row_r <= 531) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 527 && counter_row_r <= 531) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 522 && counter_row_r <= 531 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 527 && counter_row_r <= 531) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                    endcase
                    case(miss_score[7:4])
                        ZERO:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 546 && counter_row_r <= 560 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 542 && counter_row_r <= 561) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 552 && counter_row_r <= 556) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 542 && counter_row_r <= 556) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 552 && counter_row_r <= 556) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 547 && counter_row_r <= 556 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 552 && counter_row_r <= 556) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                    endcase
                    case(miss_score[3:0])
                        ZERO:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        ONE:begin
                            if(counter_row_r >= 571 && counter_row_r <= 585 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        TWO:begin
                            if(counter_row_r >= 567 && counter_row_r <= 586) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        THREE:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FOUR:begin
                            if(counter_row_r >= 577 && counter_row_r <= 581) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        FIVE:begin
                            if(counter_row_r >= 567 && counter_row_r <= 581) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SIX:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        SEVEN:begin
                            if(counter_row_r >= 577 && counter_row_r <= 581) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        EIGHT:begin
                            if(counter_row_r >= 572 && counter_row_r <= 581 ) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                        NINE:begin
                            if(counter_row_r >= 577 && counter_row_r <= 581) begin                   
                                VGA_R_w = 34;
                                VGA_G_w = 177;
                                VGA_B_w = 77;
                            end
                        end
                    endcase
                end
            
                else begin
                    VGA_R_w = 255;
                    VGA_G_w = 255;
                    VGA_B_w = 255;
                end
            end

            play:begin
                //score
                //1
                if((counter_column_r >= 167 && counter_column_r <= 171) &&
                   (counter_row_r >= 525 && counter_row_r <= 539 ||
                    counter_row_r >= 550 && counter_row_r <= 559 ||
                    counter_row_r >= 575 && counter_row_r <= 584 || 
                    counter_row_r >= 595 && counter_row_r <= 609 ||  
                    counter_row_r >= 620 && counter_row_r <= 639    
                )) begin                     
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;           
                end
                //2
                if((counter_column_r >= 172 && counter_column_r <= 176) &&
                   (counter_row_r >= 520 && counter_row_r <= 524 ||
                    counter_row_r >= 545 && counter_row_r <= 549 ||
                    counter_row_r >= 560 && counter_row_r <= 564 ||
                    counter_row_r >= 570 && counter_row_r <= 574 ||
                    counter_row_r >= 585 && counter_row_r <= 589 ||  
                    counter_row_r >= 595 && counter_row_r <= 599 ||  
                    counter_row_r >= 610 && counter_row_r <= 614 || 
                    counter_row_r >= 620 && counter_row_r <= 624 || 
                    counter_row_r >= 650 && counter_row_r <= 654         
                )) begin                     
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;           
                end
                //3
                if((counter_column_r >= 177 && counter_column_r <= 181) &&
                   (counter_row_r >= 525 && counter_row_r <= 534 ||
                    counter_row_r >= 545 && counter_row_r <= 549 ||
                    counter_row_r >= 570 && counter_row_r <= 574 ||
                    counter_row_r >= 585 && counter_row_r <= 589 ||  
                    counter_row_r >= 595 && counter_row_r <= 609 || 
                    counter_row_r >= 620 && counter_row_r <= 634     
                )) begin                     
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;           
                end
                //4
                if((counter_column_r >= 182 && counter_column_r <= 186) &&
                   (counter_row_r >= 535 && counter_row_r <= 539 ||
                    counter_row_r >= 545 && counter_row_r <= 549 ||
                    counter_row_r >= 560 && counter_row_r <= 564 ||
                    counter_row_r >= 570 && counter_row_r <= 574 ||
                    counter_row_r >= 585 && counter_row_r <= 589 ||  
                    counter_row_r >= 595 && counter_row_r <= 599 ||
                    counter_row_r >= 605 && counter_row_r <= 609 ||  
                    counter_row_r >= 620 && counter_row_r <= 624 ||
                    counter_row_r >= 650 && counter_row_r <= 654         
                )) begin                     
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;           
                end
                //5
                if((counter_column_r >= 187 && counter_column_r <= 191) &&
                   (counter_row_r >= 520 && counter_row_r <= 534 ||
                    counter_row_r >= 550 && counter_row_r <= 559 ||
                    counter_row_r >= 575 && counter_row_r <= 584 || 
                    counter_row_r >= 595 && counter_row_r <= 599 || 
                    counter_row_r >= 610 && counter_row_r <= 614 ||    
                    counter_row_r >= 620 && counter_row_r <= 639   
                )) begin                     
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;           
                end
                //score number
                case(score[15:12])
                    ZERO:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 670 && counter_row_r <= 679 
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 665 && counter_row_r <= 669 ||
                            counter_row_r >= 680 && counter_row_r <= 684 
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 665 && counter_row_r <= 669 ||
                            counter_row_r >= 680 && counter_row_r <= 684 
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 665 && counter_row_r <= 669 ||
                            counter_row_r >= 680 && counter_row_r <= 684       
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 670 && counter_row_r <= 679 
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    ONE:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 673 && counter_row_r <= 677
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 668 && counter_row_r <= 677
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 673 && counter_row_r <= 677
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 673 && counter_row_r <= 677    
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 668 && counter_row_r <= 682
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    TWO:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 670 && counter_row_r <= 679
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 665 && counter_row_r <= 669 ||
                            counter_row_r >= 680 && counter_row_r <= 684
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 675 && counter_row_r <= 679
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 670 && counter_row_r <= 674    
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 665 && counter_row_r <= 684
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    THREE:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 670 && counter_row_r <= 679
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 665 && counter_row_r <= 669 ||
                            counter_row_r >= 680 && counter_row_r <= 684
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 675 && counter_row_r <= 679
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 665 && counter_row_r <= 669 ||
                            counter_row_r >= 680 && counter_row_r <= 684   
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 670 && counter_row_r <= 679
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    FOUR:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 675 && counter_row_r <= 679
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 670 && counter_row_r <= 679 
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 675 && counter_row_r <= 679 ||
                            counter_row_r >= 665 && counter_row_r <= 669
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 665 && counter_row_r <= 684   
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 675 && counter_row_r <= 679
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    FIVE:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 665 && counter_row_r <= 684
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 665 && counter_row_r <= 669 
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 665 && counter_row_r <= 679
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 680 && counter_row_r <= 684   
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 665 && counter_row_r <= 679
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    SIX:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 670 && counter_row_r <= 679
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 665 && counter_row_r <= 669 
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 665 && counter_row_r <= 679
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 665 && counter_row_r <= 669 ||
                            counter_row_r >= 680 && counter_row_r <= 684   
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 670 && counter_row_r <= 679
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    SEVEN:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 665 && counter_row_r <= 679
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 680 && counter_row_r <= 684 
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 680 && counter_row_r <= 684 
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 675 && counter_row_r <= 679 
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 675 && counter_row_r <= 679
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    EIGHT:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 670 && counter_row_r <= 679
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 665 && counter_row_r <= 669 ||
                            counter_row_r >= 680 && counter_row_r <= 684
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 670 && counter_row_r <= 679
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 665 && counter_row_r <= 669 ||
                            counter_row_r >= 680 && counter_row_r <= 684   
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 670 && counter_row_r <= 679
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    NINE:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 670 && counter_row_r <= 679
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 665 && counter_row_r <= 669 ||
                            counter_row_r >= 680 && counter_row_r <= 684
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 670 && counter_row_r <= 684
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 680 && counter_row_r <= 684   
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 675 && counter_row_r <= 679
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                endcase
                case(score[11:8])
                    ZERO:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 695 && counter_row_r <= 704
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 690 && counter_row_r <= 694 ||
                            counter_row_r >= 705 && counter_row_r <= 709 
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 690 && counter_row_r <= 694 ||
                            counter_row_r >= 705 && counter_row_r <= 709 
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 690 && counter_row_r <= 694 ||
                            counter_row_r >= 705 && counter_row_r <= 709 
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 695 && counter_row_r <= 704
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    ONE:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 698 && counter_row_r <= 702
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 693 && counter_row_r <= 702
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 698 && counter_row_r <= 702
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 698 && counter_row_r <= 702   
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 693 && counter_row_r <= 707
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    TWO:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 695 && counter_row_r <= 704
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 690 && counter_row_r <= 694 ||
                            counter_row_r >= 705 && counter_row_r <= 709
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 700 && counter_row_r <= 704
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 695 && counter_row_r <= 699   
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 690 && counter_row_r <= 709
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    THREE:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 695 && counter_row_r <= 704
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 690 && counter_row_r <= 694 ||
                            counter_row_r >= 705 && counter_row_r <= 709
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 700 && counter_row_r <= 704
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 690 && counter_row_r <= 694 ||
                            counter_row_r >= 705 && counter_row_r <= 709
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 695 && counter_row_r <= 704
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    FOUR:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 700 && counter_row_r <= 704
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 695 && counter_row_r <= 704
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 700 && counter_row_r <= 704 ||
                            counter_row_r >= 690 && counter_row_r <= 694
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 690 && counter_row_r <= 709  
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 700 && counter_row_r <= 704
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    FIVE:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 690 && counter_row_r <= 709
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 690 && counter_row_r <= 694
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 690 && counter_row_r <= 704
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 705 && counter_row_r <= 709
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 690 && counter_row_r <= 704
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    SIX:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 695 && counter_row_r <= 704
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 690 && counter_row_r <= 694 
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 690 && counter_row_r <= 704
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 690 && counter_row_r <= 694 ||
                            counter_row_r >= 705 && counter_row_r <= 709   
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 695 && counter_row_r <= 704
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    SEVEN:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 690 && counter_row_r <= 704
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 705 && counter_row_r <= 709
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 705 && counter_row_r <= 709
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 700 && counter_row_r <= 704
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 700 && counter_row_r <= 704
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    EIGHT:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 695 && counter_row_r <= 704
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 690 && counter_row_r <= 694 ||
                            counter_row_r >= 705 && counter_row_r <= 709
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 695 && counter_row_r <= 704
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 690 && counter_row_r <= 694 ||
                            counter_row_r >= 705 && counter_row_r <= 709
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 695 && counter_row_r <= 704
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    NINE:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 695 && counter_row_r <= 704
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 690 && counter_row_r <= 694 ||
                            counter_row_r >= 705 && counter_row_r <= 709
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 695 && counter_row_r <= 709
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 705 && counter_row_r <= 709  
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 700 && counter_row_r <= 704
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                endcase
                case(score[7:4])
                    ZERO:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 720 && counter_row_r <= 729
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 715 && counter_row_r <= 719 ||
                            counter_row_r >= 730 && counter_row_r <= 734 
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 715 && counter_row_r <= 719 ||
                            counter_row_r >= 730 && counter_row_r <= 734 
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 715 && counter_row_r <= 719 ||
                            counter_row_r >= 730 && counter_row_r <= 734 
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 720 && counter_row_r <= 729
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    ONE:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 723 && counter_row_r <= 727
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 718 && counter_row_r <= 727
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 723 && counter_row_r <= 727
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 723 && counter_row_r <= 727 
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 718 && counter_row_r <= 732
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    TWO:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 720 && counter_row_r <= 729
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 715 && counter_row_r <= 719 ||
                            counter_row_r >= 730 && counter_row_r <= 734
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 725 && counter_row_r <= 729
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 720 && counter_row_r <= 724  
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 715 && counter_row_r <= 734
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    THREE:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 720 && counter_row_r <= 729
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 715 && counter_row_r <= 719 ||
                            counter_row_r >= 730 && counter_row_r <= 734
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 725 && counter_row_r <= 729
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 715 && counter_row_r <= 719 ||
                            counter_row_r >= 730 && counter_row_r <= 734
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 720 && counter_row_r <= 729
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    FOUR:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 725 && counter_row_r <= 729
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 720 && counter_row_r <= 729
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 725 && counter_row_r <= 729 ||
                            counter_row_r >= 715 && counter_row_r <= 719
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 715 && counter_row_r <= 734  
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 725 && counter_row_r <= 729
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    FIVE:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 715 && counter_row_r <= 734
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 715 && counter_row_r <= 719
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 715 && counter_row_r <= 729
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 730 && counter_row_r <= 734
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 715 && counter_row_r <= 729
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    SIX:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 720 && counter_row_r <= 729
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 715 && counter_row_r <= 719 
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 715 && counter_row_r <= 729
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 715 && counter_row_r <= 719 ||
                            counter_row_r >= 730 && counter_row_r <= 734   
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 720 && counter_row_r <= 729
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    SEVEN:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 715 && counter_row_r <= 729
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 730 && counter_row_r <= 734
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 730 && counter_row_r <= 734
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 725 && counter_row_r <= 729
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 725 && counter_row_r <= 729
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    EIGHT:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 720 && counter_row_r <= 729
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 715 && counter_row_r <= 719 ||
                            counter_row_r >= 730 && counter_row_r <= 734
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 720 && counter_row_r <= 729
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 715 && counter_row_r <= 719 ||
                            counter_row_r >= 730 && counter_row_r <= 734
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 720 && counter_row_r <= 729
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    NINE:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 720 && counter_row_r <= 729
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 715 && counter_row_r <= 719 ||
                            counter_row_r >= 730 && counter_row_r <= 734
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 720 && counter_row_r <= 734
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 730 && counter_row_r <= 734  
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 725 && counter_row_r <= 729
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                endcase
                case(score[3:0])
                    ZERO:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 745 && counter_row_r <= 754
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 740 && counter_row_r <= 744 ||
                            counter_row_r >= 755 && counter_row_r <= 759 
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 740 && counter_row_r <= 744 ||
                            counter_row_r >= 755 && counter_row_r <= 759 
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 740 && counter_row_r <= 744 ||
                            counter_row_r >= 755 && counter_row_r <= 759 
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 745 && counter_row_r <= 754
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    ONE:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 748 && counter_row_r <= 752
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 743 && counter_row_r <= 752
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 748 && counter_row_r <= 752
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 748 && counter_row_r <= 752 
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 743 && counter_row_r <= 757
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    TWO:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 745 && counter_row_r <= 754
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 740 && counter_row_r <= 744 ||
                            counter_row_r >= 755 && counter_row_r <= 759
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 750 && counter_row_r <= 754
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 745 && counter_row_r <= 749 
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 740 && counter_row_r <= 759
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    THREE:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 745 && counter_row_r <= 754
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 740 && counter_row_r <= 744 ||
                            counter_row_r >= 755 && counter_row_r <= 759
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 750 && counter_row_r <= 754
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 740 && counter_row_r <= 744 ||
                            counter_row_r >= 755 && counter_row_r <= 759
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 745 && counter_row_r <= 754
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    FOUR:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 750 && counter_row_r <= 754
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 745 && counter_row_r <= 754
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 750 && counter_row_r <= 754 ||
                            counter_row_r >= 740 && counter_row_r <= 744
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 740 && counter_row_r <= 759  
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 750 && counter_row_r <= 754
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    FIVE:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 740 && counter_row_r <= 759
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 740 && counter_row_r <= 744
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 740 && counter_row_r <= 754
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 755 && counter_row_r <= 759
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 740 && counter_row_r <= 754
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    SIX:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 745 && counter_row_r <= 754
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 740 && counter_row_r <= 744
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 740 && counter_row_r <= 754
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 740 && counter_row_r <= 744 ||
                            counter_row_r >= 755 && counter_row_r <= 759   
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 745 && counter_row_r <= 754
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    SEVEN:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 740 && counter_row_r <= 754
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 755 && counter_row_r <= 759
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 755 && counter_row_r <= 759
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 750 && counter_row_r <= 754
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 750 && counter_row_r <= 754
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    EIGHT:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 745 && counter_row_r <= 754
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 740 && counter_row_r <= 744 ||
                            counter_row_r >= 755 && counter_row_r <= 759
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 745 && counter_row_r <= 754
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 740 && counter_row_r <= 744 ||
                            counter_row_r >= 755 && counter_row_r <= 759
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 745 && counter_row_r <= 754
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                    NINE:begin
                        //1
                        if((counter_column_r >= 167 && counter_column_r <= 171) &&
                           (counter_row_r >= 745 && counter_row_r <= 754
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //2
                        if((counter_column_r >= 172 && counter_column_r <= 176) &&
                           (counter_row_r >= 740 && counter_row_r <= 744 ||
                            counter_row_r >= 755 && counter_row_r <= 759
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //3
                        if((counter_column_r >= 177 && counter_column_r <= 181) &&
                           (counter_row_r >= 745 && counter_row_r <= 759
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //4
                        if((counter_column_r >= 182 && counter_column_r <= 186) &&
                           (counter_row_r >= 755 && counter_row_r <= 759 
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                        //5
                        if((counter_column_r >= 187 && counter_column_r <= 191) &&
                           (counter_row_r >= 750 && counter_row_r <= 754
                        )) begin                     
                            VGA_R_w = 0;
                            VGA_G_w = 0;
                            VGA_B_w = 0;           
                        end
                    end
                endcase
                //set drum
                //gray frame
                if((counter_column_r == 236 || counter_column_r == 237 || counter_column_r == 304 || counter_column_r == 305 ) &&
                   (counter_row_r >= 288 && counter_row_r <= 357
                )) begin   
                    if(perfect) begin
                        VGA_R_w = 237;
                        VGA_G_w = 28;
                        VGA_B_w = 35;
                    end     
                    else if(good) begin
                        VGA_R_w = 0;
                        VGA_G_w = 183;
                        VGA_B_w = 239;
                    end     
                    else if(miss) begin
                        VGA_R_w = 34;
                        VGA_G_w = 177;
                        VGA_B_w = 77;
                    end  
                    else begin    
                        VGA_R_w = 180;
                        VGA_G_w = 180;
                        VGA_B_w = 180;  
                    end         
                end
                if((counter_column_r >= 238 && counter_column_r <= 303) &&
                   (counter_row_r == 288 || counter_row_r == 289 || counter_row_r == 356 || counter_row_r == 357
                )) begin                     
                    if(perfect) begin
                        VGA_R_w = 237;
                        VGA_G_w = 28;
                        VGA_B_w = 35;
                    end     
                    else if(good) begin
                        VGA_R_w = 0;
                        VGA_G_w = 183;
                        VGA_B_w = 239;
                    end     
                    else if(miss) begin
                        VGA_R_w = 34;
                        VGA_G_w = 177;
                        VGA_B_w = 77;
                    end  
                    else begin    
                        VGA_R_w = 180;
                        VGA_G_w = 180;
                        VGA_B_w = 180;  
                    end                
                end
                //main 
                if((counter_column_r >= 248 && counter_column_r <= 292 ) &&
                   (counter_row_r >= 299 && counter_row_r <= 345
                )) begin                     
                    VGA_R_w = 180;
                    VGA_G_w = 180;
                    VGA_B_w = 180;           
                end
                //eyes
                if((counter_column_r >= 261 && counter_column_r <= 268 ) &&
                   (counter_row_r >= 309 && counter_row_r <= 316 ||
                    counter_row_r >= 328 && counter_row_r <= 335
                )) begin                     
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;           
                end
                //smile
                if((counter_column_r == 280 || counter_column_r == 281 ) &&
                   (counter_row_r >= 313 && counter_row_r <= 331 
                )) begin                     
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;           
                end
                if((counter_column_r >= 276 && counter_column_r <= 279 ) &&
                   (counter_row_r == 313 || counter_row_r == 314 || counter_row_r == 330 || counter_row_r == 331
                )) begin                     
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;           
                end
                //moving drum
                for(i=0; i<=256; i=i+1)begin
                    if(beat[i]==1) begin
                        /*if((counter_column_r >= 248 && counter_column_r <= 292 ) &&
                            (counter_row_r >= 272+((i*2)-23) && counter_row_r <= 272+((i*2)+23)
                            )) begin                     
                                VGA_R_w = 0;
                                VGA_G_w = 0;
                                VGA_B_w = 0;           
                        end
                        if((counter_column_r >= 249 && counter_column_r <= 291 ) &&
                            (counter_row_r >= 272+((i*2)-22) && counter_row_r <= 272+((i*2)+22)
                            )) begin                     
                                VGA_R_w = 255;
                                VGA_G_w = 255;
                                VGA_B_w = 255;           
                        end*/
                        if((counter_column_r >= 250 && counter_column_r <= 290 ) &&
                            (counter_row_r >= 272+((i*2)-21) && counter_row_r <= 272+((i*2)+21)
                            )) begin                     
                                VGA_R_w = 240;
                                VGA_G_w = 102;
                                VGA_B_w = 87;           
                            end
                    end
                end
                //black frame
                if(counter_column_r >= 210 && counter_column_r <= 215 || 
                   counter_column_r >= 327 && counter_column_r <= 332 ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;   
                end
                if( (counter_column_r >= 216 && counter_column_r <= 326) && 
                    (counter_row_r >= 266 && counter_row_r <= 271)  ) begin                 
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;         
                end
                //white part
                if( (counter_column_r >= 216 && counter_column_r <= 326) && 
                    (counter_row_r <= 265)  ) begin                 
                        VGA_R_w = 255;
                        VGA_G_w = 255;
                        VGA_B_w = 255;         
                end
                //perfect
                //1
                if((counter_column_r >= 243 && counter_column_r <= 245) &&
                    (counter_row_r >= 153 && counter_row_r <= 161 ||
                       counter_row_r >= 168 && counter_row_r <= 179 ||
                       counter_row_r >= 183 && counter_row_r <= 191 ||
                       counter_row_r >= 198 && counter_row_r <= 209 ||  
                       counter_row_r >= 213 && counter_row_r <= 224 ||
                       counter_row_r >= 231 && counter_row_r <= 236 ||
                       counter_row_r >= 243 && counter_row_r <= 257 ) 
                  ) begin  
                        if(perfect) begin
                            VGA_R_w = 237;
                            VGA_G_w = 28;
                            VGA_B_w = 35;
                        end
                        else begin                
                            VGA_R_w = 180;
                            VGA_G_w = 180;
                            VGA_B_w = 180;  
                        end
                    end         
                //2
                if((counter_column_r >= 246 && counter_column_r <= 248) &&
                    (counter_row_r >= 153 && counter_row_r <= 155 ||
                       counter_row_r >= 162 && counter_row_r <= 164 ||
                       counter_row_r >= 168 && counter_row_r <= 170 ||
                       counter_row_r >= 183 && counter_row_r <= 185 ||
                       counter_row_r >= 192 && counter_row_r <= 194 ||
                       counter_row_r >= 198 && counter_row_r <= 200 ||
                       counter_row_r >= 213 && counter_row_r <= 215 ||
                       counter_row_r >= 228 && counter_row_r <= 230 ||
                       counter_row_r >= 237 && counter_row_r <= 239 ||
                       counter_row_r >= 249 && counter_row_r <= 251 )
                   ) begin                   
                        if(perfect) begin
                            VGA_R_w = 237;
                            VGA_G_w = 28;
                            VGA_B_w = 35;
                        end
                        else begin                
                            VGA_R_w = 180;
                            VGA_G_w = 180;
                            VGA_B_w = 180;  
                        end        
                end
                //3
                if((counter_column_r >= 249 && counter_column_r <= 251) &&
                    (counter_row_r >= 153 && counter_row_r <= 161 ||
                       counter_row_r >= 168 && counter_row_r <= 176 ||
                       counter_row_r >= 183 && counter_row_r <= 191 ||
                       counter_row_r >= 198 && counter_row_r <= 206 ||
                       counter_row_r >= 213 && counter_row_r <= 221 ||
                       counter_row_r >= 228 && counter_row_r <= 230 ||
                       counter_row_r >= 249 && counter_row_r <= 251 )
                     ) begin                   
                        if(perfect) begin
                            VGA_R_w = 237;
                            VGA_G_w = 28;
                            VGA_B_w = 35;
                        end
                        else begin                
                            VGA_R_w = 180;
                            VGA_G_w = 180;
                            VGA_B_w = 180;  
                        end   
                end
                //4
                if((counter_column_r >= 252 && counter_column_r <= 254) &&
                    (counter_row_r >= 153 && counter_row_r <= 155 ||
                       counter_row_r >= 168 && counter_row_r <= 170 ||
                       counter_row_r >= 183 && counter_row_r <= 185 ||
                       counter_row_r >= 189 && counter_row_r <= 191 ||
                       counter_row_r >= 198 && counter_row_r <= 200 ||
                       counter_row_r >= 213 && counter_row_r <= 215 ||
                       counter_row_r >= 228 && counter_row_r <= 230 ||
                       counter_row_r >= 237 && counter_row_r <= 239 ||
                       counter_row_r >= 249 && counter_row_r <= 251 )
                 ) begin                  
                        if(perfect) begin
                            VGA_R_w = 237;
                            VGA_G_w = 28;
                            VGA_B_w = 35;
                        end
                        else begin                
                            VGA_R_w = 180;
                            VGA_G_w = 180;
                            VGA_B_w = 180;  
                        end        
                end
                //5
                if((counter_column_r >= 255 && counter_column_r <= 257) && 
                    (counter_row_r >= 153 && counter_row_r <= 155 ||
                       counter_row_r >= 168 && counter_row_r <= 179 ||
                       counter_row_r >= 183 && counter_row_r <= 185 ||
                       counter_row_r >= 192 && counter_row_r <= 194 ||
                       counter_row_r >= 198 && counter_row_r <= 200 ||
                       counter_row_r >= 213 && counter_row_r <= 224 ||
                       counter_row_r >= 231 && counter_row_r <= 236 ||
                       counter_row_r >= 249 && counter_row_r <= 251 )
                ) begin                
                        if(perfect) begin
                            VGA_R_w = 237;
                            VGA_G_w = 28;
                            VGA_B_w = 35;
                        end
                        else begin                
                            VGA_R_w = 180;
                            VGA_G_w = 180;
                            VGA_B_w = 180;  
                        end       
                end
                //good
                //1
                if((counter_column_r >= 268 && counter_column_r <= 270) && 
                    (counter_row_r >= 177 && counter_row_r <= 182 ||
                       counter_row_r >= 192 && counter_row_r <= 197 ||
                       counter_row_r >= 207 && counter_row_r <= 212 ||
                       counter_row_r >= 219 && counter_row_r <= 227 )
                ) begin                  
                        if(good) begin
                            VGA_R_w = 0;
                            VGA_G_w = 183;
                            VGA_B_w = 239;
                        end
                        else begin                
                            VGA_R_w = 180;
                            VGA_G_w = 180;
                            VGA_B_w = 180;  
                        end      
                end
                //2
                if((counter_column_r >= 271 && counter_column_r <= 273) &&
                    (counter_row_r >= 174 && counter_row_r <= 176 ||
                       counter_row_r >= 189 && counter_row_r <= 191 ||
                       counter_row_r >= 198 && counter_row_r <= 200 ||
                       counter_row_r >= 204 && counter_row_r <= 206 ||
                       counter_row_r >= 213 && counter_row_r <= 215 ||
                       counter_row_r >= 219 && counter_row_r <= 221 ||
                       counter_row_r >= 228 && counter_row_r <= 230 )
                 ) begin                 
                        if(good) begin
                            VGA_R_w = 0;
                            VGA_G_w = 183;
                            VGA_B_w = 239;
                        end
                        else begin                
                            VGA_R_w = 180;
                            VGA_G_w = 180;
                            VGA_B_w = 180;  
                        end             
                end
                //3
                if((counter_column_r >= 274 && counter_column_r <= 276) && 
                    (counter_row_r >= 174 && counter_row_r <= 176 ||
                       counter_row_r >= 180 && counter_row_r <= 185 ||
                       counter_row_r >= 189 && counter_row_r <= 191 ||
                       counter_row_r >= 198 && counter_row_r <= 200 ||
                       counter_row_r >= 204 && counter_row_r <= 206 ||
                       counter_row_r >= 213 && counter_row_r <= 215 ||
                       counter_row_r >= 219 && counter_row_r <= 221 ||
                       counter_row_r >= 228 && counter_row_r <= 230 ) 
                ) begin                  
                        if(good) begin
                            VGA_R_w = 0;
                            VGA_G_w = 183;
                            VGA_B_w = 239;
                        end
                        else begin                
                            VGA_R_w = 180;
                            VGA_G_w = 180;
                            VGA_B_w = 180;  
                        end            
                end
                //4
                if((counter_column_r >= 277 && counter_column_r <= 279) &&
                    (counter_row_r >= 174 && counter_row_r <= 176 ||
                       counter_row_r >= 183 && counter_row_r <= 185 ||
                       counter_row_r >= 189 && counter_row_r <= 191 ||
                       counter_row_r >= 198 && counter_row_r <= 200 ||
                       counter_row_r >= 204 && counter_row_r <= 206 ||
                       counter_row_r >= 213 && counter_row_r <= 215 ||
                       counter_row_r >= 219 && counter_row_r <= 221 ||
                       counter_row_r >= 228 && counter_row_r <= 230 )
                 ) begin                   
                        if(good) begin
                            VGA_R_w = 0;
                            VGA_G_w = 183;
                            VGA_B_w = 239;
                        end
                        else begin                
                            VGA_R_w = 180;
                            VGA_G_w = 180;
                            VGA_B_w = 180;  
                        end            
                end
                //5
                if((counter_column_r >= 280 && counter_column_r <= 282) &&
                    (counter_row_r >= 177 && counter_row_r <= 182 ||
                       counter_row_r >= 192 && counter_row_r <= 197 ||
                       counter_row_r >= 207 && counter_row_r <= 212 ||
                       counter_row_r >= 219 && counter_row_r <= 227 )   
                 ) begin                
                        if(good) begin
                            VGA_R_w = 0;
                            VGA_G_w = 183;
                            VGA_B_w = 239;
                        end
                        else begin                
                            VGA_R_w = 180;
                            VGA_G_w = 180;
                            VGA_B_w = 180;  
                        end          
                end
                //miss
                //1
                if((counter_column_r >= 291 && counter_column_r <= 293) &&
                    (counter_row_r >= 174 && counter_row_r <= 176 ||
                       counter_row_r >= 186 && counter_row_r <= 188 ||
                       counter_row_r >= 192 && counter_row_r <= 200 ||
                       counter_row_r >= 207 && counter_row_r <= 215 ||
                       counter_row_r >= 222 && counter_row_r <= 230)
                 ) begin                
                        if(miss) begin
                            VGA_R_w = 34;
                            VGA_G_w = 177;
                            VGA_B_w = 77;
                        end
                        else begin                
                            VGA_R_w = 180;
                            VGA_G_w = 180;
                            VGA_B_w = 180;  
                        end             
                end
                //2
                if((counter_column_r >= 294 && counter_column_r <= 296) &&
                    (counter_row_r >= 174 && counter_row_r <= 179 ||
                       counter_row_r >= 183 && counter_row_r <= 188 ||
                       counter_row_r >= 195 && counter_row_r <= 197 ||
                       counter_row_r >= 204 && counter_row_r <= 206 ||
                       counter_row_r >= 219 && counter_row_r <= 221)         
                 ) begin                
                        if(miss) begin
                            VGA_R_w = 34;
                            VGA_G_w = 177;
                            VGA_B_w = 77;
                        end
                        else begin                
                            VGA_R_w = 180;
                            VGA_G_w = 180;
                            VGA_B_w = 180;  
                        end               
                end
                //3
                if((counter_column_r >= 297 && counter_column_r <= 299) &&
                    (counter_row_r >= 174 && counter_row_r <= 176 ||
                       counter_row_r >= 186 && counter_row_r <= 188 ||
                       counter_row_r >= 180 && counter_row_r <= 182 ||
                       counter_row_r >= 195 && counter_row_r <= 197 ||
                       counter_row_r >= 207 && counter_row_r <= 212 ||
                       counter_row_r >= 222 && counter_row_r <= 227)          
                 ) begin                
                        if(miss) begin
                            VGA_R_w = 34;
                            VGA_G_w = 177;
                            VGA_B_w = 77;
                        end
                        else begin                
                            VGA_R_w = 180;
                            VGA_G_w = 180;
                            VGA_B_w = 180;  
                        end         
                end
                //4
                if((counter_column_r >= 300 && counter_column_r <= 302) &&
                    (counter_row_r >= 174 && counter_row_r <= 176 ||
                       counter_row_r >= 186 && counter_row_r <= 188 ||
                       counter_row_r >= 195 && counter_row_r <= 197 ||
                       counter_row_r >= 213 && counter_row_r <= 215 ||
                       counter_row_r >= 228 && counter_row_r <= 230)
                 ) begin                  
                        if(miss) begin
                            VGA_R_w = 34;
                            VGA_G_w = 177;
                            VGA_B_w = 77;
                        end
                        else begin                
                            VGA_R_w = 180;
                            VGA_G_w = 180;
                            VGA_B_w = 180;  
                        end                
                end
                //5
                if((counter_column_r >= 303 && counter_column_r <= 305) &&
                    (counter_row_r >= 174 && counter_row_r <= 176 ||
                       counter_row_r >= 186 && counter_row_r <= 188 ||
                       counter_row_r >= 192 && counter_row_r <= 200 ||
                       counter_row_r >= 204 && counter_row_r <= 212 ||
                       counter_row_r >= 219 && counter_row_r <= 227)
                 ) begin                  
                        if(miss) begin
                            VGA_R_w = 34;
                            VGA_G_w = 177;
                            VGA_B_w = 77;
                        end
                        else begin                
                            VGA_R_w = 180;
                            VGA_G_w = 180;
                            VGA_B_w = 180;  
                        end               
                end
                //drum black circle
                if((counter_column_r == 383 || counter_column_r == 454) &&
                    (counter_row_r >= 392 && counter_row_r <= 405 ||
                     counter_row_r >= 509 && counter_row_r <= 522 )
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end 
                if((counter_column_r == 384 || counter_column_r == 453) &&
                    (counter_row_r >= 388 && counter_row_r <= 409 ||
                     counter_row_r >= 505 && counter_row_r <= 526 )
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end    
                if((counter_column_r == 385 || counter_column_r == 452) &&
                    (counter_row_r >= 385 && counter_row_r <= 392 ||
                     counter_row_r >= 405 && counter_row_r <= 412 ||
                     counter_row_r >= 502 && counter_row_r <= 509 ||
                     counter_row_r >= 522 && counter_row_r <= 529)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end   
                if((counter_column_r == 386 || counter_column_r == 451) &&
                    (counter_row_r >= 383 && counter_row_r <= 388 ||
                     counter_row_r >= 409 && counter_row_r <= 414 ||
                     counter_row_r >= 500 && counter_row_r <= 505 ||
                     counter_row_r >= 526 && counter_row_r <= 531)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end 
                if((counter_column_r == 387 || counter_column_r == 450) &&
                    (counter_row_r >= 381 && counter_row_r <= 385 ||
                     counter_row_r >= 413 && counter_row_r <= 416 ||
                     counter_row_r >= 498 && counter_row_r <= 502 ||
                     counter_row_r >= 530 && counter_row_r <= 523)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end  
                if((counter_column_r == 388 || counter_column_r == 449) &&
                    (counter_row_r >= 379 && counter_row_r <= 383 ||
                     counter_row_r >= 414 && counter_row_r <= 418 ||
                     counter_row_r >= 496 && counter_row_r <= 500 ||
                     counter_row_r >= 531 && counter_row_r <= 535)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end   
                if((counter_column_r == 389 || counter_column_r == 448) &&
                    (counter_row_r >= 378 && counter_row_r <= 381 ||
                     counter_row_r >= 416 && counter_row_r <= 419 ||
                     counter_row_r >= 495 && counter_row_r <= 498 ||
                     counter_row_r >= 533 && counter_row_r <= 536)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end 
                if((counter_column_r == 390 || counter_column_r == 447) &&
                    (counter_row_r >= 376 && counter_row_r <= 379 ||
                     counter_row_r >= 418 && counter_row_r <= 421 ||
                     counter_row_r >= 493 && counter_row_r <= 496 ||
                     counter_row_r >= 535 && counter_row_r <= 538)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end   
                if((counter_column_r == 391 || counter_column_r == 446 ) &&
                    (counter_row_r >= 375 && counter_row_r <= 378 ||
                     counter_row_r >= 419 && counter_row_r <= 422 ||
                     counter_row_r >= 492 && counter_row_r <= 495 ||
                     counter_row_r >= 536 && counter_row_r <= 539)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 392 || counter_column_r == 445) &&
                    (counter_row_r >= 374 && counter_row_r <= 376 ||
                     counter_row_r >= 421 && counter_row_r <= 423 ||
                     counter_row_r >= 491 && counter_row_r <= 493 ||
                     counter_row_r >= 538 && counter_row_r <= 540)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 393 || counter_column_r == 444 ) &&
                    (counter_row_r >= 373 && counter_row_r <= 375 ||
                     counter_row_r >= 422 && counter_row_r <= 424 ||
                     counter_row_r >= 490 && counter_row_r <= 492 ||
                     counter_row_r >= 539 && counter_row_r <= 541)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 394 || counter_column_r == 443 ) &&
                    (counter_row_r >= 372 && counter_row_r <= 374 ||
                     counter_row_r >= 423 && counter_row_r <= 425 ||
                     counter_row_r >= 489 && counter_row_r <= 491 ||
                     counter_row_r >= 540 && counter_row_r <= 542)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 395 || counter_column_r == 442 ) &&
                    (counter_row_r >= 371 && counter_row_r <= 373 ||
                     counter_row_r >= 424 && counter_row_r <= 426 ||
                     counter_row_r >= 488 && counter_row_r <= 490 ||
                     counter_row_r >= 541 && counter_row_r <= 543)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 396 || counter_column_r == 441 ) &&
                    (counter_row_r >= 370 && counter_row_r <= 372 ||
                     counter_row_r >= 425 && counter_row_r <= 427 ||
                     counter_row_r >= 487 && counter_row_r <= 489 ||
                     counter_row_r >= 542 && counter_row_r <= 544)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 397 || counter_column_r == 440 ) &&
                    (counter_row_r >= 369 && counter_row_r <= 371 ||
                     counter_row_r >= 426 && counter_row_r <= 428 ||
                     counter_row_r >= 486 && counter_row_r <= 488 ||
                     counter_row_r >= 543 && counter_row_r <= 545)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 398 || counter_column_r == 439) &&
                    (counter_row_r >= 368 && counter_row_r <= 370 ||
                     counter_row_r >= 427 && counter_row_r <= 429 ||
                     counter_row_r >= 485 && counter_row_r <= 487 ||
                     counter_row_r >= 544 && counter_row_r <= 546)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 399 || counter_column_r == 438 ) &&
                    (counter_row_r >= 368 && counter_row_r <= 369 ||
                     counter_row_r >= 428 && counter_row_r <= 429 ||
                     counter_row_r >= 485 && counter_row_r <= 486 ||
                     counter_row_r >= 545 && counter_row_r <= 546)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 400 || counter_column_r == 437) &&
                    (counter_row_r >= 367 && counter_row_r <= 369 ||
                     counter_row_r >= 428 && counter_row_r <= 430 ||
                     counter_row_r >= 484 && counter_row_r <= 486 ||
                     counter_row_r >= 545 && counter_row_r <= 547)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 401 || counter_column_r == 436) &&
                    (counter_row_r >= 367 && counter_row_r <= 368 ||
                     counter_row_r >= 429 && counter_row_r <= 430 ||
                     counter_row_r >= 484 && counter_row_r <= 485 ||
                     counter_row_r >= 546 && counter_row_r <= 547)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 402 || counter_column_r == 435) &&
                    (counter_row_r >= 366 && counter_row_r <= 368 ||
                     counter_row_r >= 429 && counter_row_r <= 431 ||
                     counter_row_r >= 483 && counter_row_r <= 485 ||
                     counter_row_r >= 546 && counter_row_r <= 548)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 403 || counter_column_r == 434) &&
                    (counter_row_r >= 365 && counter_row_r <= 367 ||
                     counter_row_r >= 430 && counter_row_r <= 432 ||
                     counter_row_r >= 482 && counter_row_r <= 484 ||
                     counter_row_r >= 547 && counter_row_r <= 549)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 404 || counter_column_r == 405 || counter_column_r == 432 || counter_column_r == 433) &&
                    (counter_row_r >= 365 && counter_row_r <= 366 ||
                     counter_row_r >= 431 && counter_row_r <= 432 ||
                     counter_row_r >= 482 && counter_row_r <= 483 ||
                     counter_row_r >= 548 && counter_row_r <= 549)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 406 || counter_column_r == 431 ) &&
                    (counter_row_r >= 364 && counter_row_r <= 366 ||
                     counter_row_r >= 431 && counter_row_r <= 433 ||
                     counter_row_r >= 481 && counter_row_r <= 483 ||
                     counter_row_r >= 548 && counter_row_r <= 550) 
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 407 || counter_column_r == 408 || counter_column_r == 429 || counter_column_r == 430 ) &&
                    (counter_row_r >= 364 && counter_row_r <= 365 ||
                     counter_row_r >= 432 && counter_row_r <= 433 ||
                     counter_row_r >= 481 && counter_row_r <= 482 ||
                     counter_row_r >= 549 && counter_row_r <= 550)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 409 || counter_column_r == 428) &&
                    (counter_row_r >= 363 && counter_row_r <= 365 ||
                     counter_row_r >= 432 && counter_row_r <= 434 ||
                     counter_row_r >= 480 && counter_row_r <= 482 ||
                     counter_row_r >= 549 && counter_row_r <= 551)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r >= 410 && counter_column_r <= 412 || counter_column_r >= 425 && counter_column_r <= 427) &&
                    (counter_row_r >= 363 && counter_row_r <= 364 ||
                     counter_row_r >= 433 && counter_row_r <= 434 ||
                     counter_row_r >= 480 && counter_row_r <= 481 ||
                     counter_row_r >= 550 && counter_row_r <= 551)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 413 || counter_column_r == 424) &&
                    (counter_row_r >= 362 && counter_row_r <= 364 ||
                     counter_row_r >= 433 && counter_row_r <= 435 ||
                     counter_row_r >= 479 && counter_row_r <= 481 ||
                     counter_row_r >= 550 && counter_row_r <= 552)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r >= 414 && counter_column_r <= 423 ) &&
                    (counter_row_r >= 362 && counter_row_r <= 363 ||
                     counter_row_r >= 434 && counter_row_r <= 435 ||
                     counter_row_r >= 479 && counter_row_r <= 480 ||
                     counter_row_r >= 551 && counter_row_r <= 552)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                //red drum
                if( ((counter_column_r == 389 || counter_column_r == 448 ) && (counter_row_r >= 393 && counter_row_r <= 404)) ||
                    ((counter_column_r == 390 || counter_column_r == 447) && (counter_row_r >= 389 && counter_row_r <= 408)) ||
                    ((counter_column_r == 391 || counter_column_r == 446 ) && (counter_row_r >= 387 && counter_row_r <= 410)) ||
                    ((counter_column_r == 392 || counter_column_r == 445) && (counter_row_r >= 385 && counter_row_r <= 412)) ||
                    ((counter_column_r == 393 || counter_column_r == 444) && (counter_row_r >= 383 && counter_row_r <= 414)) ||
                    ((counter_column_r == 394 || counter_column_r == 443) && (counter_row_r >= 382 && counter_row_r <= 415)) ||
                    ((counter_column_r == 395 || counter_column_r == 442) && (counter_row_r >= 380 && counter_row_r <= 417)) ||
                    ((counter_column_r == 396 || counter_column_r == 441) && (counter_row_r >= 379 && counter_row_r <= 418)) ||
                    ((counter_column_r == 397 || counter_column_r == 440) && (counter_row_r >= 378 && counter_row_r <= 419)) ||
                    ((counter_column_r == 398 || counter_column_r == 439) && (counter_row_r >= 377 && counter_row_r <= 420)) ||
                    ((counter_column_r == 399 || counter_column_r == 438) && (counter_row_r >= 376 && counter_row_r <= 421)) ||
                    ((counter_column_r == 400 || counter_column_r == 401 || counter_column_r == 436 || counter_column_r == 437) && (counter_row_r >= 375 && counter_row_r <= 422)) ||
                    ((counter_column_r == 402 || counter_column_r == 435 ) && (counter_row_r >= 374 && counter_row_r <= 423)) ||
                    ((counter_column_r == 403 || counter_column_r == 404 || counter_column_r == 433 || counter_column_r == 434) && (counter_row_r >= 373 && counter_row_r <= 424)) ||
                    ((counter_column_r == 405 || counter_column_r == 406 || counter_column_r == 431 || counter_column_r == 432) && (counter_row_r >= 372 && counter_row_r <= 425)) ||
                    ((counter_column_r == 407 || counter_column_r == 408 || counter_column_r == 429 || counter_column_r == 430) && (counter_row_r >= 371 && counter_row_r <= 426)) ||
                    (((counter_column_r >= 409 && counter_column_r <= 412)||(counter_column_r >= 425 && counter_column_r <= 428)) && (counter_row_r >= 370 && counter_row_r <= 427)) ||
                    ((counter_column_r >= 413 && counter_column_r <= 424) && (counter_row_r >= 369 && counter_row_r <= 428)) 
                ) begin
                    VGA_R_w = 248;
                    VGA_G_w = 47;
                    VGA_B_w = 33;  
                end

                //blue drum
                if( ((counter_column_r == 389 || counter_column_r == 448 ) && (counter_row_r >= 510 && counter_row_r <= 521)) ||
                    ((counter_column_r == 390 || counter_column_r == 447) && (counter_row_r >= 506 && counter_row_r <= 525)) ||
                    ((counter_column_r == 391 || counter_column_r == 446 ) && (counter_row_r >= 504 && counter_row_r <= 527)) ||
                    ((counter_column_r == 392 || counter_column_r == 445) && (counter_row_r >= 502 && counter_row_r <= 529)) ||
                    ((counter_column_r == 393 || counter_column_r == 444) && (counter_row_r >= 500 && counter_row_r <= 531)) ||
                    ((counter_column_r == 394 || counter_column_r == 443) && (counter_row_r >= 499 && counter_row_r <= 532)) ||
                    ((counter_column_r == 395 || counter_column_r == 442) && (counter_row_r >= 497 && counter_row_r <= 534)) ||
                    ((counter_column_r == 396 || counter_column_r == 441) && (counter_row_r >= 496 && counter_row_r <= 535)) ||
                    ((counter_column_r == 397 || counter_column_r == 440) && (counter_row_r >= 495 && counter_row_r <= 536)) ||
                    ((counter_column_r == 398 || counter_column_r == 439) && (counter_row_r >= 494 && counter_row_r <= 537)) ||
                    ((counter_column_r == 399 || counter_column_r == 438) && (counter_row_r >= 493 && counter_row_r <= 538)) ||
                    ((counter_column_r == 400 || counter_column_r == 401 || counter_column_r == 436 || counter_column_r == 437) && (counter_row_r >= 492 && counter_row_r <= 539)) ||
                    ((counter_column_r == 402 || counter_column_r == 435 ) && (counter_row_r >= 491 && counter_row_r <= 540)) ||
                    ((counter_column_r == 403 || counter_column_r == 404 || counter_column_r == 433 || counter_column_r == 434) && (counter_row_r >= 490 && counter_row_r <= 541)) ||
                    ((counter_column_r == 405 || counter_column_r == 406 || counter_column_r == 431 || counter_column_r == 432) && (counter_row_r >= 489 && counter_row_r <= 542)) ||
                    ((counter_column_r == 407 || counter_column_r == 408 || counter_column_r == 429 || counter_column_r == 430) && (counter_row_r >= 488 && counter_row_r <= 543)) ||
                    (((counter_column_r >= 409 && counter_column_r <= 412)||(counter_column_r >= 425 && counter_column_r <= 428)) && (counter_row_r >= 487 && counter_row_r <= 544)) ||
                    ((counter_column_r >= 413 && counter_column_r <= 424) && (counter_row_r >= 486 && counter_row_r <= 545)) 
                ) begin
                    VGA_R_w = 86;
                    VGA_G_w = 181;
                    VGA_B_w = 179;  
                end
                //drum eyes
                if((counter_column_r == 407 || counter_column_r == 419) &&
                    (counter_row_r >= 384 && counter_row_r <= 388 ||
                     counter_row_r >= 409 && counter_row_r <= 413 ||
                     counter_row_r >= 501 && counter_row_r <= 505 ||
                     counter_row_r >= 526 && counter_row_r <= 530)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 408 || counter_column_r == 409 || counter_column_r == 417 || counter_column_r == 418) &&
                    (counter_row_r >= 382 && counter_row_r <= 390 ||
                     counter_row_r >= 407 && counter_row_r <= 415 ||
                     counter_row_r >= 499 && counter_row_r <= 507 ||
                     counter_row_r >= 524 && counter_row_r <= 532)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 410 || counter_column_r == 416) &&
                    (counter_row_r >= 381 && counter_row_r <= 391 ||
                     counter_row_r >= 406 && counter_row_r <= 416 ||
                     counter_row_r >= 498 && counter_row_r <= 508 ||
                     counter_row_r >= 523 && counter_row_r <= 533)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r >= 411 && counter_column_r <= 415) &&
                    (counter_row_r >= 380 && counter_row_r <= 392 ||
                     counter_row_r >= 405 && counter_row_r <= 417 ||
                     counter_row_r >= 497 && counter_row_r <= 509 ||
                     counter_row_r >= 522 && counter_row_r <= 534)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                //drum mouth
                if((counter_column_r == 425) &&
                    (counter_row_r >= 387 && counter_row_r <= 389 ||
                     counter_row_r >= 397 && counter_row_r <= 400 ||
                     counter_row_r >= 408 && counter_row_r <= 410 ||
                     counter_row_r >= 504 && counter_row_r <= 506 ||
                     counter_row_r >= 514 && counter_row_r <= 517 ||
                     counter_row_r >= 525 && counter_row_r <= 527)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 426) &&
                    (counter_row_r >= 387 && counter_row_r <= 390 ||
                     counter_row_r >= 397 && counter_row_r <= 400 ||
                     counter_row_r >= 407 && counter_row_r <= 410 ||
                     counter_row_r >= 504 && counter_row_r <= 507 ||
                     counter_row_r >= 514 && counter_row_r <= 517 ||
                     counter_row_r >= 524 && counter_row_r <= 527 )
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 427) &&
                    (counter_row_r >= 388 && counter_row_r <= 390 ||
                     counter_row_r >= 396 && counter_row_r <= 401 ||
                     counter_row_r >= 407 && counter_row_r <= 409 ||
                     counter_row_r >= 505 && counter_row_r <= 507 ||
                     counter_row_r >= 513 && counter_row_r <= 518 ||
                     counter_row_r >= 524 && counter_row_r <= 526 )
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 428) &&
                    (counter_row_r >= 389 && counter_row_r <= 408 ||
                     counter_row_r >= 506 && counter_row_r <= 525)
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 429) &&
                    (counter_row_r >= 390 && counter_row_r <= 397 ||
                     counter_row_r >= 400 && counter_row_r <= 407 ||
                     counter_row_r >= 507 && counter_row_r <= 514 ||
                     counter_row_r >= 517 && counter_row_r <= 524  )
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 430) &&
                    (counter_row_r >= 392 && counter_row_r <= 396 ||
                     counter_row_r >= 401 && counter_row_r <= 405 ||
                     counter_row_r >= 509 && counter_row_r <= 513 ||
                     counter_row_r >= 518 && counter_row_r <= 522  )
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                //tongue
                if((counter_column_r >= 431 && counter_column_r <= 432 ) &&
                    (counter_row_r >= 392 && counter_row_r <= 393 ||
                     counter_row_r >= 404 && counter_row_r <= 405  )
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 433 ) &&
                    (counter_row_r >= 392 && counter_row_r <= 394 ||
                     counter_row_r >= 403 && counter_row_r <= 405  )
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 434 ) &&
                    (counter_row_r >= 393 && counter_row_r <= 394 ||
                     counter_row_r >= 403 && counter_row_r <= 404  )
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 435 ) &&
                    (counter_row_r >= 393 && counter_row_r <= 395 ||
                     counter_row_r >= 402 && counter_row_r <= 404  )
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 436 ) &&
                    (counter_row_r >= 394 && counter_row_r <= 395 ||
                     counter_row_r >= 402 && counter_row_r <= 403  )
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 437 ) &&
                    (counter_row_r >= 394 && counter_row_r <= 396 ||
                     counter_row_r >= 401 && counter_row_r <= 403  )
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 438 ) &&
                    (counter_row_r >= 394 && counter_row_r <= 397 ||
                     counter_row_r >= 400 && counter_row_r <= 403  )
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 439 ) &&
                    (counter_row_r >= 395 && counter_row_r <= 402  )
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                if((counter_column_r == 440 ) &&
                    (counter_row_r >= 396 && counter_row_r <= 401  )
                 ) begin
                    VGA_R_w = 0;
                    VGA_G_w = 0;
                    VGA_B_w = 0;  
                end
                //red tongue
                if((counter_column_r == 429 ) &&
                    (counter_row_r >= 398 && counter_row_r <= 399  )
                 ) begin
                    VGA_R_w = 181;
                    VGA_G_w = 2;
                    VGA_B_w = 11;  
                end
                if((counter_column_r == 430 ) &&
                    (counter_row_r >= 397 && counter_row_r <= 400  )
                 ) begin
                    VGA_R_w = 181;
                    VGA_G_w = 2;
                    VGA_B_w = 11;  
                end
                if((counter_column_r == 431 || counter_column_r == 432 ) &&
                    (counter_row_r >= 394 && counter_row_r <= 403)
                 ) begin
                    VGA_R_w = 181;
                    VGA_G_w = 2;
                    VGA_B_w = 11;  
                end
                if((counter_column_r == 433 || counter_column_r == 434 ) &&
                    (counter_row_r >= 395 && counter_row_r <= 402)
                 ) begin
                    VGA_R_w = 181;
                    VGA_G_w = 2;
                    VGA_B_w = 11;  
                end
                if((counter_column_r == 435 || counter_column_r == 436 ) &&
                    (counter_row_r >= 396 && counter_row_r <= 401)
                 ) begin
                    VGA_R_w = 181;
                    VGA_G_w = 2;
                    VGA_B_w = 11;  
                end
                if((counter_column_r == 437 ) &&
                    (counter_row_r >= 397 && counter_row_r <= 400)
                 ) begin
                    VGA_R_w = 181;
                    VGA_G_w = 2;
                    VGA_B_w = 11;  
                end
                if((counter_column_r == 438 ) && (counter_row_r >= 398 && counter_row_r <= 399)) begin
                    VGA_R_w = 181;
                    VGA_G_w = 2;
                    VGA_B_w = 11;  
                end
                //wordD
                if( ((counter_column_r >= 391 && counter_column_r <= 402 || counter_column_r >= 436 && counter_column_r <= 446) && (counter_row_r >= 212 && counter_row_r <= 246)) ||
                    ((counter_column_r >= 403 && counter_column_r <= 435) && (counter_row_r >= 212 && counter_row_r <= 222 || counter_row_r >= 247 && counter_row_r <= 258)) 
                ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;  
                end
                //wordC
                if( ((counter_column_r >= 391 && counter_column_r <= 402 || counter_column_r >= 436 && counter_column_r <= 446) && (counter_row_r >= 282 && counter_row_r <= 303) ||
                    (counter_column_r >= 403 && counter_column_r <= 435) && (counter_row_r >= 271 && counter_row_r <= 281) ) ||
                    (counter_column_r >= 403 && counter_column_r <= 413 || counter_column_r >= 425 && counter_column_r <= 435) && (counter_row_r >= 304 && counter_row_r <= 315)
                ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;  
                end
                //wordL
                if( ((counter_column_r >= 392 && counter_column_r <= 430 ) && (counter_row_r >= 582 && counter_row_r <= 592)) ||
                    ((counter_column_r >= 431 && counter_column_r <= 440 ) && (counter_row_r >= 582 && counter_row_r <= 623 )) 
                ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;  
                end
                //wordA
                if( ((counter_column_r >= 392 && counter_column_r <= 401 ) && (counter_row_r >= 643 && counter_row_r <= 661)) ||
                    ((counter_column_r >= 402 && counter_column_r <= 411 || counter_column_r >= 421 && counter_column_r <= 440 ) && (counter_row_r >= 633 && counter_row_r <= 642 || counter_row_r >= 662 && counter_row_r <= 671)) ||
                    ((counter_column_r >= 412 && counter_column_r <= 420 ) && (counter_row_r >= 633 && counter_row_r <= 671))  
                ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;  
                end
                //wordB
                if( ((counter_column_r >= 392 && counter_column_r <= 401 || counter_column_r >= 412 && counter_column_r <= 421 || counter_column_r >= 431 && counter_column_r <= 440 ) && (counter_row_r >= 682 && counter_row_r <= 710)) ||
                    ((counter_column_r >= 402 && counter_column_r <= 411 || counter_column_r >= 421 && counter_column_r <= 430 ) && (counter_row_r >= 682 && counter_row_r <= 691 || counter_row_r >= 711 && counter_row_r <= 720)) 
                ) begin
                        VGA_R_w = 0;
                        VGA_G_w = 0;
                        VGA_B_w = 0;  
                end
            end
            
            default: begin
                VGA_R_w = 255;
                VGA_G_w = 255;
                VGA_B_w = 255;
            end

        endcase
    end
    else if(counter_row_r >= H_display_interval && counter_row_r < H_front_porch) begin
        counter_row_w = counter_row_r + 1;
        HS_w = 1;
    end
    else if(counter_row_r == 800) begin
        counter_row_w = 0;
        HS_w = 1;
        counter_column_w = counter_column_r + 1;
    end
    else begin
        counter_row_w = 0;
        HS_w = 1;
    end

    if(counter_column_r < V_sync ) begin
        VS_w = 0;
    end
    else begin
        VS_w = 1;
    end
end


always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n) begin
        counter_row_r <= 0;
        counter_column_r <= 0;
        VS_r <= 1;
        HS_r <= 1;
        VGA_R_r <= 0;
        VGA_G_r <= 0;
        VGA_B_r <= 0;
    end
    else begin
        counter_row_r <= counter_row_w;
        counter_column_r <= counter_column_w;
        VS_r <= VS_w;
        HS_r <= HS_w;
        VGA_R_r <= VGA_R_w;
        VGA_G_r <= VGA_G_w;
        VGA_B_r <= VGA_B_w;
    end
end
endmodule