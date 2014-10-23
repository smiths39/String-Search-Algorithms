## Research

The Rabin-Karp algorithm is used for multiple pattern matching, rather than simplistic single pattern matching. A practical use of Rabin-Karp is detecting plagiarism. By providing source material, Rabin-Karp can rapidly search for instances of sentences from the source material. The technique in which Rabin-Karp employs is hashing and it is used to find a substring in a text. 

## Personalised Functions

An approach I pursued when attempting to implement the Rabin-Karp algorithm was to research all reliable Haskell functions and to use them to my advantage. As previously experienced in Lab Sessions, I researched thoroughly on multiple functions and generated my own personalised functions based on the information provided on ‘zvon.org’ (refer to references).
The following is a list of personalised list functions I have included upon my source code in order to implement the desired algorithm.

1. myFirst
 * Returns the first element in a pair.

2. myFoldLeft
 * Applies a function, to the second argument and the first item of the list. 

3. myLength
 * Returns the number of elements in a list.

4. myHead
 * Returns the first element of a non-empty list.

5. myLast
 * Returns the last element of a non-empty list.

6. myTake 
 * Returns the specified number of elements from the front of the list.

7. myDrop
 * Returns a list with the specified number of elements removed from the front of the list.

8. myZip
 * Returns a list of pairs which are formed by tupling together corresponding elements from both lists.

9. myZipWith
 * Returns a list containing elements formed by a specific function to corresponding elements in the list.

10. myPair
 * Returns two tuples formed from pairs of elements.

11. myMap
 * Returns a corrected binding of two values.

 * The following is used within this function:
     1. Maybe – provides a method of dealing with illegal values without terminating the program.
     2. Just – correct result of maybe.
     3. Nothing – incorrect result of maybe. 

12. mySizeList
 * Returns a list (within a list) with a size of length supplied in first argument.

13. myID
 * Returns identity of argument supplied.

14. myFromMaybe
 * Returns error-free value of argument supplied. Due to errors occurring with conflicting elements such as ‘char’ and ‘int’.

15. myOrd
 * Converts character to an integer using the pre-defined ‘fromEnum’ function. Characters to integer begins at integer 97.

16. mySubstring 
 * Returns a list with the specified number of elements removed from the front of the list.


#### Note
‘fromEnum’ function was not personally implemented due to the requirements of predefined methods.

‘fromEnum’ was imported using import.Data.List


## Hashing Functions

The following are the functions in which I constructed in order to implement hashing within my algorithm.

1. hash
 * Returns an integer representing the amount of characters extracted from a String.
 * The fourth argument indicates how many characters to extract given the range provided by the first two arguments.

2. remove_Hash
 * Removes the hash of the first character and pushes each character up by one position.


## Rabin-Karp Algorithm

The main algorithm requires two inputs from the user.

 1. Sentence – the text which is to be searched upon.
 2. Match – the specific letters/word which is to be searched for in sentence.

The program functions by computing the hash value for the match and for the first characters of the sentence, where the first characters depends on the number of characters in the match.
The application then proceeds through the sentence comparing the match hash with the current version of the sentence hash each time. If the sentence and match hash to the same value, then a match is confirmed and the function is completed.
The program returns the index (using myZip function) within the sentence where the match was first found.


###Note

Within my implementation I required the use of the following functions.

1. find
 * This returns the element of a list that satisfies a predicate, which in this case is a match. I chose not to implement this function personally as it requires multiple pre-defined methods in order to implement. 
 * The function is structured to deal with illegal values and therefore uses the Maybe type. 

2. Scanl
 * The scan left function was used as a reduction mechanism. This assisted in viewing the value of the hash on each iteration.

Both function were imported using import.Data.List


## Rabin-Karp Execution

rabin_Karp :: String -> String -> Int

#### Example

rabin_Karp  "Hello World" "Wor"
