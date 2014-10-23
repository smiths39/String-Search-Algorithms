import Data.List

--------------------------------
---- Personalised Functions ----
--------------------------------

myHead :: [a] -> a
myHead [] = error "Empty list!"
myHead [x] = x
myHead (x:xs) = x

myLast :: [a] -> a
myLast [] = error "Empty list!"
myLast [x] = x
myLast (x:xs) = myHead(reverse xs)

myTail :: [a] -> [a]
myTail [] = error "Empty list!"
myTail [x] = [x]
myTail (x:xs) = xs

myInit :: [a] -> [a]
myInit [] = error "Empty list!"
myInit [x] = []
myInit (x:xs) = x:myInit(xs)

myTake :: Int -> [a] -> [a]
myTake 0 _ = []
myTake _ [] = []
myTake x (y:ys)
				| x > 0 = y : myTake (x-1) ys
				
myDrop :: Int -> [a] -> [a]	
myDrop 0 x = x
myDrop _ [] = []
myDrop x (y:ys) 
				| x > 0 = myDrop (x-1) ys

myLength :: [a] -> Int
myLength [] = 0
myLength (x:xs) = 1 + myLength xs

myZip :: [a] -> [b] -> [(a,b)]
myZip xs ys = myZipWith myPair xs ys
			where
				myPair x y = (x, y)	

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith x (y:ys) (z:zs) = x y z : myZipWith x ys zs
myZipWith _ _ _  = []

myPair :: [a] -> [(a, a)]
myPair [] = []
myPair [x] = []
myPair (x1:x2:xs) = (x1, x2) : myPair xs	
	
myMap :: (a -> b) -> [a] -> [b]
myMap y xs = [y x | x <- xs]

myLookup :: (Eq a) => a -> [(a,b)] -> b
myLookup x ((y,ys):z)
					| x == y = ys
					| otherwise = myLookup x z
					
------------------------------
--- Good Suffix Functions ----
------------------------------

unequal_Number :: (Eq a) => [a] -> [a] -> Int -> Int
unequal_Number [] [] 0 = 1
unequal_Number x y z = if(myLast x /= myLast y)
						then z
						else unequal_Number (myInit x) (myInit y) (z-1)
		
good_Index :: (Eq a) => [a] -> Int -> Int -> Int
good_Index x y z 
				| z == 1 = 1
				| ((isSuffixOf (myDrop(z-1) x) (myTake y x)) && (y <= (myLength x))) = myLength(myTake y x)
				| otherwise	= good_Index x (y+1) z

type Pair_Int = [(Int, Int)]

good_Suffix_Rule :: (Eq a) => [a] -> Pair_Int
good_Suffix_Rule x = 
					myZip([1..(myLength x)]) (myMap (good_Index x 1) [1..(myLength x)])

	
------------------------------
--- Boyer-Moore Algorithm ----
------------------------------

boyer_Moore :: [Char] -> [Char] -> [Int]
boyer_Moore sentence match 
			 | myLength(match) > myLength(sentence) = []
			 | x == x = x : boyer_Moore (myDrop x sentence) match
				where
					unequal = unequal_Number (myTake (myLength match) (sentence)) match (myLength match)
					x =  myLookup unequal (good_Suffix_Rule match) 
						
				