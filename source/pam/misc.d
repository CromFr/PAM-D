module pam_.misc;


import core.stdc.time;
import pam_.types;
import pam_.client;

extern (C):

extern __gshared time_t pam_misc_conv_warn_time;
extern __gshared time_t pam_misc_conv_die_time;
extern __gshared const(char)* pam_misc_conv_warn_line;
extern __gshared const(char)* pam_misc_conv_die_line;
extern __gshared int pam_misc_conv_died;
extern __gshared int function (void*, pamc_bp_t*) pam_binary_handler_fn;
extern __gshared void function (void*, pamc_bp_t*) pam_binary_handler_free;

int misc_conv (int num_msg, const(pam_message*)* msgm, pam_response** response, void* appdata_ptr);
int pam_misc_paste_env (pam_handle_t* pamh, const(char*)* user_env);
char** pam_misc_drop_env (char** env);
int pam_misc_setenv (pam_handle_t* pamh, const(char)* name, const(char)* value, int readonly);


