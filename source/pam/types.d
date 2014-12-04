module pam_.types;


extern (C):

alias pam_handle pam_handle_t;

struct pam_message
{
	int msg_style;
	const(char)* msg;
}

struct pam_response
{
	char* resp;
	int resp_retcode;
}

struct pam_conv
{
	int function (int, const(pam_message*)*, pam_response**, void*) conv;
	void* appdata_ptr;
}

struct pam_handle;

struct pam_xauth_data
{
	int namelen;
	char* name;
	int datalen;
	char* data;
}


int pam_set_item (pam_handle_t* pamh, int item_type, const(void)* item);
int pam_get_item (const(pam_handle_t)* pamh, int item_type, const(void*)* item);
const(char)* pam_strerror (pam_handle_t* pamh, int errnum);
int pam_putenv (pam_handle_t* pamh, const(char)* name_value);
const(char)* pam_getenv (pam_handle_t* pamh, const(char)* name);
char** pam_getenvlist (pam_handle_t* pamh);
int pam_fail_delay (pam_handle_t* pamh, uint musec_delay);




/* ----------------- The Linux-PAM return values ------------------ */
enum pam_return{
	PAM_SUCCESS = 0,/* Successful function return */
	PAM_OPEN_ERR = 1,/* dlopen() failure when dynamically loading a service module */
	PAM_SYMBOL_ERR = 2,/* Symbol not found */
	PAM_SERVICE_ERR = 3,/* Error in service module */
	PAM_SYSTEM_ERR = 4,/* System error */
	PAM_BUF_ERR = 5,/* Memory buffer error */
	PAM_PERM_DENIED = 6,/* Permission denied */
	PAM_AUTH_ERR = 7,/* Authentication failure */
	PAM_CRED_INSUFFICIENT = 8,/* Can not access authentication data due to insufficient credentials */
	PAM_AUTHINFO_UNAVAIL = 9,/* Underlying authentication service can not retrieve authentication information  */
	PAM_USER_UNKNOWN = 10,/* User not known to the underlying authenticaiton module */
	PAM_MAXTRIES = 11,/* An authentication service has maintained a retry count which has been reached.  No further retries should be attempted */
	PAM_NEW_AUTHTOK_REQD = 12,/* New authentication token required. This is normally returned if the machine security policies require
								that the password should be changed because the password is NULL or it has aged */
	PAM_ACCT_EXPIRED = 13,/* User account has expired */
	PAM_SESSION_ERR = 14,/* Can not make/remove an entry for the specified session */
	PAM_CRED_UNAVAIL = 15,/* Underlying authentication service can not retrieve user credentials unavailable */
	PAM_CRED_EXPIRED = 16,/* User credentials expired */
	PAM_CRED_ERR = 17,/* Failure setting user credentials */
	PAM_NO_MODULE_DATA = 18,/* No module specific data is present */
	PAM_CONV_ERR = 19,/* Conversation error */

	PAM_AUTHTOK_ERR = 20,/* Authentication token manipulation error */
	PAM_AUTHTOK_RECOVERY_ERR = 21,/* Authentication information cannot be recovered */
	PAM_AUTHTOK_LOCK_BUSY = 22,/* Authentication token lock busy */
	PAM_AUTHTOK_DISABLE_AGING = 23,/* Authentication token aging disabled */
	
	PAM_TRY_AGAIN = 24,/* Preliminary check by password service */
	PAM_IGNORE = 25,/* Ignore underlying account module regardless of whether the control flag is required, optional, or sufficient */
	PAM_ABORT = 26,/* Critical error (?module fail now request) */
	PAM_AUTHTOK_EXPIRED = 27,/* user's authentication token has expired */
	PAM_MODULE_UNKNOWN = 28,/* module is not known */
	PAM_BAD_ITEM = 29,/* Bad item passed to pam_*_item() */
	PAM_CONV_AGAIN = 30,/* conversation function is event driven and data is not available yet */
	PAM_INCOMPLETE = 31 /* please call this function again to complete authentication stack. Before calling again, verify that conversation is completed */
}



/*
 * Add new #define's here - take care to also extend the libpam code:
 * pam_strerror() and "libpam/pam_tokens.h" .
 */

enum _PAM_RETURN_VALUES = 32;   /*; this is the number of return values */


/* ---------------------- The Linux-PAM flags -------------------- */

enum pam_flag{
	/* Authentication service should not generate any messages */
	PAM_SILENT = 0x8000U,

	/* Note: these flags are used by pam_authenticate{,_secondary}() */

	/* The authentication service should return PAM_AUTH_ERROR if the
	 * user has a null authentication token */
	PAM_DISALLOW_NULL_AUTHTOK = 0x0001U,

	/* Note: these flags are used for pam_setcred() */

	/* Set user credentials for an authentication service */
	PAM_ESTABLISH_CRED = 0x0002U,

	/* Delete user credentials associated with an authentication service */
	PAM_DELETE_CRED = 0x0004U,

	/* Reinitialize user credentials */
	PAM_REINITIALIZE_CRED = 0x0008U,

	/* Extend lifetime of user credentials */
	PAM_REFRESH_CRED = 0x0010U,

	/* Note: these flags are used by pam_chauthtok */

	/* The password service should only update those passwords that have
	 * aged.  If this flag is not passed, the password service should
	 * update all passwords. */
	PAM_CHANGE_EXPIRED_AUTHTOK = 0x0020U
}


/* ------------------ The Linux-PAM item types ------------------- */

/* These defines are used by pam_set_item() and pam_get_item().
   Please check the spec which are allowed for use by applications
   and which are only allowed for use by modules. */

enum pam_item{
	PAM_SERVICE = 1,	/* The service name */
	PAM_USER = 2,	/* The user name */
	PAM_TTY = 3,	/* The tty name */
	PAM_RHOST = 4,	/* The remote host name */
	PAM_CONV = 5,	/* The pam_conv structure */
	PAM_AUTHTOK = 6,	/* The authentication token (password) */
	PAM_OLDAUTHTOK = 7,	/* The old authentication token */
	PAM_RUSER = 8,	/* The remote user name */
	PAM_USER_PROMPT = 9,    /* the prompt for getting a username */
	/* Linux-PAM extensions */
	PAM_FAIL_DELAY = 10,   /* app supplied function to override failure
					   delays */
	PAM_XDISPLAY = 11,   /* X display name */
	PAM_XAUTHDATA = 12,   /* X server authentication data */
	PAM_AUTHTOK_TYPE = 13   /* The type for pam_get_authtok */
}