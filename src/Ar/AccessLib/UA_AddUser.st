(*
 * File: UA_AddUser.st
 * Copyright (c) 2023 Loupe
 * https://loupe.team
 * 
 * This file is part of AccessLib, licensed under the MIT License.
 * 
  ********************************************************************
 * Implementation of library AccessLib
 ********************************************************************) 


(********************************************************************)
(* Add a user to the user list										*)
(********************************************************************)


(* Checking Invalid inputs				DONE and TESTED DFB 20111020 *)
	(* pUserList						DONE and TESTED DFB 20111020 *)
	(* NumUsers							DONE and TESTED DFB 20111020 *)
	(* UserName							DONE and TESTED DFB 20111020 *)
	(* Password							DONE and TESTED DFB 20111020 *)

(* Adding user							DONE and TESTED DFB 20111020 *)
	(* Pointer math						DONE and TESTED DFB 20111020 *)
	(* memcpy							DONE and TESTED DFB 20111020 *)

(* Checking for full user list			DONE and TESTED DFB 20111020 *)


FUNCTION UA_AddUser


(********************************************************)
(* Check for invalid inputs								*)
(********************************************************)

IF( pUserList = 0 )THEN

	UA_AddUser:=	UA_ERR_NULLPTR;
	RETURN;

END_IF


IF( NumUsers = 0 )THEN

	UA_AddUser:=	UA_ERR_NUMUSERS;
	RETURN;
	
END_IF


IF( brsstrcmp(ADR(NewUser.UserName), ADR('')) = 0 )THEN

	UA_AddUser:=	UA_ERR_INVALIDUSERNAME;
	RETURN;
	
END_IF


IF( brsstrcmp(ADR(NewUser.Password), ADR('')) = 0 )THEN

	UA_AddUser:=	UA_ERR_INVALIDPASSWORD;
	RETURN;
	
END_IF


(********************************************************)
(* Add user to first empty user index					*)
(********************************************************)

FOR i:=0 TO (NumUsers-1) BY 1 DO
	
	
	(* Get current user *)
	
	dUser ACCESS pUserList + i*SIZEOF(dUser);
 
 	
	(* Check for empty UserName *)
	
 	IF( brsstrcmp(ADR(dUser.UserName), ADR('')) = 0 )THEN	
 		
		
		(* Add NewUser here and exit loop *)
		
		brsmemcpy( ADR(dUser), ADR(NewUser), SIZEOF(NewUser) );
  		
		UA_AddUser:=	0;
		RETURN;
  		
 	END_IF
	 

END_FOR


(* If you get here, then the list was full *)

UA_AddUser:=	UA_ERR_USERLISTFULL;


END_FUNCTION
