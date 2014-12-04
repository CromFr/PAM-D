module pam_.modutil;


import core.sys.posix.pwd;
import core.sys.posix.sys.types;
import core.sys.posix.grp;
import core.sys.posix.pwd;
import pam_.types;
import pam_.shadow;

extern (C):

struct pam_modutil_privs
{
	gid_t* grplist;
	int number_of_groups;
	int allocated;
	gid_t old_gid;
	uid_t old_uid;
	int is_dropped;
}

passwd* pam_modutil_getpwnam (pam_handle_t* pamh, const(char)* user);
passwd* pam_modutil_getpwuid (pam_handle_t* pamh, uid_t uid);
group* pam_modutil_getgrnam (pam_handle_t* pamh, const(char)* group);
group* pam_modutil_getgrgid (pam_handle_t* pamh, gid_t gid);
spwd* pam_modutil_getspnam (pam_handle_t* pamh, const(char)* user);
int pam_modutil_user_in_group_nam_nam (pam_handle_t* pamh, const(char)* user, const(char)* group);
int pam_modutil_user_in_group_nam_gid (pam_handle_t* pamh, const(char)* user, gid_t group);
int pam_modutil_user_in_group_uid_nam (pam_handle_t* pamh, uid_t user, const(char)* group);
int pam_modutil_user_in_group_uid_gid (pam_handle_t* pamh, uid_t user, gid_t group);
const(char)* pam_modutil_getlogin (pam_handle_t* pamh);
int pam_modutil_read (int fd, char* buffer, int count);
int pam_modutil_write (int fd, const(char)* buffer, int count);
int pam_modutil_audit_write (pam_handle_t* pamh, int type, const(char)* message, int retval);
int pam_modutil_drop_priv (pam_handle_t* pamh, pam_modutil_privs* p, const(passwd)* pw);
int pam_modutil_regain_priv (pam_handle_t* pamh, pam_modutil_privs* p);
