-- reverse_recursive :: [a] -> [a]  
-- reverse_recursive [] = []  
-- reverse_recursive (x:xs) = (reverse_match xs) ++ [x]  

reverseList :: [[Char]] -> [[Char]] 
reverseList []      = []
reverseList (x:xs)  = (reverseList xs) ++ [x]