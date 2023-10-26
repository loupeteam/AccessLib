(********************************************************************
 * COPYRIGHT -- Automation Resources Group
 ********************************************************************
 * Library: AccessLib
 * File: UA_Logout.st
 * Author: David Blackburn
 * Created: January 03, 2012
 ********************************************************************
 * Implementation of library AccessLib
 ********************************************************************) 


(********************************************************************)
(* Logout function 													*)
(********************************************************************)


(* Reset CurrentUser					DONE and TESTED DFB 20120103 *)

FUNCTION UA_Logout

	brsmemset(ADR(CurrentUser), 0, SIZEOF(CurrentUser));
	CurrentUser.UserName := UA_NOUSER;
	UA_Logout := 0;

END_FUNCTION
