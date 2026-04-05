/*
 * Project name:
     Button (Demonstration of using Button Library)
 * Copyright:
     (c) Mikroelektronika, 2009.
 * Revision History:
     20071210:
       - initial release;
 * Description:
     This program demonstrates usage on-board button as PORT0 input.
     On every P0.0 one-to-zero transition PORT2 is inverted.
 * Test configuration:
     MCU:             AT89S8253
                      http://www.atmel.com/dyn/resources/prod_documents/doc3286.pdf
     Dev.Board:       Easy8051 v6
                      http://www.mikroe.com/en/tools/easy8051-v6/
     Oscillator:      External Clock 10.0000 MHz
     Ext. Modules:    -
     SW:              mikroC PRO for 8051
                      http://www.mikroe.com/en/compilers/mikroc/8051/
 * NOTES:
     - Turn ON the PORT2 LEDs SW7.3.
     - Put button jumper J6 into GND position and pull-up PORT0.
*/

// Button connections
sbit Button_Pin at P0_0_bit;        // Declare Button_Pin. It will be used by Button Library.
// End Button connections

bit oldstate;                       // Old state flag

void main() {

  P0 = 255;                         // Configure PORT0 as input
  P2 = 0xAA;                        // Initial PORT2 value
  oldstate = 0;
  
  do {
    if (Button(1, 1))               // Detect logical one
      oldstate = 1;                 // Update flag
    if (oldstate && Button(1, 0)) { // Detect one-to-zero transition
      P2 = ~P2;                     // Invert PORT2
      oldstate = 0;                 // Update flag
      }
  } while(1);                       // Endless loop
}
