# Digital Alarm Clock Project

## Capabilities
- Display Time: 24-hour clock displayed for accurate timekeeping.
- Adjust Time: Users can adjust the time according to their preferences.
- Set Alarm: Users can set their alarm to a specific time of their choice.
- Buzzer at Alarm: An alarm sound is triggered when the alarm goes off.

## Project Overview
This project implements a digital alarm clock using the BASYS3 board and Verilog HDL. The clock's capabilities include timekeeping, alarm setting, mode switching, LED control, and 7-Segment display output.

## Requirements
- **Peripherals Used:**
  - LEDs: LD0, LD12, LD13, LD14, LD15
  - 7-Segment display
  - Push buttons: BTNC, BTNL, BTNR, BTNU, BTND
- **Display Usage:** 2 digits for hours and 2 digits for minutes on the 7-Segment display.
- **Modes:**
  - Default Mode: Clock/Alarm
  - Adjust Mode: Activated by pressing BTNC
- **Functionality in Clock/Alarm Mode:**
  - LD0 is OFF.
  - The 2nd decimal point from the left blinks at 1Hz.
  - LD0 blinks when the current time matches the set alarm time.
- **Functionality in Adjust Mode:**
  - LD0 is ON.
  - The 2nd decimal point from the left does not blink.
  - BTNL/BTNR buttons select the parameter to adjust (time hour, time minute, alarm hour, alarm minute).
  - LD12, LD13, LD14, LD15 indicate the parameter being adjusted.
  - BTNU increments the selected parameter.
  - BTND decrements the selected parameter.

## Code Overview
- **fsm:** Manages the clock's states, mode transitions, parameter adjustments, and LED/Display outputs.
- **DigitalClock:** Handles clock timekeeping, 1Hz clock generation, LED/Display control, and mode logic.

## Usage
1. Connect the BASYS3 board to the appropriate peripherals.
2. Upload the provided Verilog code to the FPGA.
3. Power on the board and interact with the push buttons to adjust time, set alarms, switch modes, and observe LED/Display indicators.

## Contributors
- Malek 
- Mostafa 
- Habiba
- Seif
