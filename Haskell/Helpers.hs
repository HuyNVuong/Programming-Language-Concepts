module Helpers
( readConnectFourFile
, printGame
, oneMoveHelper
, putPieceToGame
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

oneMoveHelper :: [[Char]] -> Char -> Int -> [[Char]]
oneMoveHelper game player move = putPieceToGame game player row col
    where 
        colToPlay		= getCol game move
        row 			= findPlaceToMove colToPlay (length colToPlay)
        col				= move		
        
manyMoveHelper :: [[Char]] -> Char -> [Int] -> [[Char]]
manyMoveHelper game _ [] = game 
manyMoveHelper game player moves = manyMoveHelper nextGame player moves 
    where 
        nextGame        = putPieceToGame game player row col 
        (move, moves)   = getNextMove moves 
        col             = move
        row             = findPlaceToMove colToPlay col  
        colToPlay       = getCol game col 

manyPlayerHelper :: [[Char]] -> Char -> [Int] -> [[Char]]
manyPlayerHelper game player moves 
    | everyOnePlayed nextPlayer numPlayer == False   = manyPlayerHelper nextGame nextPlayer moves
    | otherwise                                      = oneMoveHelper game nextPlayer nextMove 
    where 
        player     = '1'
        nextPlayer = '2'
        (nextMove, moves)   = getNextMove moves 
        numPlayer   = findNumPlayer game 
        nextGame    = oneMoveHelper game nextPlayer nextMove


getRow :: [[Char]] -> Int -> [Char]
getRow (row:rows) 0     = row 
getRow (row:rows) n     = getRow rows (n - 1)

findPlaceToMove :: [Char] -> Int -> Int 
findPlaceToMove row n
	| isEmptyPlace row n == True	= n - 1
	| otherwise						= findPlaceToMove row (n - 1)

putPieceToGame :: [[Char]] -> Char -> Int -> Int -> [[Char]]
putPieceToGame [] _ _ _ = []
putPieceToGame game player y x = take y game 
    ++ [take x (game !! y) ++ [player] ++ drop (x + 1) (game !! y)] 
    ++ drop (y + 1) game 

isEmptyPlace :: [Char] -> Int -> Bool 
isEmptyPlace colToPlay row  
    | getElement colToPlay row == '-'	= True 
    | otherwise							= False 

getElementInMatrix :: [[Char]] -> Int -> Int -> Char 
getElementInMatrix (row:rows) y x 
    | y == 1	= getElement row x 
    | otherwise = getElementInMatrix rows (y - 1) x

getNextMove :: [Int] -> (Int, [Int]) 
getNextMove (h:t)	= (h, t)

getElement :: [Char] -> Int -> Char 
getElement (el:els) 1	= el
getElement (el:els) n 	= getElement (els) (n - 1)

getCol :: [[Char]] -> Int -> [Char] 
getCol [row] col		= [(getElement row col)]
getCol (row:rows) col 	= (getElement row col):(getCol rows col)

findNextPlayer :: Char -> Int -> Char
findNextPlayer player numPlayer = 
    intToChar (((charToInt player) + 1) `mod` (numPlayer + 1))

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