
getElement :: [a] -> Integer -> a
getElement (el:els) 0 = el
getElement (el:els) n = getElement els (n - 1)

getCol :: [[a]] -> Integer -> [a]
getCol [row] col = [(getElement row col)]
getCol (row:rows) col = (getElement row col):(getCol rows col)
--getCol [row] col = [(getElement row col)]
