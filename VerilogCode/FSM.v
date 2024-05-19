`timescale 1ns / 1ps




module decoder_2x4 (
    input  [2:0] sel,   // 2-bit selector
    input  btnu,btnd,    // 2-bit input
    output reg [7:0] out    // 4-bit output
);
always @(*) begin
    case (sel)
        3'b000: begin
         out=0;
         out[6]=btnu;
         out[4]=btnd;
       end
        3'b001: 
        begin
           out=0;
           out[7]=btnu;
           out[5]=btnd;
         end
        3'b010:begin
         out = 0;
         out[2]=btnu;
         out[0]=btnd;
         end
        3'b011: begin
         out = 0;
         out[3]=btnu;
         out[1]=btnd;
         end
  
       3'b100 : begin
       out=0;
       end

    endcase
end

endmodule


module fsm(input clk, rst, btn1,btn2,btn3,btn4,btn5, output [6:0]segments,output [3:0] anode_active, output  DP,  LD0,LD12, LD13, LD14, LD15,buzzer);


reg [2:0] state, nextState;
wire BTNU, BTNC, BTND, BTNR, BTNL;
wire [4:0]Buttons;
parameter [2:0] A= 3'b000,B=3'b001, C=3'b010, D= 3'b011, E= 3'b100, F=3'b101;
wire clk_out;
reg [2:0] sel;
reg enable_clock;
reg display_selector;
wire oneHz;

ClockDivider #(250000)div (clk, rst, clk_out);
ClockDivider #(50000000) oneHzClock(clk,rst,oneHz);

wire [6:0]segments_out_alarm;
wire [6:0]segments_out_clock;
wire [3:0] anode_active_alarm;
wire [3:0] anode_active_clock;



//A=clock/alarm
//B=time hour
//C=time minute
//D=alarm hour
//E=alarm minute
// Next state generation


//PushButtonDetector two(clk_out, rst, btn2, BTNC);
//PushButtonDetector three(clk_out,rst, btn3, BTND);
//PushButtonDetector one(clk_out, rst, btn1, BTNU);
//PushButtonDetector four(clk_out,rst, btn4, BTNR);
//PushButtonDetector five(clk_out,rst, btn5, BTNL);



PushButtonDetector two(clk_out, rst, btn1, Buttons[4]);  //BTNC
PushButtonDetector three(clk_out,rst, btn2, Buttons[3]); //BTND
PushButtonDetector one(clk_out, rst, btn3, Buttons[2]);  //BTNU
PushButtonDetector four(clk_out,rst, btn4, Buttons[1]);  // BTNR
PushButtonDetector five(clk_out,rst, btn5, Buttons[0]);  // BTNL

wire [7:0] up_down_reg;
decoder_2x4(sel,Buttons[2],Buttons[3],up_down_reg);


wire [19:0] check1,check2;
wire alarm_enable;
wire extra;
reg alarmOn;
exp5 alarm(clk,rst,0,up_down_reg[3],up_down_reg[2],up_down_reg[1],up_down_reg[0],segments_out_alarm,anode_active_alarm,check1,extra);
exp5 time_clock(clk,rst,enable_clock,up_down_reg[7],up_down_reg[6],up_down_reg[5],up_down_reg[4],segments_out_clock,anode_active_clock,check2,DP);




always @(*) begin
    case (state)
        A: begin
        
        sel=4;
        enable_clock=1;
        display_selector=0;
        nextState=A;
            if (Buttons == 5'b10000) begin  // BTNC
                sel = 0;
                enable_clock = 0;
                nextState = B;
                display_selector = 0;
            end 
            if(check1==check2 && check1!=0)
            begin 
            nextState=F;
            display_selector = 1;
            enable_clock=1;
            end
        end

        B: begin
        
        
         sel = 0;
         enable_clock = 0;
         display_selector = 0;
         nextState=B;

       
            if (Buttons == 5'b10000) begin  // BTNC
                sel = 4;
                enable_clock = 1;
                nextState = A;
                display_selector = 0;
            end else if (Buttons == 5'b01000) begin // BTND
                nextState = B;
            end else if (Buttons == 5'b00100) begin // BTNU
                nextState = B;
            end else if (Buttons == 5'b00010) begin // BTNR
                sel = 1;
                nextState = C;
            end else if (Buttons == 5'b00001) begin // BTNL
                sel = 3;
                nextState = E;
                display_selector = 1;
            end else begin
                nextState = B;
            end
        end

        C: begin
        
                 sel = 1;
                 enable_clock = 0;
                 display_selector = 0;
                 nextState=C;

            if (Buttons == 5'b10000) begin  // BTNC
                sel = 4;
                enable_clock = 1;
                nextState = A;
                display_selector = 0;
            end else if (Buttons == 5'b01000) begin // BTND
                nextState = C;
            end else if (Buttons == 5'b00100) begin // BTNU
                nextState = C;
            end else if (Buttons == 5'b00010) begin // BTNR
                sel = 2;
                nextState = D;
                display_selector = 1;
            end else if (Buttons == 5'b00001) begin // BTNL
                sel = 0;
                nextState = B;
                display_selector = 0;
            end else begin
                nextState = C;
            end
        end

        D: begin
        
                 sel = 2;
                 enable_clock = 0;
                 display_selector = 1;
                 nextState=D;

            if (Buttons == 5'b10000) begin  // BTNC
                sel = 4;
                enable_clock = 1;
                nextState = A;
                display_selector = 0;
            end else if (Buttons == 5'b01000) begin // BTND
                nextState = D;
            end else if (Buttons == 5'b00100) begin // BTNU
                nextState = D;
            end else if (Buttons == 5'b00010) begin // BTNR
                sel = 3;
                display_selector = 1;
                nextState = E;
            end else if (Buttons == 5'b00001) begin // BTNL
                sel = 1;
                display_selector = 0;
                nextState = C;
            end else begin
                nextState = D;
            end
        end

        E: begin
        
                 sel = 3;
                 enable_clock = 0;
                 display_selector = 1;
                 nextState=E;
               
            if (Buttons == 5'b10000) begin  // BTNC
                sel = 4;
                enable_clock = 1;
                nextState = A;
                display_selector = 0;
                
            end else if (Buttons == 5'b01000) begin // BTND
                nextState = E;
            end else if (Buttons == 5'b00100) begin // BTNU
                nextState = E;
            end else if (Buttons == 5'b00010) begin // BTNR
                sel = 0;
                display_selector = 0;
                nextState = B;
            end else if (Buttons == 5'b00001) begin // BTNL
                sel = 2;
                display_selector = 1;
                nextState = D;
            end else begin
                nextState = E;
            end
        end
        
        F :
        begin 
        display_selector=1;
        enable_clock=1;
        nextState=F;
        sel=4;
        if(Buttons==1||Buttons==2||Buttons==4||Buttons==8||Buttons==16)
        begin
          display_selector=0;
              enable_clock=1;
              nextState=A;
              sel=4;
        end
   
        end

        default: begin
            nextState = A;
            sel=4;
        end
    endcase
end


always @ (posedge clk_out or posedge rst) begin
if(rst) begin
state <= A;
end
else 
state <= nextState;
end


always @(*) begin
    if(state==F && oneHz)
        alarmOn=1; 
    else 
       alarmOn=0;       
  
    end


assign segments = display_selector? segments_out_alarm:segments_out_clock;
assign anode_active = display_selector? anode_active_alarm:anode_active_clock;

assign buzzer = (state==F) ? alarmOn:0;
assign LD0 =  (state==F)? alarmOn:(state==A);
assign LD12 = state==B;
assign LD13 = state==C;
assign LD14 = state==D;
assign LD15 = state==E;




endmodule
