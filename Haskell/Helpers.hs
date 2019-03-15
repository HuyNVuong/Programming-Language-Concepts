module Helpers
( readConnectFourFile
, printGame
, onePlayerHelper
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
-- Code, Logic implementation to play the connect Four in variations -------
----------------------------------------------------------------------------

onePlayerHelper :: [[Char]] -> Char -> Int -> [[Char]]
onePlayerHelper game player move 
    | isEmptyPlace colToPlay move == True	= putPieceToGame game player row col
    | otherwise								= putPieceToGame game player row col
    where 
        colToPlay		= getCol game move
        row 			= findPlaceToMove colToPlay (length colToPlay)
        col				= move					

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
    | otherwise							= True 

getElementInMatrix :: [[Char]] -> Int -> Int -> Char 
getElementInMatrix (row:rows) y x 
    | y == 1	= getElement row x 
    | otherwise = getElementInMatrix rows (y - 1) x

reverseList :: [[Char]] -> [[Char]] 
reverseList []      = []
reverseList (x:xs)  = (reverseList xs) ++ [x]

getNextMove :: [Int] -> Int 
getNextMove (h:t)	= h 

getElement :: [Char] -> Int -> Char 
getElement (el:els) 1	= el
getElement (el:els) n 	= getElement (els) (n - 1)

getCol :: [[Char]] -> Int -> [Char] 
getCol [row] col		= [(getElement row col)]
getCol (row:rows) col 	= (getElement row col):(getCol rows col)