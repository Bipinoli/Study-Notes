/*
* server.cpp
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
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netdb.h>


struct requestItem {
  char op;
  float a;
  float b;
};


float mather(char operation, float a, float b);


int main() {

  return 0;
}

float mather(char operation, float a, float b) {
  if (operation == '+') return a + b;
  if (operation == '-') return a - b;
  if (operation == '*') return a * b;
  if (operation == '/') return a / b;
  return 0.0f;
}
