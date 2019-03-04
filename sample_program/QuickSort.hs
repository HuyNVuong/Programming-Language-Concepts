quickSort :: Ord a => [a] -> [a]
quickSort [] = []
quickSort (h:t) = (quickSort [b|b < -t,b <= h]) ++ [h] ++ (quickSort [a|a < -t, a > h])

