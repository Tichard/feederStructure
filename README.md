# feederStructure
software for woBIT MIC488 controller controlling a feeder structure

/*
 * [File Name]     README.txt
 * [Platform]      MIC 488
 * [Project]       feederStructure
 * [Version]       1.00
 * [Author]        Richard
 * [Date]          07/18/2016
 * [Language]      txt
 *
 */

This project is a controller of a feeder structure using SMEMA communication protocol. SMEMA details protocol
can be found here: http://ocmmanufacturing.com/wp-content/uploads/2016/01/IPC-SMEMA-9851.pdf
This project has been conceived on and for a WObit MIC488 microcontroller with 3 SMC124 motor drivers.
This project has been developed on WBCProg. You can acces to it launching "MIC448-PC(EN)" -> "Motion Program" -> "Create motion programs (WBCprog)".
You can find "MIC448-PC(EN)" executable in the folder "mi488e-pc_v125_en" or download it from http://www.wobit.com.pl/produkt/10594/kontrolery-ruchu/mic488/
 
 
USER MANUAL : 
Once the system powered, the system wait for the operator to press the start button. It will be fully automomous, waiting for a board to be available, picking it up.
Then go to the next machine location, waiting for it to be ready to accept a new board and finally going to its home position.
The cycle will be repeated as long as there will be board available. 
 

KNOWN BUGS :
--

SUPPORT :
For any requests or informations, please contact: richard.taupiac@gmail.com
