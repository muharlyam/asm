#include <stdio.h>

extern "C" int search_max(int* arr, int size);

int main()
{
	int arr[] = {7, 2, 10, 6, 1, 8, 8, 0};
	int a = search_max(arr, 8);
	printf("%d", a);
	return 0;
}