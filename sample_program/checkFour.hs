
checkFour :: [[a]] -> Bool
checkFour [] = False
checkFour (row:rows) 
          | checkFourRow row = True
          | checkFourRow (getCol (row:rows))  
          | checkFour rows = True
          | checkFourDiag (getDiag (row:rows)) = True
          where transpose = ourTranspose (row:rows)

getElement :: [a] -> Integer -> a
getElement (el:els) 0 = el
getElement (el:els) n = getElement els

getCol :: [[a]] -> Integer -> [a]
getCol [row] co = [(getElement row co)]
getCol (row:rows) co = (getElement row co):(getCol rows co)


getDiag :: [[a]] -> [a] 
getDiag [[]] = []

checkFourRow :: [a] -> Bool
checkFourRow [] = True

checkFourDiag :: [a] -> Bool
checkFourDiag [] = True

dropFirstCol :: [[a]] -> [[a]]
dropFirstCol [] = []
dropFirstCol (row:rows) = (tail row):(dropFirstCol rows)

dropCol :: [[a]] -> Integer -> [[a]]
dropCol [] _ = []

ourTranspose :: [[a]] -> [[a]]
ourTranspose [] = []
ourTranspose (row:rows) = (getCol (row:rows) 1):(ourTranspose (dropFirstCol))
