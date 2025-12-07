/*
* server.c
*
* It binds to loopback address (localhost) 
* and forks a process to handle each socket connection from the client.
*
* It recievies a batch of arithmatic calulation as a request from the client.
* This is done to emulate a big batch of data that doesn't fit in one TCP segment.
*
* Author: Bipin Oli
*/

#include <stdio.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netdb.h>

int main() {
  
    
  return 0;
}


