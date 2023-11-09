(*
* File: UA_GetTouchAction.st
* Copyright (c) 2023 Loupe
* https://loupe.team
* 
* This file is part of AccessLib, licensed under the MIT License.
* 
*) 


(********************************************************************)
(* Wrapper for VA_GetTouchAction visapi function 					*)
(********************************************************************)


(* VA_Setup							DONE and TESTED DFB 20120103 *)
	(* No error						DONE and TESTED DFB 20120103 *)
	(* Error						DONE and TESTED DFB 20120103 *)
	
(* VA_Saccess						DONE and TESTED DFB 20120103 *)

	(* Done							DONE and TESTED DFB 20120103 *)

		(* VA_GetTouchAction		DONE and TESTED DFB 20120103 *)
			(* Done press			DONE and TESTED DFB 20120103 *)
			(* Done no press		DONE and TESTED DFB 20120103 *)
			(* Busy					DONE will not be tested *)
			(* Error				DONE will not be tested *)
			
		(* VA_Srelease				DONE and TESTED DFB 20120103 *)
	
	(* Busy							DONE and TESTED DFB 20120103 *)

	(* Error						DONE will not be tested *)
	

FUNCTION UA_GetTouchAction


(* Return value is set to UA_GTA_BUSY if screen is busy and UA_GTA_FINISHED if code completed.
	This will allow you to step through VC objects based on a UA_GTA_FINISHED status from this function *)


(* Reset ScreenPress and Error info - it will be set below if appropriate *)

t.ScreenPress:=	0;

t.Error:=		0;
t.ErrorID:=		0;
t.ErrorString:=	'';


(* Get VCHandle *)

t.VCHandle:=	VA_Setup(1, t.VCName);


IF( t.VCHandle = 0 )THEN

	UA_SetHMIError( DINT_TO_UINT(UA_ERR_VCHANDLE), t );

	UA_GetTouchAction:=	UA_GTA_FINISHED;
	
	RETURN;

END_IF
	
		
(* Call VA_Saccess *)

t.AccessStatus:=	VA_Saccess(1, t.VCHandle);


IF( t.AccessStatus = 0 )THEN
	

	(* Have access to screen, try to get touch action *)
	
	t.GetTouchActionStatus:=	VA_GetTouchAction(1, t.VCHandle, 1, ADR(t.TouchAction) );

														
	(* Check GetTouchAction status *)
	
	IF( (t.GetTouchActionStatus = 0)	)THEN
		
		
		(* Success - someone touched the screen *)
		
		t.ScreenPress:=	1;
		
		UA_GetTouchAction:=	UA_GTA_FINISHED;
				
			
	ELSIF( (t.GetTouchActionStatus = UA_ERR_NODATA)	)THEN
		
		
		(* Success - nobody touched the screen *)
		
		UA_GetTouchAction:=	UA_GTA_FINISHED;
		
			
	ELSIF( (t.GetTouchActionStatus = UA_ERR_SCRNBUSY) )THEN
		
		
		(* Busy, try again *)
		
		UA_GetTouchAction:=	UA_GTA_BUSY;
		
	ELSE
		
		(* error with VA_GetTouchAction *)
		
		UA_SetHMIError( t.GetTouchActionStatus, t );
		
		UA_GetTouchAction:=	UA_GTA_FINISHED;
		
	END_IF
	
	
	(* Had access to screen, free up screen *)
	
	t.ReleaseStatus:=	VA_Srelease(1, t.VCHandle);
	

(* If there is an access error *)

ELSIF( t.AccessStatus = UA_ERR_SCRNBUSY )THEN

	
	(* Screen is busy, need to try again *)
	
	UA_GetTouchAction:=	UA_GTA_BUSY;
	

ELSE
	
	
	(* Other error, need to report error *)
	
	UA_SetHMIError( t.AccessStatus, t );
	
	UA_GetTouchAction:=	UA_GTA_FINISHED;
	
	
END_IF (* access error - can happen if terminal client is restarted and server is not *)


END_FUNCTION
