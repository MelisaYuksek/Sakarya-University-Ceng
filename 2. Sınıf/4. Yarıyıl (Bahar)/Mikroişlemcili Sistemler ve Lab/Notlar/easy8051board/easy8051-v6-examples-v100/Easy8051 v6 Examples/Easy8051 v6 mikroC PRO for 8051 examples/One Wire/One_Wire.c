/*
 * Project name:
     OneWire (Interfacing the DS1820 temperature sensor - all versions)
 * Copyright:
     (c) Mikroelektronika, 2009.
 * Revision History:
     20071210:
       - initial release;
 * Description:
     This code demonstrates one-wire communication with temperature sensor
     DS18x20 connected to P1.2 pin.
     MCU reads temperature from the sensor and prints it on the LCD.
     The display format of the temperature is 'xxx.xxxx°C'. To obtain correct
     results, the 18x20's temperature resolution has to be adjusted (constant
     TEMP_RESOLUTION).
 * Test configuration:
     MCU:             AT89S8253
                      http://www.atmel.com/dyn/resources/prod_documents/doc3286.pdf
     Dev.Board:       Easy8051 v6
                      http://www.mikroe.com/en/tools/easy8051-v6/
     Oscillator:      External Clock 10.0000 MHz
     Ext. Modules:    Lcd 2x16, DS18x20
                      http://www.mikroe.com/en/tools/components/#other
     SW:              mikroC PRO for 8051
                      http://www.mikroe.com/en/compilers/mikroc/8051/
 * NOTES:
     - Turn on DS1280 sensor switch to P1.2 pin (SW8.7).
     - Turn on LCD backlight switch on development board SW7.6.
     - Pull up and turning off diode on pin used for one wire bus may be required.
*/

// LCD module connections
sbit LCD_RS at P2_0_bit;
sbit LCD_EN at P2_1_bit;

sbit LCD_D4 at P2_2_bit;
sbit LCD_D5 at P2_3_bit;
sbit LCD_D6 at P2_4_bit;
sbit LCD_D7 at P2_5_bit;
// End LCD module connections

// OneWire pinout
sbit OW_Bit at P1.B2;
// end OneWire definition


//  Set TEMP_RESOLUTION to the corresponding resolution of used DS18x20 sensor:
//  18S20: 9  (default setting; can be 9,10,11,or 12)
//  18B20: 12
const unsigned short TEMP_RESOLUTION = 9;

char *text = "000.0000";
unsigned temp;

void Display_Temperature(unsigned int temp2write) {
  const unsigned short RES_SHIFT = TEMP_RESOLUTION - 8;
  char temp_whole;
  unsigned int temp_fraction;

  // check if temperature is negative
  if (temp2write & 0x8000) {
    text[0] = '-';
    temp2write = ~temp2write + 1;
  }

  // extract temp_whole
  temp_whole = temp2write >> RES_SHIFT ;

  // convert temp_whole to characters
  if (temp_whole/100)
     text[0] = temp_whole/100  + 48;
  else
     text[0] = '0';

  text[1] = (temp_whole/10)%10 + 48;             // Extract tens digit
  text[2] =  temp_whole%10     + 48;             // Extract ones digit

  // extract temp_fraction and convert it to unsigned int
  temp_fraction  = temp2write << (4-RES_SHIFT);
  temp_fraction &= 0x000F;
  temp_fraction *= 625;

  // convert temp_fraction to characters
  text[4] =  temp_fraction/1000    + 48;         // Extract thousands digit
  text[5] = (temp_fraction/100)%10 + 48;         // Extract hundreds digit
  text[6] = (temp_fraction/10)%10  + 48;         // Extract tens digit
  text[7] =  temp_fraction%10      + 48;         // Extract ones digit

  // print temperature on LCD
  Lcd_Out(2, 5, text);
}

void main() {

  Lcd_Init();                                    // Initialize LCD
  Lcd_Cmd(_LCD_CLEAR);                           // Clear LCD
  Lcd_Cmd(_LCD_CURSOR_OFF);                      // Turn cursor off
  Lcd_Out(1, 1, " Temperature:   ");
  // Print degree character, 'C' for Centigrades
  Lcd_Chr(2,13,223);  // different LCD displays have different char code for degree
                      // if you see greek alpha letter try typing 178 instead of 223

  Lcd_Chr(2,14,'C');

  //--- main loop
  do {
    //--- perform temperature reading
    Ow_Reset();                                  // Onewire reset signal
    Ow_Write(0xCC);                              // Issue command SKIP_ROM
    Ow_Write(0x44);                              // Issue command CONVERT_T
    Delay_us(120);

    Ow_Reset();
    Ow_Write(0xCC);                              // Issue command SKIP_ROM
    Ow_Write(0xBE);                              // Issue command READ_SCRATCHPAD

    temp =  Ow_Read();
    temp = (Ow_Read() << 8) + temp;

    //--- Format and display result on Lcd
    Display_Temperature(temp);

    Delay_ms(500);
  } while (1);
}
