(*
* File: UA_Hide.st
* Copyright (c) 2023 Loupe
* https://loupe.team
* 
* This file is part of AccessLib, licensed under the MIT License.
* 
*) 

(* Show or hide an HMI element based on the current user level 		*)
(* and a minimum required user level 								*)

 
FUNCTION UA_Hide


IF( CurrentUserLevel >= MinUserLevel )THEN
	StatusDP.0:=	0; // Visible //
ELSE
	StatusDP.0:=	1; // Hidden //
END_IF

UA_Hide:=	0;


END_FUNCTION
