/*
 * Project name:
     ADC_Test (Demonstration of SPI communication with AD converter)
 * Copyright:
     (c) Mikroelektronika, 2009.
 * Revision History:
     20090601:
       - initial release;
 * Description:
     This project is a simple demonstration of SPI communication with MCP3204
     AD converter. With minor adjustments, it should work with any MCU that has
     SPI module. Example measures analog values on Channels 0, 1, 2, and 3
     and displays them on LCD.
 * Test configuration:
     MCU:             AT89S8253
                      http://www.atmel.com/dyn/resources/prod_documents/doc3286.pdf
     Dev.Board:       Easy8051 v6
                      http://www.mikroe.com/en/tools/easy8051-v6/
     Oscillator:      External Clock 10.0000 MHz
     Ext. Modules:    Lcd 2x16
                      http://www.mikroe.com/en/tools/components/#other
     SW:              mikroC PRO for 8051
                      http://www.mikroe.com/en/compilers/mikroc/8051/
 * NOTES:
     - Select ADC voltage reference by connecting AREF jumper to Vcc or 4.096V.
       Turn on SPI and ADC-CS# switches SW6.4, SW6.5, SW6.6 and SW6.1.
     - Turn on LCD backlight switch on development board SW7.6.
*/

// LCD module connections
sbit LCD_RS at P2_0_bit;
sbit LCD_EN at P2_1_bit;

sbit LCD_D4 at P2_2_bit;
sbit LCD_D5 at P2_3_bit;
sbit LCD_D6 at P2_4_bit;
sbit LCD_D7 at P2_5_bit;
// End LCD module connections

// ADC module connections
sbit ADC_CS at P3_5_bit;
// End ADC module connections

unsigned int measurement;

void Init() {
  LCD_Init();                                 // init LCD
  LCD_Cmd(_LCD_CLEAR);
  LCD_Cmd(_LCD_CURSOR_OFF);
  SPI1_Init();                                // init SPI
  ADC_CS = 1;                                 // deselect MCP3204
}

unsigned int getADC(unsigned short channel) { // returns 0..4096
  unsigned int result;
  
  ADC_CS = 0;                                 // select MCP3204
  SPI1_Write(0x06);                           // send Start, Single, D2 = 0
  
  channel = channel << 6;                     // bits 7 & 6 (D1, D0) define ADC input
  result = SPI1_Read(channel) & 0x0F;         // send D1 D0 and receive B11..B8
  result = result << 8;                       // put B11..B8 into result's high byte
  
  result |= SPI1_Read(0);                     // receive B7..B0 and put it into result's low byte
  ADC_CS = 1;                                 // deselect MCP3204
  return result;
}

void DisplayValue(unsigned int value, unsigned short channel) { // Writes Value to LCD
char i, lcdRow, lcdCol;

  if (channel < 2)
    lcdRow=1;
  else
    lcdRow=2;
    
  if (channel%2 > 0 )
    lcdCol=13;
  else
    lcdCol=4;

  i = value /1000 + 48;
  LCD_Chr(lcdRow, lcdCol, i);
  value %= 1000;
  i = value /100 + 48;
  LCD_Chr(lcdRow, lcdCol+1, i);
  value %= 100;
  i = value /10 + 48;
  LCD_Chr(lcdRow, lcdCol+2, i);
  value %= 10;
  i = value + 48;
  LCD_Chr(lcdRow, lcdCol+3, i);      // Put number on display

}

void main(){

  Init();                            // initialize SPI and LCD
  LCD_Out(1,1,"C0=      C1=");
  LCD_Out(2,1,"C2=      C3=");
  
  while (1) {
    measurement = getADC(0);         // get ADC result from Channel 0
    DisplayValue(measurement,0);     // display measurement
    Delay_ms(100);                   // wait for a while

    measurement = getADC(1);         // get ADC result from Channel 1
    DisplayValue(measurement,1);     // display measurement
    Delay_ms(100);                   // wait for a while

    measurement = getADC(2);         // get ADC result from Channel 2
    DisplayValue(measurement,2);     // display measurement
    Delay_ms(100);                   // wait for a while

    measurement = getADC(3);         // get ADC result from Channel 3
    DisplayValue(measurement,3);     // display measurement
    Delay_ms(100);                   // wait for a while
  }
  
}
