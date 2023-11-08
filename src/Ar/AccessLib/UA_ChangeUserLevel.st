(*
* File: UA_ChangeUserLevel.st
* Copyright (c) 2023 Loupe
* https://loupe.team
* 
* This file is part of AccessLib, licensed under the MIT License.
* 
*) 


(********************************************************************)
(* Change a user's user level 										*)
(********************************************************************)


(* Checking Invalid inputs				DONE and TESTED DFB 20111021 *)
	(* pUserList						DONE and TESTED DFB 20111021 *)
	(* NumUsers							DONE and TESTED DFB 20111021 *)
	(* pUserName						DONE and TESTED DFB 20111021 *)

(* Changing user level					DONE and TESTED DFB 20111021 *)
	(* Pointer math						DONE and TESTED DFB 20111021 *)
	(* Setting user level				DONE and TESTED DFB 20111021 *)
	
(* User not found						DONE and TESTED DFB 20111021 *)


FUNCTION UA_ChangeUserLevel


(********************************************************)
(* Check for invalid inputs								*)
(********************************************************)

IF( 	(pUserList = 0)
	OR	(pUserName = 0)
 	)THEN

	UA_ChangeUserLevel:=	UA_ERR_NULLPTR;
	RETURN;

END_IF


IF( NumUsers = 0 )THEN

	UA_ChangeUserLevel:=	UA_ERR_NUMUSERS;
	RETURN;
	
END_IF


IF( brsstrcmp(pUserName, ADR('')) = 0 )THEN

	UA_ChangeUserLevel:=	UA_ERR_INVALIDUSERNAME;
	RETURN;
	
END_IF


(********************************************************)
(* Change user level									*)
(********************************************************)

FOR i:=0 TO (NumUsers-1) BY 1 DO
	
	
	(* Get current user *)
	
	dUser ACCESS pUserList + i*SIZEOF(dUser);
 
 	
	(* Check for matching UserName *)
	
 	IF( brsstrcmp(ADR(dUser.UserName), pUserName) = 0 )THEN	
 		
		
		(* Change user level *)
			
		dUser.UserLevel:=	NewUserLevel;
   
		UA_ChangeUserLevel:=	0;
		RETURN;
   
  		
 	END_IF
	 

END_FOR


(* If you get here, the user name was not found *)

UA_ChangeUserLevel:=	UA_ERR_USERNOTFOUND;


END_FUNCTION
