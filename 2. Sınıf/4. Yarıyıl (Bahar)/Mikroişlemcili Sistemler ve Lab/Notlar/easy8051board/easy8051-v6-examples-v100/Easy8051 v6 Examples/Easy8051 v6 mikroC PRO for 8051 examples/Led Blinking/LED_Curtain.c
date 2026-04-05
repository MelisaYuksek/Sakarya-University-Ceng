/*
 * Project name:
     LED_Curtain (Simple 'Hello World' project)
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

char counter;

void wait() {
  Delay_ms(100);
}

void main() {

  P0 = 0xFF;        // Turn OFF diodes on PORT0
  P1 = 0xFF;        // Turn OFF diodes on PORT1
  P2 = 0xFF;        // Turn OFF diodes on PORT2
  P3 = 0xFF;        // Turn OFF diodes on PORT3

  while (1) {
    for (counter = 0; counter < 8; counter++){
      P0 |= 1 << counter;
      P1 |= 1 << counter;
      P2 |= 1 << counter;
      P3 |= 1 << counter;
      wait();
    }

    counter = 0;
    while (counter < 8) {
      P0 &= ~(1 << counter);
      P1 &= ~(1 << counter);
      P2 &= ~(1 << counter);
      P3 &= ~(1 << counter);
      wait();
      counter++;
    }
  }
}
