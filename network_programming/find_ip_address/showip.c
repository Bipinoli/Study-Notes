/*
* showip.c
*
* show ip address from the provided domain name from the command line
*/
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netdb.h>

int main(int argc, char* argv[]) {
  if (argc != 2) {
    fprintf(stderr, "useage: showip hostname\n");
    return 1;
  }
  printf("Looking for ip address of: %s\n", argv[1]);

  struct addrinfo hints, *result;
  memset(&hints, 0, sizeof(hints));
  hints.ai_family = AF_UNSPEC;
  hints.ai_socktype = SOCK_STREAM;

  if(getaddrinfo(argv[1], NULL, &hints, &result) != 0) {
    fprintf(stderr, "ERROR! Couldn't get the addrinfo\n");
    return 1;
  }

  struct addrinfo *p = result;
  while (p != NULL) {
    if (p->ai_family == AF_INET) {
      printf("IPV4 address:\n");
      struct sockaddr_in *addr = p->ai_addr;
      char address[INET_ADDRSTRLEN];
      if(inet_ntop(AF_INET, (const void*)(&(addr->sin_addr)), &address, INET_ADDRSTRLEN) == NULL) {
        fprintf(stderr, "ERROR! failed to convert binary to INET address\n");
        return 1;
      }
      // printf("%s:%d\n", address, addr->sin_port);
      printf("%s\n", address);
    } else if (p->ai_family == AF_INET6){
      printf("IPV6 address:\n");
      struct sockaddr_in6 *addr = p->ai_addr;
      char address[INET6_ADDRSTRLEN];
      if(inet_ntop(AF_INET6, (const void*)(&(addr->sin6_addr)), &address, INET6_ADDRSTRLEN) == NULL) {
        fprintf(stderr, "ERROR! failed to convert binary to INET address\n");
        return 1;
      }
      // printf("%s:%d\n", address, addr->sin6_port);
      printf("%s\n", address);
    }
    p = p->ai_next;
  }

  freeaddrinfo(result);
  return 0;
}


