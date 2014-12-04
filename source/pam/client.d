module pam_.client;


import core.sys.posix.sys.types;
import core.stdc.stdint;
import pam_.types;

extern (C):

alias pamc_handle_s* pamc_handle_t;
alias _Anonymous_0* pamc_bp_t;

struct pamc_handle_s;

struct _Anonymous_0
{
	uint32_t length;
	uint8_t control;
}


pamc_handle_t pamc_start ();
int pamc_end (pamc_handle_t* pch);
int pamc_load (pamc_handle_t pch, const(char)* agent_id);
int pamc_converse (pamc_handle_t pch, pamc_bp_t* prompt_p);
int pamc_disable (pamc_handle_t pch, const(char)* agent_id);
char** pamc_list_agents (pamc_handle_t pch);