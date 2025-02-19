## Homework 2

### 1.

Write a function that will delete items (one at a time) from a dynamic array without leaving gaps in the array.

You should assume that the items to be deleted are chosen at random, and try to do this in a gas efficient manner.

For example imagine your array has 12 items and you need to delete the items at indexes 8, 2 and 7.

The final array will then have items {0,1,3,4,5,6,9,1}


### 2. 
When creating the function selector "uint" will be replaced by "uint256" , see the example here from the Docs

```cpp
 `0xa5643bf2`: the Method ID. 
  
  This is derived from the signature 
  
  `sam(bytes,bool,uint256[])`. 
  
  Note that `uint` is replaced with its canonical representation `uint256`.
```

Could this be used maliciously in an exploit, if so, how would that be done ?