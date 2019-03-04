
checkFour :: [[a]] -> Bool
checkFour [] = False
checkFour (row:rows) 
	| checkFourRow row = True
	| checkFourRow (getCol (row:rows))  
