module Helpers
( readGreaterThanSudokuFile
, printGame
, oneMove
) where

import Prelude
import Data.Char
import Data.List
import Debug.Trace

readGreaterThanSudokuFile :: String -> IO ([Int],[Int],[[Char]],[[Int]],[[Int]])
readGreaterThanSudokuFile = readIO

printGame :: [[Char]] -> IO ()
printGame [] = do
 print ""
printGame (ro:ros) = do
 print ro
 printGame ros

oneMove :: [[Char]] -> [[Int]] -> [[Int]] -> Int -> Int -> [[Char]]
oneMove game vertical horizontal space value
 | checkValidMove == True = makeMove game (chr (value + 48)) gameRowIndex gameColIndex
 | otherwise              = game --trace ("Invalid") game
 where
   gameRowIndex = getRowIndex space
   gameColIndex = getColIndex space
   checkValidMove   = and[spaceValid, rowColSqrValid, verticalsValid, horizontalsValid]
   spaceValid       = spaceEmpty game space
   rowColSqrValid   = validRowColSquare game value space
   verticalsValid   = validVertical game vertical space value
   horizontalsValid = validHorizontal game horizontal space value


--Logic----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------

-- Checks if the Space is filled in. True - vacant. False - occupied
spaceEmpty :: [[Char]] -> Int -> Bool
spaceEmpty game space
 | get2D game row col == '-' = True --trace ("Space Valid: True") True
 | otherwise                 = True --trace ("Space Valid: False") False
 where
	 row = getRowIndex space
	 col = getColIndex space

validRowColSquare :: [[Char]] -> Int -> Int -> Bool
validRowColSquare game value space = (rowValid && colValid && sqrValid) --trace ("Row Valid: " ++ show rowValid ++ "\nCol Valid: " ++ show colValid ++ "\nSqr Valid: " ++ show sqrValid) (rowValid && colValid && sqrValid)
  where
    rowValid     = validRow gameRow value
    colValid     = validRow gameCol value
    sqrValid     = validRow gameSqr value
    gameRow      = getRow game gameRowIndex
    gameCol      = getCol game gameColIndex
    gameSqr      = getSqr game space
    gameRowIndex = getRowIndex space
    gameColIndex = getColIndex space

validVertical :: [[Char]] -> [[Int]] -> Int -> Int -> Bool
validVertical game vertical space value = (upValid && downValid) --trace ("Up Valid: " ++ show upValid ++ "\nDown Valid: " ++ show downValid) (upValid && downValid)
  where
    upValid    = compareUpValues value upValue upSymbol --trace ("Value: " ++ show value ++ " Up Value: " ++ show upValue ++ " Up Symbol: " ++ show upSymbol) compareUpValues value upValue upSymbol
    upValue    = getValue game space 0
    upSymbol   = verticalSymbol vertical space 0
    downValid  = compareDownValues value downValue downSymbol --trace ("Value: " ++ show value ++ " Down Value: " ++ show downValue ++ " Down Symbol: " ++ show downSymbol) compareDownValues value downValue downSymbol
    downValue  = getValue game space 1
    downSymbol = verticalSymbol vertical space 1

validHorizontal :: [[Char]] -> [[Int]] -> Int -> Int -> Bool
validHorizontal game horizontal space value = (rightValid && leftValid) --trace ("Right Valid: " ++ show rightValid ++ "\nLeft Valid: " ++ show leftValid) (rightValid && leftValid)
  where
    rightValid  = compareRightValues value rightValue rightSymbol --trace ("Value: " ++ show value ++ " Right Value: " ++ show rightValue ++ " right Symbol: " ++ show rightSymbol) compareRightValues value rightValue rightSymbol
    rightValue  = getValue game space 2
    rightSymbol = horizontalSymbol horizontal space 0
    leftValid   = compareLeftValues value leftValue leftSymbol --trace ("Value: " ++ show value ++ " Left Value: " ++ show leftValue ++ " Left Symbol: " ++ show leftSymbol) compareLeftValues value leftValue leftSymbol
    leftValue   = getValue game space 3
    leftSymbol  = horizontalSymbol horizontal space 1

-- Creates new game board with new value
makeMove :: [[a]] -> a -> Int -> Int -> [[a]]
makeMove game value row col =
  take row game ++
  [take col (game !! row) ++ [value] ++ drop (col + 1) (game !! row)] ++
  drop (row + 1) game



-- Checks if an Array has the value already in it
validRow :: [Char] -> Int -> Bool
validRow [] _ = True
validRow (h:t) value
  | h == '-'              = validRow t value
	| value == digitToInt h = False
	| otherwise             = validRow t value

--Helpers--------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
compareUpValues :: Int -> Char -> Int -> Bool
compareUpValues _ _ 0     = True  -- On edge of game board
compareUpValues _ '9' _   = True  -- On edge of game board
compareUpValues 4 _ (- 1) = False -- 4 cannot be less than anything
compareUpValues 1 _ 1     = False -- 1 cannot be greater than anything
compareUpValues _ '-' _   = True  -- Nothing to compare against
compareUpValues value upValue symbol -- Compare two values
  | symbol == -1 = value < digitToInt(upValue)
  | otherwise    = value > digitToInt(upValue)

compareDownValues :: Int -> Char -> Int -> Bool
compareDownValues _ _ 0     = True  -- On edge of game board
compareDownValues _ '9' _   = True  -- On edge of game board
compareDownValues 1 _ (- 1) = False -- 1 cannot be greater than anything
compareDownValues 4 _ 1     = False -- 4 cannot be less than anything
compareDownValues _ '-' _   = True  -- Nothing to compare against
compareDownValues value downValue symbol -- Compare two values
  | symbol == -1 = value > digitToInt(downValue)
  | otherwise    = value < digitToInt(downValue)

compareRightValues :: Int -> Char -> Int -> Bool
compareRightValues _ _ 0     = True  -- On edge of game board
compareRightValues _ '9' _   = True  -- On edge of game board
compareRightValues 1 _ (- 1) = False -- 4 cannot be less than anything
compareRightValues 4 _ 1     = False -- 1 cannot be greater than anything
compareRightValues _ '-' _   = True  -- Nothing to compare against
compareRightValues value rightValue symbol -- Compare two values
  | symbol == -1 = value > digitToInt(rightValue)
  | otherwise    = value < digitToInt(rightValue)

compareLeftValues :: Int -> Char -> Int -> Bool
compareLeftValues _ _ 0     = True  -- On edge of game board
compareLeftValues _ '9' _   = True  -- On edge of game board
compareLeftValues 4 _ (- 1) = False -- 4 cannot be less than anything
compareLeftValues 1 _ 1     = False -- 4 cannot be greater than anything
compareLeftValues _ '-' _   = True  -- Nothing to compare against
compareLeftValues value leftValue symbol -- Compare two values
  | symbol == -1 = digitToInt(leftValue) > value
  | otherwise    = digitToInt(leftValue) < value

-- Direction: 0-Up 1-Down 2-Right 3-Left
getValue :: [[Char]] -> Int -> Int-> Char
getValue game space direction
  -- Column 0
  -- Space 1
  | space == 1 && direction == 1 = game!!1!!0 -- Down
  | space == 1 && direction == 2 = game!!0!!1 -- Right
  -- Space 2
  | space == 2 && direction == 0 = game!!0!!0 -- Up
  | space == 2 && direction == 1 = game!!2!!0 -- Down
  | space == 2 && direction == 2 = game!!1!!1 -- Right
  -- Space 3
  | space == 3 && direction == 0 = game!!1!!0 -- Up
  | space == 3 && direction == 1 = game!!3!!0 -- Down
  | space == 3 && direction == 2 = game!!2!!1 -- Right
  -- Space 4
  | space == 4 && direction == 0 = game!!2!!0 -- Up
  | space == 4 && direction == 2 = game!!3!!1 -- Right

  -- Column 1
  -- Space 5
  | space == 5 && direction == 1 = game!!1!!1 -- Down
  | space == 5 && direction == 2 = game!!0!!2 -- Right
  | space == 5 && direction == 3 = game!!0!!0 -- Left
  -- Space 6
  | space == 6 && direction == 0 = game!!0!!1 -- Up
  | space == 6 && direction == 1 = game!!2!!1 -- Down
  | space == 6 && direction == 2 = game!!1!!2 -- Right
  | space == 6 && direction == 3 = game!!1!!0 -- Left
  -- Space 7
  | space == 7 && direction == 0 = game!!1!!1 -- Up
  | space == 7 && direction == 1 = game!!3!!1 -- Down
  | space == 7 && direction == 2 = game!!2!!2 -- Right
  | space == 7 && direction == 3 = game!!2!!0 -- Left
  -- Space 8
  | space == 8 && direction == 0 = game!!2!!1 -- Up
  | space == 8 && direction == 2 = game!!3!!2 -- Right
  | space == 8 && direction == 3 = game!!3!!0 -- Left

  -- Column 2
  -- Space 9
  | space == 9 && direction == 1 = game!!1!!2 -- Down
  | space == 9 && direction == 2 = game!!0!!3 -- Right
  | space == 9 && direction == 3 = game!!0!!1 -- Left
  -- Space 10
  | space == 10 && direction == 0 = game!!0!!2 -- Up
  | space == 10 && direction == 1 = game!!2!!2 -- Down
  | space == 10 && direction == 2 = game!!1!!3 -- Right
  | space == 10 && direction == 3 = game!!1!!1 -- Left
  -- Space 11
  | space == 11 && direction == 0 = game!!1!!2 -- Up
  | space == 11 && direction == 1 = game!!3!!2 -- Down
  | space == 11 && direction == 2 = game!!2!!3 -- Right
  | space == 11 && direction == 3 = game!!2!!1 -- Left
  -- Space 12
  | space == 12 && direction == 0 = game!!2!!2 -- Up
  | space == 12 && direction == 2 = game!!3!!3 -- Right
  | space == 12 && direction == 3 = game!!3!!1 -- Left

  -- Column 3
  -- Space 13
  | space == 13 && direction == 1 = game!!1!!3 -- Down
  | space == 13 && direction == 3 = game!!0!!2 -- Left
  -- Space 14
  | space == 14 && direction == 0 = game!!0!!3 -- Up
  | space == 14 && direction == 1 = game!!2!!3 -- Down
  | space == 14 && direction == 3 = game!!1!!2 -- Left
  -- Space 15
  | space == 15 && direction == 0 = game!!1!!3 -- Up
  | space == 15 && direction == 1 = game!!3!!3 -- Down
  | space == 15 && direction == 3 = game!!2!!2 -- Left
  -- Space 16
  | space == 16 && direction == 0 = game!!2!!3 -- Up
  | space == 16 && direction == 3 = game!!3!!2 -- Left
  | otherwise                     = '9'

-- Direction 0-Up 1-Down
verticalSymbol :: [[Int]] -> Int -> Int -> Int
verticalSymbol vertical space direction
  -- Col 0
  | space == 1 && direction == 1 = vertical!!0!!0
  | space == 2 && direction == 1 = vertical!!1!!0
  | space == 3 && direction == 1 = vertical!!2!!0
  | space == 2 && direction == 0 = vertical!!0!!0
  | space == 3 && direction == 0 = vertical!!1!!0
  | space == 4 && direction == 0 = vertical!!2!!0
  -- Col 1
  | space == 5 && direction == 1 = vertical!!0!!1
  | space == 6 && direction == 1 = vertical!!1!!1
  | space == 7 && direction == 1 = vertical!!2!!1
  | space == 6 && direction == 0 = vertical!!0!!1
  | space == 7 && direction == 0 = vertical!!1!!1
  | space == 8 && direction == 0 = vertical!!2!!1
  -- Col 2
  | space == 9  && direction == 1 = vertical!!0!!2
  | space == 10 && direction == 1 = vertical!!1!!2
  | space == 11 && direction == 1 = vertical!!2!!2
  | space == 10 && direction == 0 = vertical!!0!!2
  | space == 11 && direction == 0 = vertical!!1!!2
  | space == 12 && direction == 0 = vertical!!2!!2
  -- Col 3
  | space == 13 && direction == 1 = vertical!!0!!3
  | space == 14 && direction == 1 = vertical!!1!!3
  | space == 15 && direction == 1 = vertical!!2!!3
  | space == 14 && direction == 0 = vertical!!0!!3
  | space == 15 && direction == 0 = vertical!!1!!3
  | space == 16 && direction == 0 = vertical!!2!!3
  | otherwise                    = 0

-- Direction 0-Right 1-Left
horizontalSymbol :: [[Int]] -> Int -> Int -> Int
horizontalSymbol horizontal space direction
  --Col 0
  | space == 1 && direction == 0 = horizontal!!0!!0
  | space == 2 && direction == 0 = horizontal!!1!!0
  | space == 3 && direction == 0 = horizontal!!2!!0
  | space == 4 && direction == 0 = horizontal!!3!!0
  --Col 1
  | space == 5 && direction == 0 = horizontal!!0!!1
  | space == 6 && direction == 0 = horizontal!!1!!1
  | space == 7 && direction == 0 = horizontal!!2!!1
  | space == 8 && direction == 0 = horizontal!!3!!1
  | space == 5 && direction == 1 = horizontal!!0!!0
  | space == 6 && direction == 1 = horizontal!!1!!0
  | space == 7 && direction == 1 = horizontal!!2!!0
  | space == 8 && direction == 1 = horizontal!!3!!0
  --Col 2
  | space == 9  && direction == 0 = horizontal!!0!!2
  | space == 10 && direction == 0 = horizontal!!1!!2
  | space == 11 && direction == 0 = horizontal!!2!!2
  | space == 12 && direction == 0 = horizontal!!3!!2
  | space == 9  && direction == 1 = horizontal!!0!!1
  | space == 10 && direction == 1 = horizontal!!1!!1
  | space == 11 && direction == 1 = horizontal!!2!!1
  | space == 12 && direction == 1 = horizontal!!3!!1
  -- Col 3
  | space == 13 && direction == 1 = horizontal!!0!!2
  | space == 14 && direction == 1 = horizontal!!1!!2
  | space == 15 && direction == 1 = horizontal!!2!!2
  | space == 16 && direction == 1 = horizontal!!3!!2
  | otherwise                    = 0

-- Gets the row the space is in
getRowIndex :: Int -> Int
getRowIndex x
  | x == 1 || x == 5 || x == 9  || x == 13 = 0
	| x == 2 || x == 6 || x == 10 || x == 14 = 1
	| x == 3 || x == 7 || x == 11 || x == 15 = 2
	| x == 4 || x == 8 || x == 12 || x == 16 = 3
-- Gets the column the space is in
getColIndex :: Int -> Int
getColIndex x
	| x == 1  || x == 2  || x == 3  || x == 4  = 0
	| x == 5  || x == 6  || x == 7  || x == 8  = 1
  | x == 9  || x == 10 || x == 11 || x == 12 = 2
  | x == 13 || x == 14 || x == 15 || x == 16 = 3
-- Gets the entire row
getRow :: [[a]] -> Int -> [a]
getRow game row = game!!row
-- Gets the entire Col
getCol :: [[a]] -> Int -> [a]
getCol game col = [game!!0!!col, game!!1!!col, game!!2!!col, game!!3!!col]
-- Gets the corner sqare the space is located in
getSqr :: [[a]] -> Int -> [a]
getSqr game x
	| x == 1   || x == 2   || x == 5   || x == 6  = [game!!0!!0, game!!0!!1, game!!1!!0, game!!1!!1]
	| x == 3   || x == 4   || x == 7   || x == 8  = [game!!2!!0, game!!2!!1, game!!3!!0, game!!3!!1]
	| x == 9   || x == 10  || x == 13  || x == 14 = [game!!0!!2, game!!0!!3, game!!1!!2, game!!1!!3]
	| x == 11  || x == 12  || x == 15  || x == 16 = [game!!2!!2, game!!2!!3, game!!3!!2, game!!3!!3]
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------

-- The following functions are examples from Ryan Patrick
get2D :: [[a]] -> Int -> Int -> a
-- get a single item out of a list of lists of that type of item by row/col
get2D (row:rows) ro co
      | ro == 0		= get1D row co
      | otherwise	= get2D rows (ro-1) co

get1D :: [a] -> Int -> a
-- get a single item out of a list of that type of item by col
get1D (col:cols) ind
      | ind == 0	= col
      | otherwise	= get1D cols (ind-1)