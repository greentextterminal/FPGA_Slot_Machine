# FPGA Slot Machine <br>
This repo contains the code for a simple slot machine like game implemented via Verilog on a ZYBO Z7 ZYNQ-7010 development board. The board that I used for this project has certain peripherals which I leverage for the logic of the game such as: LED's, switches, and buttons. <br>

## Overview of Game
The code cycles an LED which the user has to "catch" with a switch corresponding to the same LED index position during the same clock cycle in order to win. If the game is won the LEDs will all flash indicating a win until it is reset. The game can be reset and played again by pressing BTN2 (Button 2).
