# FPGA Slot Machine <br>
This repo contains the code for a simple slot machine like game implemented via Verilog on a ZYBO Z7 ZYNQ-7010 development board. The board that I used for this project has certain peripherals which I leverage for the logic of the game such as: LED's, switches, and buttons. <br>

## Overview of Game
The code cycles an LED which the user has to "catch" with a switch corresponding to the same LED index position during the same clock cycle in order to win. If the game is won the LEDs will all flash indicating a win until it is reset. The game can be reset and played again by pressing BTN2 (Button 2).

### Clock Divider
The clock being used is 125MHz being supplied to pin K17 (https://digilent.com/reference/programmable-logic/zybo-z7/reference-manual), for the purposes of the game, the same clock drives the always block which toggles the LED positions via case states. If we did not reduce the clock rate then the LEDs would toggle at the same frequency which would make the game unplayable and to the user the LEDs would toggle so quickly that it would seem as if they were all on at the same time. We remedy this with a clock divider. By taking the onboard clock and creating a counter which counts up and stores the count in a register of a certain bit width (n), we can create a divided (reduced) clock signal controlled by parameter n and control the frequency of the clock. We find the value of n by solving the equation: 
$$125*10^{6}/2^{n}= 1$$ <br>
This equation is the initial clock frequency divided by 2 to the power of n bits and equalled to a desired frequency of 1Hz, since we would like to achieve a frequency of around 1Hz for our game, and the 2 is the number of values that a single bit can take on. Therefore, 2 raised to the power of n bits is the number of values that can be expressed through n bits. Solving this equation for n gives us a value of around 27. The count register needs to have a bit width of 27 expressed as [26:0], but since this module is dependent on a parameter n we express this count as [n:0] with n being the MSB and the 0 being the LSB. If 
