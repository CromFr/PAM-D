import std.stdio;
import std.conv : to;
import std.string;

import pam;


void setUser(in string login)
{
	import core.sys.posix.unistd;
	import core.sys.posix.pwd;
	import core.sys.posix.grp;

	auto pw = getpwnam(login.toStringz);

	if (pw.pw_gid >= 0) {
		assert(getgrgid(pw.pw_gid) !is null, "Invalid group id!");
		assert(setegid(pw.pw_gid) == 0, "Error setting group id!");
	}
	//if( initgroups(const char *user, gid_t group);
	if (pw.pw_uid >= 0) {
		assert(getpwuid(pw.pw_uid) !is null, "Invalid user id!");
		assert(seteuid(pw.pw_uid) == 0, "Error setting user id!");
	}
}

void Login(in string login, in string passwd)
{
	static __gshared pam_response* convreply;

	int result = 0;

	//Prepare conv
	extern(C)
	int null_conv(int num_msg, const(pam_message*)* msg, pam_response** res, void* appdata_ptr)
	{
		*res = convreply;
		return pam_return.PAM_SUCCESS;
	}
	pam_conv conv = pam_conv(&null_conv, null);

	//Deny empty login
	if(login == ""){
		throw new Exception("Login can't be null");
	}

	//Start PAM conversation
	pam_handle_t* pamh = null;
	result = pam_start("system-auth", login.toStringz, &conv, &pamh);
	if (result != pam_return.PAM_SUCCESS) {
		throw new Exception((cast(pam_return)result).to!string~": Bad login");
	}

	//Prepare authentification
	convreply = cast(pam_response*)core.stdc.stdlib.malloc(pam_response.sizeof);
	convreply.resp_retcode = 0;
	//Password copying
	auto p = passwd.to!(char[])~'\0';
	convreply.resp = cast(char*)core.stdc.stdlib.malloc(char.sizeof*(p.length));
	foreach(i ; 0..p.length)
		convreply.resp[i] = p[i];

	//Start authentification
	result = pam_authenticate(pamh, 0);
	if (result != pam_return.PAM_SUCCESS) {
		throw new Exception((cast(pam_return)result).to!string~": Bad password");
	}

	//result = pam_open_session(pamh, 0);
	//if (result != pam_return.PAM_SUCCESS) {
	//	throw new Exception((cast(pam_return)result).to!string~": Could not open session");
	//}

	setUser(login);

	//End conversation
	pam_end(pamh, result);
}

void printUID(){
	import core.sys.posix.unistd;
	writeln("uid=",getuid(),"\tgid=",getgid(),"\teuid=",geteuid(),"\tegid=",getegid());
}


void main(string[] args)
{
	writeln("Start !");

	assert(args.length==3, "Usage: pam-d user password");

	printUID();
	Login(args[1], args[2]);
	printUID();

	import std.file;
	foreach(f ; dirEntries("/root", SpanMode.shallow))
		writeln(f.name);

}
