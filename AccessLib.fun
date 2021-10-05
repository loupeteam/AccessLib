(********************************************************************
 * COPYRIGHT -- Automation Resources Group
 ********************************************************************
 * Library: Access_Lib
 * File: Access_Lib.fun
 * Author: David
 * Created: August 18, 2010
 ********************************************************************
 * Functions and function blocks of library Access_Lib
 ********************************************************************)

FUNCTION UA_Logout : UDINT (*Logout function*)
	VAR_IN_OUT
		CurrentUser : UA_User_typ;
	END_VAR
END_FUNCTION

FUNCTION UA_Login : UDINT (*Login function - checks username and password*)
	VAR_INPUT
		pUserList : UDINT;
		NumUsers : UDINT;
		InputUser : UA_User_typ;
	END_VAR
	VAR_IN_OUT
		CurrentUser : UA_User_typ;
	END_VAR
	VAR
		i : UDINT;
		dUser : REFERENCE TO UA_User_typ;
	END_VAR
END_FUNCTION

FUNCTION UA_LoginPasswordOnly : UDINT (*Login function - ignores username and only checks password*)
	VAR_INPUT
		pUserList : UDINT;
		NumUsers : UDINT;
		pInputPassword : UDINT;
	END_VAR
	VAR_IN_OUT
		CurrentUser : UA_User_typ;
	END_VAR
	VAR
		i : UDINT;
		dUser : REFERENCE TO UA_User_typ;
	END_VAR
END_FUNCTION

FUNCTION UA_ListUsers : UDINT (*List all of the users with user name and level*)
	VAR_INPUT
		pUserList : UDINT;
		NumUsers : UDINT;
		pStringArray : UDINT;
		NumStrings : UDINT;
		StringLength : UDINT;
	END_VAR
	VAR
		i : UDINT;
		LoopEndIndex : UDINT;
		pCurrString : UDINT;
		UserLevelString : STRING[3];
		dUser : REFERENCE TO UA_User_typ;
	END_VAR
END_FUNCTION

FUNCTION UA_AddUser : UDINT (*Add a user to the user list*)
	VAR_INPUT
		pUserList : UDINT;
		NumUsers : UDINT;
		NewUser : UA_User_typ;
	END_VAR
	VAR
		i : UDINT;
		dUser : REFERENCE TO UA_User_typ;
	END_VAR
END_FUNCTION

FUNCTION UA_RemoveUser : UDINT (*Remove a user from the user list*)
	VAR_INPUT
		pUserList : UDINT;
		NumUsers : UDINT;
		pUserName : UDINT;
	END_VAR
	VAR
		i : UDINT;
		dUser : REFERENCE TO UA_User_typ;
	END_VAR
END_FUNCTION

FUNCTION UA_ChangePassword : UDINT (*Change a user's password*)
	VAR_INPUT
		pUserList : UDINT;
		NumUsers : UDINT;
		pUserName : UDINT;
		pOldPassword : UDINT;
		pNewPassword : UDINT;
	END_VAR
	VAR
		i : UDINT;
		dUser : REFERENCE TO UA_User_typ;
	END_VAR
END_FUNCTION

FUNCTION UA_ChangeUserLevel : UDINT (*Change a user's user level*)
	VAR_INPUT
		pUserList : UDINT;
		NumUsers : UDINT;
		pUserName : UDINT;
		NewUserLevel : USINT;
	END_VAR
	VAR
		i : UDINT;
		dUser : REFERENCE TO UA_User_typ;
	END_VAR
END_FUNCTION

FUNCTION UserAccessFn_Cyclic : BOOL (*Cyclic function for controlling user access levels*)
	VAR_IN_OUT
		t : UserAccessMgr_typ; (*User access control object*)
	END_VAR
	VAR
		i : USINT; (*Loop counter*)
		Args : BRSE_ARL_Arguments_typ; (*Logger arguments*)
	END_VAR
END_FUNCTION

FUNCTION UA_GetTouchAction : BOOL (*Wrapper for VA_GetTouchAction visapi function*)
	VAR_IN_OUT
		t : UserAccessMgr_Int_HMI_typ; (*User access internal HMI object*)
	END_VAR
END_FUNCTION

FUNCTION UA_SetHMIError : BOOL (*Set the error status on an HMI object*)
	VAR_INPUT
		ErrorID : UINT;
	END_VAR
	VAR_IN_OUT
		t : UserAccessMgr_Int_HMI_typ;
	END_VAR
END_FUNCTION

FUNCTION UA_Lock : UINT (*Lock or unlock an HMI element based on the current user level and a minimum required user level*) (*$GROUP=User*)
	VAR_INPUT
		CurrentUserLevel : USINT;
		MinUserLevel : USINT;
	END_VAR
	VAR_IN_OUT
		StatusDP : UINT;
	END_VAR
END_FUNCTION

FUNCTION UA_Hide : UINT (*Show or hide an HMI element based on the current user level and a minimum required user level*) (*$GROUP=User*)
	VAR_INPUT
		CurrentUserLevel : USINT;
		MinUserLevel : USINT;
	END_VAR
	VAR_IN_OUT
		StatusDP : UINT;
	END_VAR
END_FUNCTION
