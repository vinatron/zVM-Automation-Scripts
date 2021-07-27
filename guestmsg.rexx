/********************************************
* GUESTMSG EXEC written by VINCENT F. MANZO *
*             JULY 27 2021                  *
*   A PROGRAM FOR SYSTEMS ADMINISTRATION    *
*********************************************/

SAY 'INPUT GUEST NAME'                        /* REQUEST INPUT */
PULL USERID                                   /* STORE RESPONCE */
SAY 'CP COMMAND OR CONSOLE COMMAND? CP/CONS'  /* REQUEST INPUT */
PULL CMDTYPE                                  /* STORE RESPONCE */
SAY 'ENTER COMMAND PARAMETER'                 /* REQUEST INPUT */
PULL CMDPARM                                  /* STORE RESPONCE */
'SET OBSERVER' USERID '*'                     /* START PULLING OUTPUT */
IF CMDTYPE = 'CP' THEN DO                     /* CHECK CONDITONAL 1 */
 'CP SEND' USERID CMDPARM                     /* SEND CP COMMAND */
 SAY 'EXECUTION COMPLETE, TERMINATING'        /* NOTIFY USER */
 'SET OBSERVER' USERID 'OFF'                  /* QUIT RECEIVING OUTPUT */
 END                                          /* END CONDITONAL 1 */
ELSE                                          /* CHECK CONDITONAL 1 */
 IF CMDTYPE = 'CONS' THEN DO                  /* CHECK CONDITONAL 1.5 */
  'CP SEND' USERID 'VI VMSG' CMDPARM          /* SEND OS COMMAND */
  SAY 'EXECUTION COMPLETE, TERMINATING'       /* NOTIFY USER */
  'SET OBSERVER' USERID 'OFF'                 /* QUIT RECEIVING OUTPUT */
  END                                         /* END CONDITONAL 1.5 */
 ELSE                                         /* CHECK CONDITONAL 1.5 */
  SAY 'INVALID CHOICE, TERMINATING'           /* NOTIFY USER */
