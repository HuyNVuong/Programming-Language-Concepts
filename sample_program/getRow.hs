-- Get a row in a matrix based on row number
getRow :: [[a]] -> Integer -> [a]
getRow (row:rows) 0 = row
getRow (row:rows) n = getRow rows (n-1)
