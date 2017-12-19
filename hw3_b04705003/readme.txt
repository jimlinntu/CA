# Code Implementation
## T(n) function 
Use recursion.
First, create stack size of 32 bytes, then check if n < 2, 
if is true, then this will return base case
if not, then this will go to "recursive" section and return 2 * T(n/2) + c * n 

## itoa function
Iteratively divide input integer, convert remainder to string by adding '0' ascii number and store the ascii code directly into 'output_ascii' array.

# Environment
Windows 10 64bit