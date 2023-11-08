(*
* File: UA_Logout.st
* Copyright (c) 2023 Loupe
* https://loupe.team
* 
* This file is part of AccessLib, licensed under the MIT License.
* 
*) 


(********************************************************************)
(* Logout function 													*)
(********************************************************************)


(* Reset CurrentUser					DONE and TESTED DFB 20120103 *)

FUNCTION UA_Logout

	brsmemset(ADR(CurrentUser), 0, SIZEOF(CurrentUser));
	CurrentUser.UserName := UA_NOUSER;
	UA_Logout := 0;

END_FUNCTION
