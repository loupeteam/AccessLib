(*
* File: AccessLib.typ
* Copyright (c) 2023 Loupe
* https://loupe.team
* 
* This file is part of AccessLib, licensed under the MIT License.
* 
*)

TYPE
	UA_MODE_enum : 
		(
		UA_MODE_DEFAULT,
		UA_MODE_PASSWORDONLY,
		UA_MODE_
		);
	UA_ERR_enum : 
		(
		UA_ERR_SCRNBUSY := 7000,
		UA_ERR_TERMNOTCONN := 7130,
		UA_ERR_NODATA := 7195,
		UA_ERR_NULLPTR := 50000,
		UA_ERR_NUMUSERS,
		UA_ERR_NUMSTRINGS,
		UA_ERR_STRINGLENGTH,
		UA_ERR_INVALIDUSERNAME,
		UA_ERR_INVALIDPASSWORD,
		UA_ERR_USERLISTFULL,
		UA_ERR_USERNOTFOUND,
		UA_ERR_VCHANDLE,
		UA_ERR_
		);
	UA_User_typ : 	STRUCT 
		UserName : STRING[UA_STRLEN_IN];
		Password : STRING[UA_STRLEN_IN];
		UserLevel : USINT;
	END_STRUCT;
END_TYPE
