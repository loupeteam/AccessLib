/* Automation Studio generated header file */
/* Do not edit ! */
/* brse_arl 2.03.1 */

#ifndef _BRSE_ARL_
#define _BRSE_ARL_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _brse_arl_VERSION
#define _brse_arl_VERSION 2.03.1
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
#ifdef _SG3
		#include "AsArLog.h"
		#include "AsBrStr.h"
		#include "sys_lib.h"
#endif
#ifdef _SG4
		#include "AsArLog.h"
		#include "AsBrStr.h"
		#include "sys_lib.h"
#endif
#ifdef _SGC
		#include "AsArLog.h"
		#include "AsBrStr.h"
		#include "sys_lib.h"
#endif


/* Datatypes and datatypes of function blocks */
typedef enum BRSE_ARL_ERR_enum
{	BRSE_ARL_ID_ALREADY_INITIALIZED = 58200,
	BRSE_ARL_ID_NOT_VALID,
	BRSE_ARL_BUFFER_FULL,
	BRSE_ARL_OUT_OF_MEMORY
} BRSE_ARL_ERR_enum;

typedef struct BRSE_ARL_Arguments_typ
{	float r[5];
	unsigned long s[5];
	plcbit b[5];
	signed long i[5];
} BRSE_ARL_Arguments_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC unsigned short BRSE_ARL_Free(unsigned short ID);
_BUR_PUBLIC unsigned short BRSE_ARL_Fatal(unsigned short ID, unsigned long ErrorNumber, plcstring* ErrorMessage, unsigned long pMsgData);
_BUR_PUBLIC unsigned short BRSE_ARL_Warning(unsigned short ID, unsigned long ErrorNumber, plcstring* ErrorMessage, unsigned long pMsgData);
_BUR_PUBLIC unsigned short BRSE_ARL_Info(unsigned short ID, unsigned long ErrorNumber, plcstring* ErrorMessage, unsigned long pMsgData);
_BUR_PUBLIC unsigned short BRSE_ARL_Cyclic(unsigned short ID);
_BUR_PUBLIC unsigned short BRSE_ARL_Alloc(unsigned short ID, plcstring* Name, unsigned long LogbookSize, unsigned long MessageSize, unsigned long BufferedEntries);


#ifdef __cplusplus
};
#endif
#endif /* _BRSE_ARL_ */

