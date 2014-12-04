module pam_.appl;


import pam_.types;

extern (C):

int pam_start (const(char)* service_name, const(char)* user, const(pam_conv)* pam_conversation, pam_handle_t** pamh);
int pam_end (pam_handle_t* pamh, int pam_status);
int pam_authenticate (pam_handle_t* pamh, int flags);
int pam_setcred (pam_handle_t* pamh, int flags);
int pam_acct_mgmt (pam_handle_t* pamh, int flags);
int pam_open_session (pam_handle_t* pamh, int flags);
int pam_close_session (pam_handle_t* pamh, int flags);
int pam_chauthtok (pam_handle_t* pamh, int flags);