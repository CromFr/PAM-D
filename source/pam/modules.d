module pam_.modules;


import pam_.types;

extern (C):

int pam_set_data (pam_handle_t* pamh, const(char)* module_data_name, void* data, void function (pam_handle_t*, void*, int) cleanup);
int pam_get_data (const(pam_handle_t)* pamh, const(char)* module_data_name, const(void*)* data);
int pam_get_user (pam_handle_t* pamh, const(char*)* user, const(char)* prompt);
int pam_sm_authenticate (pam_handle_t* pamh, int flags, int argc, const(char*)* argv);
int pam_sm_setcred (pam_handle_t* pamh, int flags, int argc, const(char*)* argv);
int pam_sm_acct_mgmt (pam_handle_t* pamh, int flags, int argc, const(char*)* argv);
int pam_sm_open_session (pam_handle_t* pamh, int flags, int argc, const(char*)* argv);
int pam_sm_close_session (pam_handle_t* pamh, int flags, int argc, const(char*)* argv);
int pam_sm_chauthtok (pam_handle_t* pamh, int flags, int argc, const(char*)* argv);