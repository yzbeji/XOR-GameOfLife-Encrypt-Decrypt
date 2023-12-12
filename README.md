# XOR-GameOfLife-Encrypt-Decrypt
This is a program written in x86 Assembly language. It is used to encrypt and decrypt any password ( up to 10 characters that contains numbers, lowercase letters and uppercase letters ) you put. The key is created by your input and influence in the game of life. To make it work you have to do next steps:

  1. Create a file in the same directory with the source code. ( example: input.txt )
  2. In the respective file you have to put:
         - number of rows ( up to 18 )
         - number of columns ( up to 18 )
         - a number that represents how many cells you want to be alive ( let's note this with 'P' )
         - P tuples that contains (X, Y) coordinates of your alive cell
         - number of iterations
         - a boolean value ( 1 or 0 )
         - 1 -> ENCRYPT, 2 -> DECRYPT
         - your password

Let me show you an example:
1.ENCRYPT G1tHubR3p0 => RESULT: 0x47B1F448776052337838
2.DECRYPT 0x47B1F448776052337838 => RESULT: G1tHubR3p0 

i. << INPUT.TXT >> 
3                   // number of rows
4                   // number of columns
5                   // number of cells you want to be alive
0
1                   // (0,1)
0
2                   // (0,2)
1
0                   // (1,0)
2
2                   // (2,2)
2
3                   // (2,3)
5                   // number of iterations
0 / 1               // ENCRYPT / DECRYPT
G1tHubR3p0 / 0x47B1F448776052337838     // << Your Password >> / << Your Encrypted Password >> 

ii. Open your console: 
    --> gcc -m32 XORGOL.s -o crypt.o -no-pie
    --> ./crypt.o < input.txt
    --> RESULT 




