module pam_.ext;


import core.stdc.stdarg;
import pam_.types;

extern (C):

void pam_vsyslog (const(pam_handle_t)* pamh, int priority, const(char)* fmt, va_list args);
void pam_syslog (const(pam_handle_t)* pamh, int priority, const(char)* fmt, ...);
int pam_vprompt (pam_handle_t* pamh, int style, char** response, const(char)* fmt, va_list args);
int pam_prompt (pam_handle_t* pamh, int style, char** response, const(char)* fmt, ...);
int pam_get_authtok (pam_handle_t* pamh, int item, const(char*)* authtok, const(char)* prompt);
int pam_get_authtok_noverify (pam_handle_t* pamh, const(char*)* authtok, const(char)* prompt);
int pam_get_authtok_verify (pam_handle_t* pamh, const(char*)* authtok, const(char)* prompt);