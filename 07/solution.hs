all' :: (a -> Bool) -> [a] -> Bool
all' p xs = and (map (p) xs)

-- any' :: (a -> Bool) -> [a] -> Bool
-- any' p  xs = or  (map (p) xs)

takeWhile' :: (a -> Bool) -> [a] -> [a]
takeWhile' f [] = []
takeWhile' f (x:xs) = if f x then x : takeWhile' f xs else []

dropWhile' :: (a -> Bool) -> [a] -> [a]
dropWhile' f [] = []
dropWhile' f (x:xs) = if f x then dropWhile' f xs else x:xs

-- 03:
map_foldr :: (a -> b) -> [a] -> [b]
map_foldr f xs = foldr (\x xs -> f x : xs) [] xs

filter_foldr :: (a -> Bool) -> [a] -> [a]
filter_foldr f xs = foldr (\x xs -> if f x then x : xs else xs) [] xs

-- 04:
dec2int :: [Int] -> Int
dec2int = foldl (\x y -> x*10+y) 0

-- 05:
curry' :: ((a,b) -> c) -> a -> b -> c
curry' f x y = f (x,y)

uncurry' :: (a -> b -> c) -> (a,b) -> c
uncurry' f (x,y) = f x y

-- 06:
unfold p h t x | p x = []
               | otherwise = h x : unfold p h t (t x) 

data Bit = Int
chop8_unfold :: [Bit] -> [[Bit]]
chop8_unfold = unfold null (take 8) (drop 8)

map_unfold :: (a -> b) -> [a] -> [b]
map_unfold f xs = unfold null (f.head) (tail) xs

interate_unfold :: (a -> a) -> a -> [a]
interate_unfold f x = unfold (\x -> False) (id) (f) x

-- 09:
altMap :: (a -> b) -> (a -> b) -> [a] -> [b]
altMap m n xs = [ if (k `mod` 2 == 1) then m v else n v | (v, k) <- zip xs [1..]]

-- 10:
luhnDouble :: Int -> Int
luhnDouble n | n > 4 = n*2 - 9
             | otherwise = n*2

luhn :: [Int] -> Bool
luhn xs = sum (altMap luhnDouble id xs) `mod` 10 == 0
