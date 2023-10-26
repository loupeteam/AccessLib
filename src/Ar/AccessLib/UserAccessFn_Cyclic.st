(*
 * File: UserAccessFn_Cyclic.st
 * Copyright (c) 2023 Loupe
 * https://loupe.team
 * 
 * This file is part of AccessLib, licensed under the MIT License.
 * 
  ********************************************************************
 * Implementation of library AccessLib
 ********************************************************************) 


(********************************************************************)
(* Cyclic function for controlling user access levels 				*)
(********************************************************************)


(* Login									DONE and TESTED DFB 20111021 *)
	(* Valid login							DONE and TESTED DFB 20111021 *)
	(* Invalid login						DONE and TESTED DFB 20111021 *)
	(* Status outputs						DONE and TESTED DFB 20111021 *)
	(* Logging								DONE and TESTED DFB 20140108 *)
	
(* Manual Logout							DONE and TESTED DFB 20120103 *)
	(* Status outputs						DONE and TESTED DFB 20120103 *)
	(* Logging								DONE and TESTED DFB 20140108 *)

(* Auto logout								DONE and TESTED DFB 20111018 *)
	(* Disabling							DONE and TESTED DFB 20111018 *)
	(* GetTouchAction handling				DONE and TESTED DFB 20120103 *)
	(* Status outputs						DONE and TESTED DFB 20111018 *)
	(* Timer handling						DONE and TESTED DFB 20110418 *)
	(* Logging out CurrentUser				DONE and TESTED DFB 20120103 *)
	(* Logging								DONE and TESTED DFB 20140108 *)


FUNCTION UserAccessFn_Cyclic


	(********************************************************************************)
	(* Set return value to get rid of compile warning 								*)
	(********************************************************************************)

	UserAccessFn_Cyclic:=	FALSE;

	IF (t.IN.CFG.LoggerName = '') THEN
		t.IN.CFG.LoggerName := UA_DEFAULT_LOGGERNAME;
	END_IF
	

	(********************************************************************************)
	(* Login										 								*)
	(********************************************************************************)


	IF( t.IN.CMD.Login )THEN

	
		(* Reset CMD *)
	
		t.IN.CMD.Login:=	0;
	
	
		(* Login *)
	
		IF( t.IN.CFG.LoginMode = UA_MODE_PASSWORDONLY )THEN
 	
			t.Internal.LoginStatus:=	UA_LoginPasswordOnly( t.IN.CFG.pUserList, 
			t.IN.CFG.NumUsers, 
			ADR(t.IN.PAR.InputUser.Password), 
			t.OUT.STAT.CurrentUser );
															
		
		ELSE
		
			t.Internal.LoginStatus:=	UA_Login( t.IN.CFG.pUserList, 
			t.IN.CFG.NumUsers, 
			t.IN.PAR.InputUser,
			t.OUT.STAT.CurrentUser );
															
		
		END_IF (* LoginMode *)
	
	
		IF( t.Internal.LoginStatus = 0 )THEN
	
			t.OUT.STAT.ValidLogin:=	1;
		
			Args.s[0]:=	ADR(t.OUT.STAT.CurrentUser.UserName);
			Args.i[0]:=	t.OUT.STAT.CurrentUser.UserLevel;
			logInfo( t.IN.CFG.LoggerName, 50000, 'User Login: %s, Level %i', ADR(Args) );
		
		ELSE
		
			t.OUT.STAT.InvalidLogin:=	1;
		
			logInfo( t.IN.CFG.LoggerName, 50000, 'Unsuccessful Login Attempt', ADR(Args) );
		
		END_IF
	
	
		(* Reset InputUser *)
	
		brsmemset( ADR(t.IN.PAR.InputUser), 0, SIZEOF(t.IN.PAR.InputUser) );
	

	END_IF


	(************************************************)
	(* Reset Login status after timeout				*)
	(************************************************)

	t.Internal.LoginStatusTimer.IN:=	t.OUT.STAT.ValidLogin OR t.OUT.STAT.InvalidLogin;
	t.Internal.LoginStatusTimer.PT:=	UA_STATUS_TIMEOUT * 100;

	t.Internal.LoginStatusTimer();

	IF( t.Internal.LoginStatusTimer.Q )THEN

		t.OUT.STAT.ValidLogin:=		0;
		t.OUT.STAT.InvalidLogin:=	0;
	
	END_IF


	(********************************************************************************)
	(* Logout										 								*)
	(********************************************************************************)


	IF( t.IN.CMD.Logout )THEN

		t.IN.CMD.Logout:=	0;

		UA_Logout( t.OUT.STAT.CurrentUser );

		t.OUT.STAT.ValidLogout:=	1;
	
		logInfo( t.IN.CFG.LoggerName, 50000, 'User Logout', ADR(Args) );
	
	END_IF


	(****************************************************************)
	(* Automatic logout												*)
	(****************************************************************)

	IF( 	(t.IN.CFG.AutomaticLogoutDelay <> 0)
		AND (t.IN.CFG.NumVC <> 0)
		AND ( t.IN.CFG.NumVC <= (UA_MAI_VC + 1) )
		)THEN

	
		(****************************************************************************)
		(* Step through configured number of VC objects to check for screen presses	*)
		(****************************************************************************)
	
		
		(* Check iHMI *)
	
		IF( t.Internal.iHMI >= t.IN.CFG.NumVC )THEN
 
			t.Internal.iHMI:=	0;
		
		END_IF
	
	
		(* Set VCName *)
	
		t.Internal.HMI[t.Internal.iHMI].VCName:=	t.IN.CFG.VCName[t.Internal.iHMI];
	
	
		(* GetTouchAction to set ScreenPress for each VC object *)
	
		t.Internal.GTAStatus:=	UA_GetTouchAction( t.Internal.HMI[t.Internal.iHMI] );
	
	
		(* If function finished, get error info and go to next HMI *)
	
		IF( t.Internal.GTAStatus = UA_GTA_FINISHED )THEN
		
			t.OUT.STAT.HMI[t.Internal.iHMI].Error:=			t.Internal.HMI[t.Internal.iHMI].Error;
			t.OUT.STAT.HMI[t.Internal.iHMI].ErrorID:=		t.Internal.HMI[t.Internal.iHMI].ErrorID;
			t.OUT.STAT.HMI[t.Internal.iHMI].ErrorString:=	t.Internal.HMI[t.Internal.iHMI].ErrorString;
		
			t.Internal.iHMI:=	t.Internal.iHMI + 1;
		
		END_IF
		
	
		(****************************************************************************)
		(* Loop through all HMIs to get ScreenPress information						*)
		(****************************************************************************)
	
		(* Reset ScreenPress. If any configured screens are pressed, it will be set below *)

		t.Internal.ScreenPress:=	0;
	
	
		FOR i:=0 TO t.IN.CFG.NumVC - 1 BY 1 DO

			
			(* Check for ScreenPress on ANY HMI *)
		
			t.Internal.ScreenPress:=	t.Internal.ScreenPress OR t.Internal.HMI[i].ScreenPress;
			

		END_FOR (* NumVC *)
	
	
		(********************************)
		(* Timer handling 				*)
		(********************************)
	
		t.Internal.AutoLogoutTimer.IN:=	NOT(t.Internal.ScreenPress);
		t.Internal.AutoLogoutTimer.PT:=	t.IN.CFG.AutomaticLogoutDelay * 100;
		
		t.Internal.AutoLogoutTimer();


		IF( t.Internal.AutoLogoutTimer.Q )THEN
		
			IF( 	(t.OUT.STAT.CurrentUser.UserLevel > 0)
				OR	(brsstrcmp( ADR(t.OUT.STAT.CurrentUser.UserName), ADR(UA_NOUSER) ) <> 0)
				)THEN					
	 
	  		
				UA_Logout( t.OUT.STAT.CurrentUser );

				t.OUT.STAT.AutoLogout:=	1;
			
				logInfo( t.IN.CFG.LoggerName, 50000, 'Automatic Logout Due To Inactivity', ADR(Args) );
			
			
			END_IF (* Logged in *)

		END_IF	(* AutoLogoutTimer.Q *)


	END_IF  (* AutoLogout configured *)


	(************************************************)
	(* Reset Logout status after timeout			*)
	(************************************************)

	t.Internal.LogoutStatusTimer.IN:=	t.OUT.STAT.ValidLogout OR t.OUT.STAT.AutoLogout;
	t.Internal.LogoutStatusTimer.PT:=	UA_STATUS_TIMEOUT * 100;

	t.Internal.LogoutStatusTimer();

	IF( t.Internal.LogoutStatusTimer.Q )THEN

		t.OUT.STAT.ValidLogout:=	0;
		t.OUT.STAT.AutoLogout:=		0;
	
	END_IF


END_FUNCTION
