(********************************************************************
 * COPYRIGHT -- Automation Resources Group
 ********************************************************************
 * Library: AccessLib
 * File: UA_RemoveUser.st
 * Author: David Blackburn
 * Created: October 20, 2011
 ********************************************************************
 * Implementation of library AccessLib
 ********************************************************************) 


(********************************************************************)
(* Remove a user from the user list 								*)
(********************************************************************)


(* Checking Invalid inputs				DONE and TESTED DFB 20111020 *)
	(* pUserList						DONE and TESTED DFB 20111020 *)
	(* NumUsers							DONE and TESTED DFB 20111020 *)
	(* pUserName						DONE and TESTED DFB 20111020 *)
	(* UserName							DONE and TESTED DFB 20111020 *)

(* Removing user						DONE and TESTED DFB 20111020 *)
	(* Pointer math						DONE and TESTED DFB 20111020 *)
	(* memset							DONE and TESTED DFB 20111020 *)
	
(* User not found						DONE and TESTED DFB 20111020 *)


FUNCTION UA_RemoveUser


(********************************************************)
(* Check for invalid inputs								*)
(********************************************************)

IF( 	(pUserList = 0)
	OR	(pUserName = 0)
 	)THEN

	UA_RemoveUser:=	UA_ERR_NULLPTR;
	RETURN;

END_IF


IF( NumUsers = 0 )THEN

	UA_RemoveUser:=	UA_ERR_NUMUSERS;
	RETURN;
	
END_IF


IF( brsstrcmp(pUserName, ADR('')) = 0 )THEN

	UA_RemoveUser:=	UA_ERR_INVALIDUSERNAME;
	RETURN;
	
END_IF


(********************************************************)
(* Remove user 											*)
(********************************************************)

FOR i:=0 TO (NumUsers-1) BY 1 DO
	
	
	(* Get current user *)
	
	dUser ACCESS pUserList + i*SIZEOF(dUser);
 
 	
	(* Check for matching UserName *)
	
 	IF( brsstrcmp(ADR(dUser.UserName), pUserName) = 0 )THEN	
 		
		
		(* Remove user and return *)
		
		brsmemset( ADR(dUser), 0, SIZEOF(dUser) );
  		
		UA_RemoveUser:=	0;
		RETURN;
  		
 	END_IF
	 

END_FOR


(* If you get here, the user name was not found *)

UA_RemoveUser:=	UA_ERR_USERNOTFOUND;


END_FUNCTION
