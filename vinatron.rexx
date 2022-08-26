/********************************************
* VINATRON EXEC WRITTEN BY VINCENT F. MANZO *
*             JULY 24 2021                  *
*      A PROGRAM FOR SYSTEMS AUTOMATION     *
*********************************************/

TRACE E                                      /* ERROR TRACING */

SAY "STARTING VINATRON'S SYSTEM AUTOMATION"  /* BANNER START */
SAY 'PROPERTY OF:'                           /* BANNER */
SAY 'VINATRON TECHNOLOGY AND ELECTRICAL'     /* BANNER END */
SAY 'STARTING UNIT RECORD DEVICES:'          /* NOTIFY OPERATOR */
SAY 'PLEASE WAIT....'                        /* NOTIFY OPERATOR */

SIGNAL ON ERROR                              /* TEST RC OF COMMANDS */

SAY 'STARTING UR DEVICES IN FILE URDEV LIST) /* NOTIFY OPERATOR */
CALL STARTUR                                 /* CALL SUB */
SAY 'ALL UNIT RECORD DEVICES STARTED'        /* NOTIFY OPERATOR */
SAY 'ENABLING ALL CONSOLES'                  /* NOTIFY OPERATOR */
'CP ENABLE ALL'                              /* ENABLE ALL CONSOLES */
SAY 'DISABLING DEDICATED CONSOLES:'          /* NOTIFY OPERATOR */
SAY 'IN ADDRESS LIST'                        /* NOTIFY OPERATOR */
SAY 'PLEASE WAIT....'                        /* NOTIFY OPERATOR */
LINENO = 1                                   /* SET LINE AT TOP */
DO UNTIL LINES(ADDRESS LIST A) = 0           /* LIST LINES */
   DEVADDR = LINEIN(ADDRESS LIST A)          /* PULL LINE VALUE */
   SAY 'DISABLING CUU' DEVADDR               /* NOTIFY OPERATOR */
   'CP DISABLE' DEVADDR                      /* DISABLE VAR ADDRESS */
   LINENO = LINENO + 1                       /* INCRIMENT LINE */
END                                          /* END LIST LINES */
SAY 'AUTOMATION COMPLETE!'                   /* BANNER START */
SAY 'THANK YOU FOR USING OUR PRODUCT!'       /* BANNER END */
EXIT                                         /* END OF PROGRAM */

/********************************************
* START ALL UR DEVICES                      *
*********************************************/
STARTUR:                                      /* BEGINING OF SUB */
 LINENO = 1                                   /* SET LINE AT TOP */
 DO UNTIL LINES(URDEV LIST A) = 0             /* LIST LINES */
  URDEVADDR = LINEIN(URDEV LIST A)            /* PULL LINE VALUE */    
  SAY 'STARTING UR DEVICE' URDEVADDR          /* NOTIFY USER */
  'CP START' URDEVADDR                        /* AUTOLOG VAR USERID */
  SAY 'UR DEVICE' URDEVADDR 'STARTED'         /* NOTIFY USER */
  LINENO = LINENO + 1                         /* INCRIMENT LINE */
 END                                          /* END LIST LINES */
RETURN                                        /* END OF SUB */

/*******************************************************/
/* ERROR HANDLER: COMMON EXIT FOR NONZERO RETURN CODES */
/*******************************************************/
ERROR:
SAY "UNEXPECTED RC" RC "FROM COMMAND:"
SAY "     " SOURCELINE(SIGL)
SAY "AT LINE" SIGL"."

