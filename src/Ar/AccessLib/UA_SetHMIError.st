(*
 * File: UA_SetHMIError.st
 * Copyright (c) 2023 Loupe
 * https://loupe.team
 * 
 * This file is part of AccessLib, licensed under the MIT License.
 * 
  ********************************************************************
 * Implementation of library AccessLib
 ********************************************************************) 


(********************************************************************)
(* Set the error status on an HMI object 							*)
(********************************************************************)


(* Set Error				DONE and TESTED DFB 20120103 *)
(* Set ErrorID				DONE and TESTED DFB 20120103 *)
(* Set ErrorString			DONE and TESTED DFB 20120103 *)
	

FUNCTION UA_SetHMIError


(****************************************************)
(* Set return value to get rid of compile warning 	*)
(****************************************************)

UA_SetHMIError:=	FALSE;


(************************************************)
(* Set error status								*)
(************************************************)

t.Error:=		1;
t.ErrorID:=		ErrorID;


(* Set ErrorString *)

CASE ErrorID OF
	
	0: t.ErrorString:=	'';
	
	ELSE	t.ErrorString:=	'Error accessing VC object. Automatic logout will not function. Check IN.CFG.VCName. If VC is a terminal object, check terminal connection.';
	
//	ELSE	t.ErrorString:=	'Unknown error.';
	
END_CASE


END_FUNCTION
