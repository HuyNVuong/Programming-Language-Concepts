put :: Int -> a -> [a] -> [a]
put _ _ [] = []
put n p (y:ys)
	| n == 0 = (p:ys)
	| otherwise = y:put (n - 1) p ys
