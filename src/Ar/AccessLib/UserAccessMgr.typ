(*
 * File: UserAccessMgr.typ
 * Copyright (c) 2023 Loupe
 * https://loupe.team
 * 
 * This file is part of AccessLib, licensed under the MIT License.
 * 
  ********************************************************************
 * Data types of library AccessLib
 ********************************************************************)

TYPE
	UserAccessMgr_Int_HMI_typ : 	STRUCT 
		VCName : STRING[UA_STRLEN_IN];
		VCHandle : UDINT;
		AccessStatus : UINT;
		GetTouchActionStatus : UINT;
		ReleaseStatus : UINT;
		TouchAction : TouchAction;
		ScreenPress : BOOL;
		Error : BOOL;
		ErrorID : UINT;
		ErrorString : STRING[UA_STRLEN_ERROR];
	END_STRUCT;
	UserAccessMgr_Internal_typ : 	STRUCT 
		LoginStatus : UDINT;
		LoginStatusTimer : TON_10ms;
		LogoutStatusTimer : TON_10ms;
		AutoLogoutTimer : TON_10ms;
		HMI : ARRAY[0..UA_MAI_VC]OF UserAccessMgr_Int_HMI_typ;
		iHMI : USINT; (*Index for stepping through configured HMIs*)
		ScreenPress : BOOL; (*Any configured screen has been pressed*)
		GTAStatus : BOOL; (*Status from UA_GetTouchAction function*)
	END_STRUCT;
	UserAccessMgr_OUT_STAT_HMI_typ : 	STRUCT 
		Error : BOOL;
		ErrorID : UINT;
		ErrorString : STRING[UA_STRLEN_ERROR];
	END_STRUCT;
	UserAccessMgr_OUT_STAT_typ : 	STRUCT 
		CurrentUser : UA_User_typ; (*User name and level of current user*)
		LoggerInitialized : BOOL;
		ValidLogin : BOOL;
		InvalidLogin : BOOL;
		ValidLogout : BOOL;
		AutoLogout : BOOL;
		HMI : ARRAY[0..UA_MAI_VC]OF UserAccessMgr_OUT_STAT_HMI_typ;
	END_STRUCT;
	UserAccessMgr_OUT_typ : 	STRUCT 
		STAT : UserAccessMgr_OUT_STAT_typ;
	END_STRUCT;
	UserAccessMgr_IN_CFG_typ : 	STRUCT 
		pUserList : UDINT; (*Pointer to the user list (address of a UA_User_typ array)*)
		NumUsers : UDINT; (*Number of users in the user list*)
		LoginMode : UDINT; (*Mode for checking login (UA_MODE_DEFAULT, UA_MODE_PASSWORDONLY)*)
		VCName : ARRAY[0..UA_MAI_VC]OF STRING[UA_STRLEN_IN]; (*Name array of the visual components objects*)
		NumVC : USINT; (*Number of VC objects to check for touch actions*)
		AutomaticLogoutDelay : UDINT; (*Automatic logout delay time [s]. Set to 0 to disable automatic logout.*)
		LoggerName : STRING[LOG_STRLEN_LOGGERNAME]; (*Name of AR logger to use*)
	END_STRUCT;
	UserAccessMgr_IN_PAR_typ : 	STRUCT 
		InputUser : UA_User_typ;
	END_STRUCT;
	UserAccessMgr_IN_CMD_typ : 	STRUCT 
		Login : BOOL;
		Logout : BOOL;
	END_STRUCT;
	UserAccessMgr_IN_typ : 	STRUCT 
		CMD : UserAccessMgr_IN_CMD_typ;
		PAR : UserAccessMgr_IN_PAR_typ;
		CFG : UserAccessMgr_IN_CFG_typ;
	END_STRUCT;
	UserAccessMgr_typ : 	STRUCT 
		IN : UserAccessMgr_IN_typ;
		OUT : UserAccessMgr_OUT_typ;
		Internal : UserAccessMgr_Internal_typ;
	END_STRUCT;
END_TYPE
