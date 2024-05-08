// Define the button initial states
bool BTNC = false;
bool BTNL = false;
bool BTNR = false;
bool BTNU = false;
bool BTND = false;

bool clock_mode = true;
bool LDO = false;
bool buzzer_on = false; 
int current_time = 0;
int alarm_time = 0;
int adjust_parameter = 0;

// Function to signal the alarm and turn on the buzzer
void signalAlarm() {
    buzzer_on = true; // Turn on the buzzer
}

// Function to turn off the buzzer
void stopAlarm() {
    buzzer_on = false; // Turn off the buzzer
}

// Function to toggle clock mode and adjust LD0
void toggleMode() {
    clock_mode = !clock_mode;
    LDO = clock_mode; // Update LD0 based on clock mode
}

// Function to handle button presses
void handleButtonPress() {
    if (clock_mode) {
        // If in clock mode
        if (current_time == alarm_time) {
            // Check if it matches the alarm time
            // If yes, signal the alarm and turn on the buzzer
            signalAlarm();
        }
    } else {
        // If in adjustment mode
        // Activate the 7seg and LEDs
        // Turn off the buzzer if it was on
        if (buzzer_on) {
            stopAlarm();
        }
    }
}

// Function to handle left button press
void handleLeftButton() {
    // Left pressed - shift left
    // Update LED
}

// Function to handle right button press
void handleRightButton() {
    // Right pressed - shift right
    // Update LED
}

// Function to handle button UP press
void handleUpButton() {
    // Increase in a certain parameter
    // Update LED
}

// Function to handle button DOWN press
void handleDownButton() {
    // Decrease in a certain parameter
    // Update LED
}

int main() {
    while (true) {
        handleButtonPress(); // Handle button press regardless of clock mode

        if (BTNC) {
            // Press main button
            toggleMode(); // Toggle between clock mode and adjustment mode
        }

        if (BTNL) {
            // Left button pressed
            handleLeftButton(); // Handle left button press
        }

        if (BTNR) {
            // Right button pressed
            handleRightButton(); // Handle right button press
        }

        if (BTNU) {
            // UP button pressed
            handleUpButton(); // Handle increase in a certain parameter
        }

        if (BTND) {
            // DOWN button pressed
            handleDownButton(); // Handle decrease in a certain parameter
        }
        current_time++; // Increment current time
    }

    return 0;
}
