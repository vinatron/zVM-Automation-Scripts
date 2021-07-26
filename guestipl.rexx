/********************************************
* GUESTIPL EXEC written by VINCENT F. MANZO *
*             JULY 22 2021                  *
*      A PROGRAM FOR SYSTEMS AUTOMATION     *
*********************************************/

SAY 'DO YOU WANT TO IPL ALL GUESTS? Y/N'      /* REQUEST INPUT */
PULL ANSWER1                                  /* STORE RESPONCE */
IF ANSWER1 = 'Y' THEN DO                      /* CHECK CONDITONAL 1 */
 SAY 'PREFORMING IPL OF GUESTS: PLEASE WAIT'  /* NOTIFY USER */
 CALL ALLGUESTSIPL                            /* CALL SUB */
 END                                          /* END CONTITONAL 1 */
ELSE                                          /* CHECK CONDITONAL 1 */
 IF ANSWER1 = 'N' THEN DO                     /* CHECK CONDITONAL 1.5 */
  SAY 'WOULD YOU LIKE TO USE THE PANEL INTERFACE? Y/N'/* REQUEST INPUT */
  PULL ANSWER2                                /* STORE RESPONCE */
  IF ANSWER2 = 'Y' THEN                       /* CHECK CONDITONAL 2 */
   SAY 'OK LAUNCHING PANEL: PLEASE WIAT...'   /* NOTIFY USER */
  ELSE                                        /* CHECK CONDITONAL 2 */
   IF ANSWER2 = 'N' THEN DO                   /* CHECK CONDITONAL 2.5 */
    SAY 'LAUNCHING INTERACTIVE MODE: PLEASE WAIT...'    /* NOTIFY USER */
    CALL GUESTIPL                             /* CALL SUB */
    END                                       /* END CONDITONAL 2.5 */
   ELSE
    SAY 'INVALID INPUT TERMINATING'           /* NOTIFY USER */
    END
 ELSE                                         /* CHECK CONDITONAL 1.5 */
  SAY 'INVALID INPUT TERMINATING'             /* NOTIFY USER */
EXIT                                          /* END OF PROGRAM */
/********************************************
* IPL ALL GUESTS SUBROUTINE                 *
*********************************************/
ALLGUESTSIPL:                                 /* BEGINING OF SUB */
 LINENO = 1                                   /* SET LINE AT TOP */
 DO UNTIL LINES(GUESTS LIST A) = 0            /* LIST LINES */
  USERID = LINEIN(GUESTS LIST A)              /* PULL LINE VALUE */
  SAY 'PERFORMING IPL FOR GUEST' USERID       /* NOTIFY USER */
  'CP XAUTOLOG' USERID                        /* AUTOLOG VAR USERID */
  SAY 'IPL FOR' USERID 'COMPLETE'             /* NOTIFY USER */
  LINENO = LINENO + 1                         /* INCRIMENT LINE */
 END                                          /* END LIST LINES */
RETURN                                        /* END OF SUB */

/********************************************
* IPL SELECTED GUESTS ONLY SUBROUTINE       *
*********************************************/
GUESTIPL:
 LINENO = 1                                   /* SET LINE AT TOP */
 DO UNTIL LINES(GUESTS LIST A) = 0            /* LIST LINES */
  USERID = LINEIN(GUESTS LIST A)              /* PULL LINE VALUE */
  SAY 'DO YOU WANT TO IPL GUEST' USERID 'Y/N' /* REQUEST INPUT */
  PULL ANSWER3                                /* STORE RESPONCE */
  IF ANSWER3 = 'Y' THEN DO                    /* CHECK CONDITONAL 1 */
   SAY 'PERFORMING IPL FOR GUEST' USERID      /* NOTIFY USER */
   'CP XAUTOLOG' USERID                       /* AUTOLOG VAR USERID */
   SAY 'IPL FOR' USERID 'COMPLETE'            /* NOTIFY USER */
   LINENO = LINENO + 1                        /* INCRIMENT LINE */
   END                                        /* END CONDITONAL 1 */
  ELSE                                        /* CHECK CONDITONAL 1 */
   IF ANSWER3 = 'N' THEN DO                   /* CHECK CONDITONAL 1.5 */
    SAY 'SKIPPING IPL FOR GUEST' USERID       /* NOTIFY USER */
    LINENO = LINENO + 1                       /* INCRIMENT LINE */
    END                                       /* END CONDITONAL 1.5 */
   ELSE DO                                    /* CHECK CONDITONAL 1.5 */
    SAY 'INVALID INPUT SKIPPING' USERID       /* NOTIFY USER */
    LINENO = LINENO + 1                       /* INCRIMENT LINE */
    END                                       /* END CONDITIONAL 1.5 */
 END                                          /* END LIST LINES */
RETURN                                        /* END OF SUB */