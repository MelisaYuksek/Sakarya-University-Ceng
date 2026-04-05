/*
 * Project name:
     LED_Blinking (Simple 'Hello World' project)
 * Copyright:
     (c) Mikroelektronika, 2009.
 * Revision History:
     20071210:
       - initial release;
 * Description:
     This is a simple 'Hello World' project. It turns on/off diodes connected to
     PORT0, PORT1, PORT2 and PORT3.
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
     - Turn ON the PORT LEDs.
     - On Easy8051 v6 LEDs are activated by logical zero.
*/

void main() {
  do {
    P0 = 0x00;        // Turn ON diodes on PORT0
    P1 = 0x00;        // Turn ON diodes on PORT1
    P2 = 0x00;        // Turn ON diodes on PORT2
    P3 = 0x00;        // Turn ON diodes on PORT3
    Delay_ms(1000);   // 1 second delay
    
    P0 = 0xFF;        // Turn OFF diodes on PORT0
    P1 = 0xFF;        // Turn OFF diodes on PORT1
    P2 = 0xFF;        // Turn OFF diodes on PORT2
    P3 = 0xFF;        // Turn OFF diodes on PORT3
    Delay_ms(1000);   // 1 second delay

  } while(1);         // Endless loop
}
