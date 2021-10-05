(********************************************************************
 * COPYRIGHT -- Automation Resources Group
 ********************************************************************
 * Library: AccessLib
 * File: UA_LoginPasswordOnly.st
 * Author: David Blackburn
 * Created: October 21, 2011
 ********************************************************************
 * Implementation of library AccessLib
 ********************************************************************) 


(********************************************************************)
(* Login function - ignores UserName and only checks Password 		*)
(********************************************************************)


(* Logout								DONE and TESTED DFB 20120103 *)

(* Checking Invalid inputs				DONE and TESTED DFB 20111021 *)
	(* pUserList						DONE and TESTED DFB 20111021 *)
	(* NumUsers							DONE and TESTED DFB 20111021 *)
	(* pInputPassword					DONE and TESTED DFB 20111021 *)

(* Logging in							DONE and TESTED DFB 20111021 *)
	(* Pointer math						DONE and TESTED DFB 20111021 *)
	(* Good password					DONE and TESTED DFB 20111021 *)
	(* Bad password						DONE and TESTED DFB 20111021 *)


FUNCTION UA_LoginPasswordOnly
	
	
(********************************************************)
(* Logout												*)
(********************************************************)

UA_Logout(CurrentUser);


(********************************************************)
(* Check for invalid inputs								*)
(********************************************************)

IF ( 	(pUserList = 0)	
	OR	(pInputPassword = 0)	
	) THEN

	UA_LoginPasswordOnly := UA_ERR_NULLPTR;
	RETURN;

END_IF


IF (NumUsers = 0) THEN

	UA_LoginPasswordOnly := UA_ERR_NUMUSERS;
	RETURN;
	
END_IF


IF (brsstrcmp(pInputPassword, ADR('')) = 0) THEN

	UA_LoginPasswordOnly := UA_ERR_INVALIDPASSWORD;
	RETURN;
	
END_IF


(********************************************************)
(* Login												*)
(********************************************************)

FOR i := 0 TO (NumUsers - 1) BY 1 DO
	
	
	(* Get current user *)
	
	dUser ACCESS pUserList + i * SIZEOF(dUser);
 
 	
	(* Check for matching password *)
	
	IF (brsstrcmp(ADR(dUser.Password), pInputPassword) = 0) THEN	
	
		
		(* Good login *)
		
		CurrentUser := dUser;
		CurrentUser.Password := '';
			
		UA_LoginPasswordOnly := 0;
		RETURN;


	END_IF
	 

END_FOR


(* If you get here, the password was not found *)

UA_LoginPasswordOnly := UA_ERR_INVALIDPASSWORD;


END_FUNCTION
