#include <stdio.h>
#include "string_pattern.s"
extern "C" int match(char* str, char* pat);

int main() {
  char str[] = "Hello string";
  char pat[] = "*?";

  int result = match(str, pat);
  printf("%d", result);

  return 0;
}
