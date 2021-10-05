(********************************************************************
 * COPYRIGHT -- Automation Resources Group
 ********************************************************************
 * Library: AccessLib
 * File: UA_ListUsers.st
 * Author: David Blackburn
 * Created: October 21, 2011
 ********************************************************************
 * Implementation of library AccessLib
 ********************************************************************) 


(********************************************************************)
(* List all of the users with user name and level 					*)
(********************************************************************)


(* Checking Invalid inputs				DONE and TESTED DFB 20111021 *)
	(* pUserList						DONE and TESTED DFB 20111021 *)
	(* NumUsers							DONE and TESTED DFB 20111021 *)
	(* pStringArray						DONE and TESTED DFB 20111021 *)
	(* NumStrings						DONE and TESTED DFB 20111021 *)
	(* StringLength						DONE and TESTED DFB 20111021 *)

(* Listing users						DONE and TESTED DFB 20111021 *)
	(* Pointer math						DONE and TESTED DFB 20111021 *)
	(* Rest								DONE and TESTED DFB 20111021 *)


FUNCTION UA_ListUsers


(********************************************************)
(* Check for invalid inputs								*)
(********************************************************)

IF( 	(pUserList = 0)
	OR	(pStringArray = 0)
 	)THEN

	UA_ListUsers:=	UA_ERR_NULLPTR;
	RETURN;

END_IF


IF( NumUsers = 0 )THEN

	UA_ListUsers:=	UA_ERR_NUMUSERS;
	RETURN;
	
END_IF


IF( NumStrings = 0 )THEN

	UA_ListUsers:=	UA_ERR_NUMSTRINGS;
	RETURN;
	
END_IF


IF( StringLength = 0 )THEN

	UA_ListUsers:=	UA_ERR_STRINGLENGTH;
	RETURN;
	
END_IF


(********************************************************)
(* List users											*)
(********************************************************)


(* Find minimum of NumUsers and NumStrings *)

IF( NumUsers < NumStrings )THEN

	LoopEndIndex:=	NumUsers - 1;
	
ELSE
	
	LoopEndIndex:=	NumStrings - 1;
	
END_IF


(* Clear string array *)

brsmemset( pStringArray, 0, NumStrings*StringLength );

(* List out users *)

FOR i:=0 TO LoopEndIndex BY 1 DO
	
	
	(* Get current user *)
	
	dUser ACCESS pUserList + i*SIZEOF(dUser);
 
 	
	(* Copy UserName, then User Level *)
	
	pCurrString:=	pStringArray + i*StringLength;
	
	brsstrcpy(	pCurrString, ADR(dUser.UserName) );
	brsstrcat(	pCurrString, ADR(', Level ') );
	brsitoa(	dUser.UserLevel, ADR(UserLevelString) );
	brsstrcat(	pCurrString, ADR(UserLevelString) );
		
	
END_FOR


(* All done *)

UA_ListUsers:=	0;
RETURN;
  	

END_FUNCTION
