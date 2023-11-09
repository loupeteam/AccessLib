(*
* File: UA_Lock.st
* Copyright (c) 2023 Loupe
* https://loupe.team
* 
* This file is part of AccessLib, licensed under the MIT License.
* 
*) 

(* Lock or unlock an HMI element based on the current user level 	*)
(* and a minimum required user level 								*)


FUNCTION UA_Lock


IF( CurrentUserLevel >= MinUserLevel )THEN
	StatusDP.1:=	0; // Unlocked //
ELSE
	StatusDP.1:=	1; // Locked //
END_IF

UA_Lock:=	0;


END_FUNCTION
