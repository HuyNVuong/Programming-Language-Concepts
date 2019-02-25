ourLength :: [a] -> Integer
ourLength [] = 0
ourLength (h:t) = (ourLength t) + 1
