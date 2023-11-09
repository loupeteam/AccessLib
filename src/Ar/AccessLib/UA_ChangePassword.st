(*
* File: UA_ChangePassword.st
* Copyright (c) 2023 Loupe
* https://loupe.team
* 
* This file is part of AccessLib, licensed under the MIT License.
* 
*) 


(********************************************************************)
(* Change a user's password 										*)
(********************************************************************)


(* Checking Invalid inputs				DONE and TESTED DFB 20111020 *)
	(* pUserList						DONE and TESTED DFB 20111020 *)
	(* NumUsers							DONE and TESTED DFB 20111020 *)
	(* pUserName						DONE and TESTED DFB 20111020 *)
	(* pOldPassword						DONE and TESTED DFB 20111020 *)
	(* pNewPassword						DONE and TESTED DFB 20111020 *)

(* Changing password					DONE and TESTED DFB 20111020 *)
	(* Pointer math						DONE and TESTED DFB 20111020 *)
	(* Good password					DONE and TESTED DFB 20111020 *)
	(* Bad password						DONE and TESTED DFB 20111020 *)

(* User not found						DONE and TESTED DFB 20111020 *)


FUNCTION UA_ChangePassword


(********************************************************)
(* Check for invalid inputs								*)
(********************************************************)

IF( 	(pUserList = 0)
	OR	(pUserName = 0)
 	OR	(pOldPassword = 0)	
 	OR	(pNewPassword = 0)	
	)THEN

	UA_ChangePassword:=	UA_ERR_NULLPTR;
	RETURN;

END_IF


IF( NumUsers = 0 )THEN

	UA_ChangePassword:=	UA_ERR_NUMUSERS;
	RETURN;
	
END_IF


IF( brsstrcmp(pUserName, ADR('')) = 0 )THEN

	UA_ChangePassword:=	UA_ERR_INVALIDUSERNAME;
	RETURN;
	
END_IF


IF( 	(brsstrcmp(pOldPassword, ADR('')) = 0)
	OR	(brsstrcmp(pNewPassword, ADR('')) = 0)
 	)THEN

	UA_ChangePassword:=	UA_ERR_INVALIDPASSWORD;
	RETURN;
	
END_IF


(********************************************************)
(* Change password										*)
(********************************************************)

FOR i:=0 TO (NumUsers-1) BY 1 DO
	
	
	(* Get current user *)
	
	dUser ACCESS pUserList + i*SIZEOF(dUser);
 
 	
	(* Check for matching UserName *)
	
 	IF( brsstrcmp(ADR(dUser.UserName), pUserName) = 0 )THEN	
 		
		
		(* Check for matching password *)
		
		IF( brsstrcmp(ADR(dUser.Password), pOldPassword) = 0 )THEN	
		
			
			(* Change password and done *)
			
			brsstrcpy( ADR(dUser.Password), pNewPassword );
   
   			UA_ChangePassword:=	0;
			RETURN;
   
   		ELSE
			
			(* Passwords do not match *)
			
			UA_ChangePassword:=	UA_ERR_INVALIDPASSWORD;
			RETURN;
   		
		END_IF
  		
 	END_IF
	 

END_FOR


(* If you get here, the user name was not found *)

UA_ChangePassword:=	UA_ERR_USERNOTFOUND;


END_FUNCTION
