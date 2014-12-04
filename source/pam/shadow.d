module pam_.shadow;

import core.stdc.stdio;
import core.stdc.config;

extern (C):

struct spwd
{
	char* sp_namp;
	char* sp_pwdp;
	c_long sp_lstchg;
	c_long sp_min;
	c_long sp_max;
	c_long sp_warn;
	c_long sp_inact;
	c_long sp_expire;
	c_ulong sp_flag;
}

void setspent ();
void endspent ();
spwd* getspent ();
spwd* getspnam (const(char)* __name);
spwd* sgetspent (const(char)* __string);
spwd* fgetspent (FILE* __stream);
int putspent (const(spwd)* __p, FILE* __stream);
int getspent_r (spwd* __result_buf, char* __buffer, size_t __buflen, spwd** __result);
int getspnam_r (const(char)* __name, spwd* __result_buf, char* __buffer, size_t __buflen, spwd** __result);
int sgetspent_r (const(char)* __string, spwd* __result_buf, char* __buffer, size_t __buflen, spwd** __result);
int fgetspent_r (FILE* __stream, spwd* __result_buf, char* __buffer, size_t __buflen, spwd** __result);
int lckpwdf ();
int ulckpwdf ();