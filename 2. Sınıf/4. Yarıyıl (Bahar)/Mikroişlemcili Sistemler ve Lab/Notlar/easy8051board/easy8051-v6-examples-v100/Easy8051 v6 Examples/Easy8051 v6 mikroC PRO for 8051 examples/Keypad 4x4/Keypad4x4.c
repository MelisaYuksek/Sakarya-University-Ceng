/*
 * Project name:
     Keypad_Test (Demonstration of the Keypad library routines)
 * Copyright:
     (c) Mikroelektronika, 2009.
 * Revision History:
     20071210:
       - initial release;
 * Description:
      A simple example of using the keypad library.
      It supports keypads with 1..4 rows and 1..4 columns. The code being 
      returned by the Keypad_Key_Press() and Keypad_Key_Click() functions is
      in range from 1..16. In this example, the code returned by the keypad 
      library functions is transformed into ASCII codes [0..9,A..F]. 
      In addition, a small single-byte counter displays in the second LCD row 
      number of key presses.
 * Test configuration:
     MCU:             AT89S8253
                      http://www.atmel.com/dyn/resources/prod_documents/doc3286.pdf
     Dev.Board:       Easy8051 v6
                      http://www.mikroe.com/en/tools/easy8051-v6/
     Oscillator:      External Clock 10.0000 MHz
     Ext. Modules:    LCD 2x16
                      http://www.mikroe.com/en/tools/components/#other
     SW:              mikroC PRO for 8051
                      http://www.mikroe.com/en/compilers/mikroc/8051/
 * NOTES:
     - Turn on LCD backlight switch on development board SW7.6.
     - Turn on pull-up resistors on PORT0.
 */

unsigned short kp, cnt, oldstate = 0;
char txt[6];

// Keypad module connections
char keypadPort at P0;
// End Keypad module connections

// LCD module connections
sbit LCD_RS at P2_0_bit;
sbit LCD_EN at P2_1_bit;

sbit LCD_D4 at P2_2_bit;
sbit LCD_D5 at P2_3_bit;
sbit LCD_D6 at P2_4_bit;
sbit LCD_D7 at P2_5_bit;
// End LCD module connections

void main() {
  cnt = 0;                                 // Reset counter
  Keypad_Init();                           // Initialize Keypad                              
  Lcd_Init();                              // Initialize LCD
  Lcd_Cmd(_LCD_CLEAR);                     // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);                // Cursor off

  LCD_Out(1, 1, "Key  :");                 // Write message text on LCD
  LCD_Out(2, 1, "Times:");

  do {
    kp = 0;                                // Reset key code variable

    // Wait for key to be pressed and released
    do
      // kp = Keypad_Key_Press();          // Store key code in kp variable
      kp = Keypad_Key_Click();             // Store key code in kp variable
    while (!kp);
   // Prepare value for output, transform key to it's ASCII value
    switch (kp) {
      case  1: kp = 49; break; // 1
      case  2: kp = 50; break; // 2
      case  3: kp = 51; break; // 3
      case  4: kp = 65; break; // A
      case  5: kp = 52; break; // 4
      case  6: kp = 53; break; // 5
      case  7: kp = 54; break; // 6
      case  8: kp = 66; break; // B        
      case  9: kp = 55; break; // 7
      case 10: kp = 56; break; // 8
      case 11: kp = 57; break; // 9
      case 12: kp = 67; break; // C
      case 13: kp = 42; break; // *
      case 14: kp = 48; break; // 0
      case 15: kp = 35; break; // #
      case 16: kp = 68; break; // D

    }

    if (kp != oldstate) {                  // Pressed key differs from previous
      cnt = 1;
      oldstate = kp;
      }
    else {                                 // Pressed key is same as previous
      cnt++;
      }

    Lcd_Chr(1, 10, kp);                    // Print key ASCII value on LCD

    if (cnt == 255) {                      // If counter varialble overflow
      cnt = 0;
      LCD_Out(2, 10, "   ");
      }

    WordToStr(cnt, txt);                   // Transform counter value to string
    LCD_Out(2, 10, txt);                   // Display counter value on LCD
  } while (1);
} 
