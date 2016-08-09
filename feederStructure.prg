// MOVING VALUES
#accel          200
#deccel         200
#speedXY        60
#speedZ         100
#speedH         -70     //speedXY TO GO HOME


// DIMENSIONS OF THE TABLE
#Xmax           430
#Ymax           210
#Zmax           -50

// INPUTS DECLARATION

#brdSw          IN5
#start          IN6
#preAvail       IN7
#postReady      IN8

//OUTPUTS DECLARATION
#preReady       OUT1
#postAvail      OUT2
#pump           OUT3
#redLED         OUT8



// SETTING THE MOVING VALUES TO THE MOTORS
AccM1 = accel
AccM2 = accel
AccM3 = accel

DecM1 = deccel
DecM2 = deccel
DecM3 = deccel

VmaxM1 = speedXY
VmaxM2 = speedXY
VmaxM3 = speedZ

// DEFINE THE LIMITS
LimRM1 = Xmax
LimRM2 = Ymax
LimLM3 = Zmax


// INIT AND ENABLE INTERRUPT
CFGINT_IN5 = FALL

// WAIT FOR THE OPERATOR TO START THE PROGRAM
WAIT start = 1

// ENABLE THE MOTOR
M1 = ON
M2 = ON
M3 = ON


MAIN :

    // INIT THE SMEMA CONNECTORS
    SET preReady = 0
    SET postAvail = 0

    // SET THE MOTORS TO THEIR HOME POSITION
    HOME M1 speedH
    HOME M2 speedH
    HOME M3 speedZ
    WAITPOS         //WAITING TO BE HOME      
    
    //PICKING THE BOARD
    WAIT preAvail = 1
    JUMP FEED
    SET preReady = 1
    JUMP PICK
    SET preReady = 0

    //GIVE THE BOARD
    JUMP PASTA
    SET postAvail = 1    
    WAIT postReady = 1
    JUMP DROP
    
    // WAIT FOR THE MACHINE TO START PROCESSING THE NEW BOARD
    WAIT postReady = 0
    
JUMP MAIN           //RESTART THE CYCLE



FEED :
    //MOVE TO THE FEEDER
    MOVEPTP @feedXY
    WAITPOS
RETURN

PASTA :
    //MOVE TO THE PASTE MACHINE
    MOVEPTP @pastaXY
    WAITPOS
RETURN



PICK :
    //MOVE DOWN
    MOVEPTP @feedZ
    WHILE brdSw = 0
        // WAIT FOR M3 TO REACH feedZ OR TOUCH A BOARD
        IF StatM3 = M_POS_OK
            JUMP HANDLER
        ENDIF
    ENDWHILE

    SET pump = 1
    //pickBoard
    DELAY 0.5
    
    
    // MOVE UP
    HOME M3 speedZ
    WAITPOS
RETURN



DROP :
    // MOVE DOWN
    MOVEPTP @pastaZ
    WAITPOS

    
    //Drop board
    SET pump = 0
    DELAY 0.5
    
    //MOVE UP
    HOME M3 speedZ
    WAITPOS
RETURN



INT_IN5:
    IF pump = 0
        RETURN
    ELSE
        JUMP HANDLER
    ENDIF


HANDLER :
    SET pump = 0
    SET redLED =1
    WAIT start = 1
    SET redLED = 0
    
JUMP MAIN              // RESTART FROM THE BEGINNING