(*
 * File: UA_Login.st
 * Copyright (c) 2023 Loupe
 * https://loupe.team
 * 
 * This file is part of AccessLib, licensed under the MIT License.
 * 
  ********************************************************************
 * Implementation of library AccessLib
 ********************************************************************) 


(********************************************************************)
(* Login function - checks UserName and Password 					*)
(********************************************************************)


(* Logout								DONE and TESTED DFB 20120103 *)

(* Checking Invalid inputs				DONE and TESTED DFB 20111021 *)
	(* pUserList						DONE and TESTED DFB 20111021 *)
	(* NumUsers							DONE and TESTED DFB 20111021 *)
	(* InputUser						DONE and TESTED DFB 20111021 *)

(* Logging in							DONE and TESTED DFB 20111021 *)
	(* Pointer math						DONE and TESTED DFB 20111021 *)
	(* Good password					DONE and TESTED DFB 20111021 *)
	(* Bad password						DONE and TESTED DFB 20111021 *)

(* User not found						DONE and TESTED DFB 20111021 *)


FUNCTION UA_Login
	
	
(********************************************************)
(* Logout												*)
(********************************************************)

UA_Logout(CurrentUser);


(********************************************************)
(* Check for invalid inputs								*)
(********************************************************)

IF (pUserList = 0) THEN
	UA_Login := UA_ERR_NULLPTR;
	RETURN;
END_IF


IF (NumUsers = 0) THEN
	UA_Login := UA_ERR_NUMUSERS;
	RETURN;
END_IF


IF (brsstrcmp(ADR(InputUser.UserName), ADR('')) = 0) THEN
	UA_Login := UA_ERR_INVALIDUSERNAME;
	RETURN;
END_IF


IF (brsstrcmp(ADR(InputUser.Password), ADR('')) = 0) THEN
	UA_Login := UA_ERR_INVALIDPASSWORD;
	RETURN;
END_IF


(********************************************************)
(* Login												*)
(********************************************************)

FOR i := 0 TO (NumUsers - 1) BY 1 DO
	
	
	(* Get current user *)
	
	dUser ACCESS pUserList + i * SIZEOF(dUser);
 
 	
	(* Check for matching UserName *)
	
 	IF (brsstrcmp(ADR(dUser.UserName), ADR(InputUser.UserName)) = 0) THEN	
 		
		
		(* Check for matching password *)
		
		IF (brsstrcmp(ADR(dUser.Password), ADR(InputUser.Password)) = 0) THEN
		
			
			(* Good login *)
			
   			CurrentUser := dUser;
			CurrentUser.Password := '';
			
			UA_Login := 0;
			RETURN;
   
   		ELSE
			
			(* Passwords do not match *)
			
			UA_Login := UA_ERR_INVALIDPASSWORD;
			RETURN;
   		
		END_IF
  		
		
 	END_IF
	 

END_FOR


(* If you get here, the user name was not found *)

UA_Login := UA_ERR_USERNOTFOUND;


END_FUNCTION
