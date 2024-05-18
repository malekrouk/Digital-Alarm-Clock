`timescale 1ns / 1ps


module fsm(input clk, rst, btn1,btn2,btn3,btn4,btn5, output [6:0]segments,output [3:0] anode_active, output  DP,  LD0,LD12, LD13, LD14, LD15);




reg [2:0] state, nextState;
wire BTNU, BTNC, BTND, BTNR, BTNL;
wire [4:0]Buttons;
parameter [2:0] A= 3'b000,B=3'b001, C=3'b010, D= 3'b011, E= 3'b100;
wire clk_out;
reg [1:0]sel;
reg enable_clock;
reg display_selector;


ClockDivider #(250000)div(clk, reset, clk_out);


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






PushButtonDetector two(clk_out, rst, btn2, Buttons[4]);  //BTNC
PushButtonDetector three(clk_out,rst, btn3, Buttons[3]); //BTND
PushButtonDetector one(clk_out, rst, btn1, Buttons[2]);  //BTNU
PushButtonDetector four(clk_out,rst, btn4, Buttons[1]);  // BTNR
PushButtonDetector five(clk_out,rst, btn5, Buttons[0]);  // BTNL

//assign L = BTNC;
//
always @ (state,Buttons) begin
case (state)

A: if (Buttons==5'b10000)  //BTNC

begin
        //assign LD0 = 1'b1;
        sel=0;
        enable_clock = 0;
        nextState = B;
        display_selector = 0;
        
     end
 else begin
    enable_clock = 1'b1;
    nextState =A;
 end
 
B:
 if (Buttons==5'b10000)   //BTNC
begin 
sel=0;
enable_clock=1;
nextState=A;
end
else if( Buttons==5'b01000) //BTND
begin 
// time hour --
sel = 0;
enable_clock=0;
nextState=B;
end 
else if(Buttons==5'b00100) begin //BTNU
// time hour ++
sel = 0;
enable_clock = 0;
nextState=B;
end

else if(Buttons==5'b00010) //BTNR
begin 
sel=1;
enable_clock = 0;
nextState=C;
end

else if(Buttons==5'b00001) //BTNL
begin 
sel=3;
enable_clock = 0;
nextState=E;

end
else nextState = B;
    
C: 
 if (Buttons==5'b10000)   //BTNC
begin 
sel=0;
enable_clock=1;
nextState=A;
end
else if( Buttons==5'b01000) //BTND
begin 
// time hour --
sel = 1;
enable_clock=0;
nextState=B;
end 
else if(Buttons==5'b00100) begin //BTNU
// time hour ++
sel = 1;
enable_clock = 0;
nextState=B;
end

else if(Buttons==5'b00010) //BTNR
begin 


end

else if(Buttons==5'b00001) //BTNL
begin 


end
else nextState = C;

    
D:  
 if (Buttons==5'b10000)   //BTNC
begin 
sel=0;
enable_clock=1;
nextState=A;
end
else if( Buttons==5'b01000) //BTND
begin 
// time hour --
sel = 1;
enable_clock=0;
nextState=B;
end 
else if(Buttons==5'b00100) begin //BTNU
// time hour ++
sel = 1;
enable_clock = 0;
nextState=B;
end

else if(Buttons==5'b00010) //BTNR
begin 


end

else if(Buttons==5'b00001) //BTNL
begin 


end
else nextState = D;


    
E: 
 if (Buttons==5'b10000)   //BTNC
begin 
sel=0;
enable_clock=1;
nextState=A;
end
else if( Buttons==5'b01000) //BTND
begin 
// time hour --
sel = 1;
enable_clock=0;
nextState=B;
end 
else if(Buttons==5'b00100) begin //BTNU
// time hour ++
sel = 1;
enable_clock = 0;
nextState=B;
end

else if(Buttons==5'b00010) //BTNR
begin 


end

else if(Buttons==5'b00001) //BTNL
begin 


end
else nextState = E;


default: nextState = A;
endcase
end
// State register

always @ (posedge clk_out or posedge rst) begin
if(rst)

state <= A;
else 
state <= nextState;
end




assign LD0 = state==A;
assign LD12 = state==B;
assign LD13 = state==C;
assign LD14 = state==D;
assign LD15 = state==E;


    reg [3:0] display_data [3:0]; // 2D array holding 4-bits for the 4 digits to be displayed with 4 cases.(its like mapping 4 times)
    wire [3:0] display_digit; // current digit to be displayed

    // Display logic
    always @ (posedge clk_100Hz) begin
        if (display_selector == 0) begin
            anode_active <= anode_active + 1; // blinking
            display_data[0] <= 4'd0; // change this with the clock digits
            display_data[1] <= 4'd1; 
            display_data[2] <= 4'd2;
            display_data[3] <= 4'd3;
        end else begin
            anode_active <= 4'b1111; // No blinking, fixed display
            display_data[0] <= 4'd4; // Alarm data
            display_data[1] <= 4'd5; 
            display_data[2] <= 4'd6;
            display_data[3] <= 4'd7;
        end
    end

    assign display_digit = display_data[anode_state];

    SevenSegmentDisplay ssd(display_digit, segments, DP);

endmodule
