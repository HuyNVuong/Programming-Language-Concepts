module Helpers
( readConnectFourFile
, printGame
, oneMoveHelper
, putPieceToGame
, manyMoveHelper
, manyPlayersOneMoveHelper
, manyPlayersHelper
, checkFour
) where

import Prelude
import Data.Char
import Data.List
import Debug.Trace

readConnectFourFile :: String -> IO ([[Char]], [Int])
readConnectFourFile = readIO 

printGame :: [[Char]] -> IO () 
printGame [] = do 
	print ""

printGame (row:rows) = do	
	print row
	printGame rows


----------------------------------------------------------------------------
---- Code, Logic implementation to play the connect Four in variations -----
----------------------------------------------------------------------------

checkFour :: [[Char]] -> Bool 
checkFour [row]                          = checkFourRow row
checkFour (row:rows)
        | checkFourRow row == True     = True 
        | otherwise                    = checkFour rows

checkFourRow :: [Char] -> Bool 
checkFourRow [ _ , _ , _ ]               = False
checkFourRow (p1:p2:p3:p4:t)
           | p1 == p2 && p1 == p3 && p1 == p4  && p1 /= '-' = True 
           | otherwise                                      = checkFourRow (p2:p3:p4:t)

checkFourDiagRight :: [[Char]] -> Bool 
checkFourDiagRight rows 
                 | length rows < 4               = False
                 | length (head rows) < 4        = False
                 | checkFourRow diag == True     = True 
                 | otherwise                     = checkFourDiagRight newRows
                 where 
                         diag                    = getDiagToRight rows 
                         newRows                 = dropFirstCol rows 
        
checkFourDiagLeft :: [[Char]] -> Bool 
checkFourDiagLeft rows 
                | length rows < 4               = False
                | length (head rows) < 4        = False
                | checkFourRow diag == True     = True 
                | otherwise                     = checkFourDiagLeft newRows
                where
                        diag                    = getDiagToLeft rows 
                        newRows                 = dropLastCol rows

checkFourDiag :: [[Char]] -> Bool 
checkFourDiag (row:rows) 
            | length (row:rows) < 4                 = False
            | length row < 4                        = False
            | checkFourDiagLeft (row:rows) == True  = True
            | checkFourDiagRight (row:rows) == True = True
            | otherwise                             = checkFourDiag rows 

oneMoveHelper :: [[Char]] -> Char -> Int -> [[Char]]
oneMoveHelper game player move = putPieceToGame game player row col
    where 
        colToPlay		= getCol game (move + 1)
        row 			= findPlaceToMove colToPlay (length colToPlay)
        col				= move
        
manyMoveHelper :: [[Char]] -> Char -> [Int] -> [[Char]]
manyMoveHelper game _ [] = game
manyMoveHelper game player (move:moves) 
             | checkFour game == True      = game 
             | checkFour tGame == True     = game 
             | checkFourDiag game == True  = game
             | otherwise                   = manyMoveHelper newGame player moves 
               where 
                   newGame                 = oneMoveHelper game player (move - 1)
                   tGame                   = transpose game

manyPlayersOneMoveHelper :: [[Char]] -> Char -> [Int] -> [[Char]]
manyPlayersOneMoveHelper game _ [] = game 
manyPlayersOneMoveHelper game player (move:moves) 
                       | checkFour game == True        = game 
                       | checkFour tGame == True       = game 
                       | charToInt player == numPlayer = oneMoveHelper game player (move - 1)
                       | otherwise                     = manyPlayersOneMoveHelper newGame nextPlayer moves 
                         where 
                             newGame                   = oneMoveHelper game player (move - 1)
                             tGame                     = transpose game
                             nextPlayer                = findNextPlayer player numPlayer
                             numPlayer                 = findNumPlayer game
                             
manyPlayersHelper :: [[Char]] -> Char -> [Int] -> [[Char]]
manyPlayersHelper game _ [] = game 
manyPlayersHelper game player (move:moves) 
                | checkFour game == True        = game 
                | checkFour tGame == True       = game 
                | checkFourDiag game == True    = game
                | otherwise                     = manyPlayersHelper newGame nextPlayer moves 
                  where 
                      newGame                   = oneMoveHelper game player (move - 1)
                      tGame                     = transpose game
                      nextPlayer                = findNextPlayer player numPlayer
                      numPlayer                 = findNumPlayer game

getRow :: [[Char]] -> Int -> [Char]
getRow (row:rows) 0     = row 
getRow (row:rows) n     = getRow rows (n - 1)

findPlaceToMove :: [Char] -> Int -> Int 
findPlaceToMove row 0               = -1
findPlaceToMove row n
	| isEmptyPlace row n == True	= n - 1
	| otherwise						= findPlaceToMove row (n - 1)

putPieceToGame :: [[Char]] -> Char -> Int -> Int -> [[Char]]
putPieceToGame game player (-1) _ = game 
putPieceToGame game player _ (-1) = game
putPieceToGame [] _ _ _ = []
putPieceToGame game player y x = take y game 
    ++ [take x (game !! y) ++ [player] ++ drop (x + 1) (game !! y)] 
    ++ drop (y + 1) game 

isEmptyPlace :: [Char] -> Int -> Bool 
isEmptyPlace colToPlay row  
    | getElement colToPlay row == '-'	= True 
    | otherwise							= False 

getElement :: [Char] -> Int -> Char 
getElement (el:els) 1	= el
getElement (el:els) n 	= getElement (els) (n - 1)

getCol :: [[Char]] -> Int -> [Char] 
getCol [row] col		= [(getElement row col)]
getCol (row:rows) col 	= (getElement row col):(getCol rows col)

getDiagToRight :: [[Char]] -> [Char]
getDiagToRight (row:rows)
	         | ((length row) >= 4) && (length (row:rows) >= 4) = ourDiag
	         | otherwise	      	 	 	       	           = []
             where 
                   ourDiag  = first ++ secnd ++ third ++ frth 
                   first    = [head row]
                   secnd    = [head (tail (head rows))]
                   third    = [head (drop 2 (head (drop 1 rows)))]
                   frth     = [head (drop 3 (head (drop 2 rows)))]
                   
getDiagToLeft :: [[Char]] -> [Char] 
getDiagToLeft (row:rows) 
            | ((length row) >= 4) && (length (row:rows) >= 4) = ourDiag
            | otherwise                                       = []
            where
                  ourDiag   = first ++ secnd ++ third ++ frth
                  first     = [head (drop (n - 1) row)]
                  secnd     = [head (drop (n - 2) (head rows))]
                  third     = [head (drop (n - 3) (head (drop 1 rows)))]
                  frth      = [head (drop (n - 4) (head (drop 2 rows)))]
                  n         = length row 

dropFirstCol :: [[Char]] -> [[Char]]
dropFirstCol [] = []
dropFirstCol (row:rows) = (tail row):(dropFirstCol rows)

dropLastCol :: [[Char]] -> [[Char]] 
dropLastCol [] = []
dropLastCol (row:rows) = (newRow):(dropLastCol rows)
        where 
            newRow = popAt n row
            n = (length row) - 1 

popAt :: Int -> [Char] -> [Char]
popAt _ []     = []
popAt i (x:xs)
    | i == 0    = xs
    | otherwise = x:(popAt (i-1) xs)
            
findNextPlayer :: Char -> Int -> Char
findNextPlayer player numPlayer 
             | (charToInt player) == numPlayer = '1' 
             | otherwise                       = intToChar ((charToInt player) + 1)

findNumPlayer :: [[Char]] -> Int
findNumPlayer [row]     = maxFromList row 
findNumPlayer (row:rows)
    | findNumPlayer rows > maxFromList row  = findNumPlayer rows 
    | otherwise                             = maxFromList row

everyOnePlayed :: Char -> Int -> Bool 
everyOnePlayed player numPlayer 
    | (charToInt player) == numPlayer   = True 
    | otherwise                         = False

maxFromList :: [Char] -> Int 
maxFromList [x]         = charToInt x 
maxFromList (x:xs)
    | (maxFromList xs) > (charToInt x)  = maxFromList xs 
    | otherwise                         = charToInt x

intToChar :: Int -> Char 
intToChar num 
    | num == 1  = '1'
    | num == 2  = '2'
    | num == 3  = '3'
    | num == 4  = '4'
    | num == 5  = '5'
    | num == 6  = '6'
    | num == 7  = '7'
    | num == 8  = '8'
    | num == 9  = '9'

charToInt :: Char -> Int 
charToInt player 
    | player == '1'  = 1
    | player == '2'  = 2
    | player == '3'  = 3
    | player == '4'  = 4
    | player == '5'  = 5
    | player == '6'  = 6
    | player == '7'  = 7
    | player == '8'  = 8
    | player == '9'  = 9
    | otherwise      = 0