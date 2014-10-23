import Data.List

--------------------------------
---- Personalised Functions ----
--------------------------------

myFirst :: (a, b) -> a
myFirst (x,xs) = x

myFoldLeft :: (a -> b -> a) -> a -> [b] -> a
myFoldLeft x y [] = y
myFoldLeft x y (z:zs) = myFoldLeft x (x y z) zs

myLength :: [a] -> Int
myLength [] = 0
myLength (x:xs) = 1 + myLength xs

myHead :: [a] -> a
myHead (x:xs) = x

myLast :: [a] -> a
myLast [x] = x
myLast (x:xs) = myLast xs

myTake :: Int -> [a] -> [a]
myTake 0 x = []
myTake x []= []
myTake y (x:xs)
			| y > 0 = x : myTake (y-1) xs
			
myDrop :: Int -> [a] -> [a]	
myDrop 0 x = x
myDrop _ [] = []
myDrop x (y:ys) 
				| x > 0 = myDrop (x-1) ys
				
myMap :: (a -> b) -> Maybe a -> Maybe b
myMap x (Just y) = Just(x y) 

myZip :: [a] -> [b] -> [(a,b)]
myZip xs ys = myZipWith myPair xs ys
			where
				myPair x y = (x, y)	

myZipWith :: (a -> b -> c) -> [a]->[b]->[c]
myZipWith x (y:ys) (z:zs) = x y z : myZipWith x ys zs
myZipWith _ _ _  = []
							
myPair :: [a] -> [(a, a)]
myPair [] = []
myPair [x] = []
myPair (x1:x2:xs) = (x1, x2) : myPair xs

mySizeList :: Int -> [a] -> [[a]]
mySizeList x yList@(y:ys) = if (myLength yList >= x)
								then myTake x yList : mySizeList x ys 
								else mySizeList x ys		

myId :: a -> a
myId x = x

myFromMaybe :: a -> Maybe a -> a
myFromMaybe x = (maybe x) myId
							
myOrd :: Char -> Int
myOrd = fromEnum

mySubstring :: String -> Int -> Int -> String
mySubstring x y z = 
					myTake z(myDrop y x)

------------------------
-- Hashing Functions ---
------------------------
hashing :: Int -> Int -> String -> Int -> Int
hashing x y input z = 
					myFoldLeft (\accumulator x -> (myOrd x) `mod` y) 0 (myTake z input)

remove_hash :: Int -> Int -> Char -> Char -> Int -> Int
remove_hash x y first next z = 
								removeFirst `mod` (y * x + (myOrd next)) `mod`  y
								where 
									removeFirst = z ^ (1) `mod` y  * (myOrd first)
									
									
--------------------------------
----- Rabin-Karp Algorithm -----
--------------------------------	

rabin_Karp :: String -> String -> Int
rabin_Karp sentence match = 
						-- the following is broken down and indented for readability of algorithm
						myFromMaybe 0(
										myMap myFirst(
													find pattern(
																	myZip[0..99](
																					scanl next (hashing 1 1 sentence (myLength(match)))(
																																		mySizeList (myLength(match)) sentence
																																		)
																				 )
																)
													)
									)					
					where 
						  next x y = remove_hash 1 1 (myHead y) (myLast y) (myLength(match))
						  pattern (x, y) = (hashing 1 1 match (myLength(match)) == y) && (mySubstring sentence x (myLength(match)) == match)    

