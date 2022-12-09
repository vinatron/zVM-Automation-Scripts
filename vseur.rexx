/******************************************************
*        VSEUR EXEC WRITTEN BY VINCENT F. MANZO       *
*                  DECEMBER 9 2022                    *
* A PROGRAM FOR ASSISTING STARTING UR DEVICES FOR VSE *
******************************************************/

TRACE E                                      /* ERROR TRACING */

/* GRAB ARGUMENTS */
PARSE ARG USERID ACTION

/* BANNER START */
SAY "STARTING VINATRON'S VSE UR MANAGMENT FACILITY"
SAY 'PROPERTY OF:'                           /* BANNER */
SAY 'VINATRON TECHNOLOGY AND ELECTRICAL'     /* BANNER END */

SIGNAL ON ERROR                              /* TEST RC OF COMMANDS */

IF LENGTH(USERID) = 0 THEN DO                /* TEST ARG USERID */
 SAY 'WHAT USERID IS THE VSE GUEST?'         /* REQUEST INPUT */
 PULL USERID                                 /* STORE USERID */
END                                          /* END IF TEST ARG */
IF LENGTH(ACTION) = 0 THEN DO                /* TEST ARG ACTION */
 /* REQUEST INPUT */
 SAY 'WHAT ACTION WOULD YOU LIKE TO PREFORM? START or STOP?'
 PULL ACTION                                 /* STORE ACTION */
END                                          /* END IF TEST ARG */

EVAL:                                        /* EVALUATE ACTION VAR */
IF ACTION = 'START' THEN DO                  /* TEST ACTION = START */
 CALL START_UR                               /* CALL SUB START_UR */
 SIGNAL TERM                                 /* JUMP TO TERMINATION MARKER */
END                                          /* END EVAL */
IF ACTION = 'STOP' THEN DO                   /* TEST ACTION = STOP */
 CALL STOP_UR                                /* CALL SUB STOP_UR */
 SIGNAL TERM                                 /* JUMP TO TERMINATION MARKER */
END                                          /* END EVAL */
IF (ACTION \= 'START') | (ACTION \= 'STOP') THEN DO /* TEST ACTION INVALID */
 SAY 'INVALID ACTION PROGRAM WILL REREQUEST INPUT!' /* NOTIFY USER */
 /* REQUEST INPUT */
 SAY 'WHAT ACTION WOULD YOU LIKE TO PREFORM? START or STOP?'
 PULL ACTION                                 /* STORE ACTION */
 SIGNAL EVAL                                 /* JUMP TO REEVALUATE */
END                                          /* END EVAL */

TERM:                                        /* TERMINATION MARKER */
EXIT                                         /* END OF PROGRAM */

/******************************
* START UR DEVICES SUBROUTINE *
******************************/
START_UR:
 'CP SET SECUSER' USERID '*'    /* SET SECUSER TO CURRENT USER */
 'CP SLEEP 1 SEC'               /* WAIT 1 SECOND */
 SAY 'STARTING UR DEVICES FOR' USERID 'PLEASE WAIT...' /* NOTIFY USER */
 'CP SLEEP 1 SEC'               /* WAIT 1 SECOND */
 SAY 'STARTING READER 00C'      /* NOTIFY USER */
 'CP SEND' USERID 'S RDR,00C'   /* SEND COMMAND TO VSE/POWER */
 'CP SLEEP 1 SEC'               /* WAIT 1 SECOND */
 SAY 'STARTING PUNCH 00D'       /* NOTIFY USER */
 'CP SEND' USERID 'S PUN,00D,B' /* SEND COMMAND TO VSE/POWER */
 'CP SLEEP 1 SEC'               /* WAIT 1 SECOND */ 
 SAY 'STARTING PRINTER 00E'     /* NOTIFY USER */
 'CP SEND' USERID 'S LST,00E,A' /* SEND COMMAND TO VSE/POWER */
 'CP SLEEP 1 SEC'               /* WAIT 1 SECOND */
 'CP SEND' USERID 'PGO 00E'     /* SEND COMMAND TO VSE/POWER */
 'CP SLEEP 1 SEC'               /* WAIT 1 SECOND */
 SAY 'STARTING PRINTER 00F'     /* NOTIFY USER */
 'CP SEND' USERID 'S LST,00F,P' /* SEND COMMAND TO VSE/POWER */
 'CP SLEEP 1 SEC'               /* WAIT 1 SECOND */
 'CP SEND' USERID 'PGO 00F'     /* SEND COMMAND TO VSE/POWER */
 'CP SLEEP 1 SEC'               /* WAIT 1 SECOND */
 SAY 'UR DEVICES FOR' USERID 'STARTED' /* NOTIFY USER */
 'CP SLEEP 1 SEC'               /* WAIT 1 SECOND */
 'CP SET SECUSER' USERID 'OPERATOR' /* SET SECUSER BACK TO OPERATOR */
 'CP SLEEP 1 SEC'               /* WAIT 1 SECOND */
RETURN

/*****************************
* STOP UR DEVICES SUBROUTINE *
*****************************/
STOP_UR:
 'CP SET SECUSER' USERID '*'    /* SET SECUSER TO CURRENT USER */
 'CP SLEEP 1 SEC'               /* WAIT 1 SECOND */
 SAY 'STOPPING UR DEVICES FOR' USERID 'PLEASE WAIT...' /* NOTIFY USER */
 'CP SLEEP 1 SEC'               /* WAIT 1 SECOND */
 SAY 'STOPPING READER 00C'      /* NOTIFY USER */
 'CP SEND' USERID 'P 00C'       /* SEND COMMAND TO VSE/POWER */
 'CP SLEEP 1 SEC'               /* WAIT 1 SECOND */
 SAY 'STOPPING PUNCH 00D'       /* NOTIFY USER */
 'CP SEND' USERID 'P 00D'       /* SEND COMMAND TO VSE/POWER */
 'CP SLEEP 1 SEC'               /* WAIT 1 SECOND */
 SAY 'STOPPING PRINTER 00E'     /* NOTIFY USER */
 'CP SEND' USERID 'P 00E'       /* SEND COMMAND TO VSE/POWER */
 'CP SLEEP 1 SEC'               /* WAIT 1 SECOND */
 SAY 'STOPPING PRINTER 00F'     /* NOTIFY USER */
 'CP SEND' USERID 'P 00F'       /* SEND COMMAND TO VSE/POWER */
 'CP SLEEP 1 SEC'               /* WAIT 1 SECOND */
 SAY 'UR DEVICES FOR' USERID 'STOPPED' /* NOTIFY USER */
 'CP SLEEP 1 SEC'               /* WAIT 1 SECOND */
 'CP SET SECUSER' USERID 'OPERATOR' /* SET SECUSER BACK TO OPERATOR */
 'CP SLEEP 1 SEC'               /* WAIT 1 SECOND */
RETURN

/*******************************************************/
/* ERROR HANDLER: COMMON EXIT FOR NONZERO RETURN CODES */
/*******************************************************/
ERROR:
SAY "UNEXPECTED RC" RC "FROM COMMAND:"
SAY "     " SOURCELINE(SIGL)
SAY "AT LINE" SIGL"."
