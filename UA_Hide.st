(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Library: AccessLib
 * File: UA_Hide.st
 * Author: davidblackburn
 * Created: February 12, 2014
 ********************************************************************
 * Implementation of library AccessLib
 ********************************************************************) 

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
