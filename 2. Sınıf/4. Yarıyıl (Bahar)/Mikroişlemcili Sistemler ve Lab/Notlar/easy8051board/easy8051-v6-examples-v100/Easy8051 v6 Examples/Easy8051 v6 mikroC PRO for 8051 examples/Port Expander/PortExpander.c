/*
 * Project name:
     PortExpander (Demonstration of the Port Expander library routines)
 * Copyright:
     (c) Mikroelektronika, 2009.
 * Revision History:
     20090601:
       - initial release;
 * Description:
     This project is simple demonstration how to use Port Expander Library
     functions to communicate with Port Expander.
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
     - Turn ON the PORT2 LEDs.
 */

// Port Expander module connections
sbit  SPExpanderRST at P3_7_bit;
sbit  SPExpanderCS  at P3_4_bit;
// End Port Expander module connections

unsigned char i = 0;

void main() {
  SPI1_Init();
  Expander_Init(0);                      // Initialize Port Expander

  Expander_Set_DirectionPortA(0, 0x00);  // Set Expander's PORTA to be output
  Expander_Set_DirectionPortB(0,0xFF);   // Set Expander's PORTB to be input
  Expander_Set_PullUpsPortB(0,0xFF);     // Set pull-ups to all of the Expander's PORTB pins

  while(1) {                             // Endless loop
    Expander_Write_PortA(0, i++);        // Write i to expander's PORTA
    P2 = ~Expander_Read_PortA(0);        // Read expander's PORTA and write it to PORT2 LEDs
    Delay_ms(100);
  }

}
