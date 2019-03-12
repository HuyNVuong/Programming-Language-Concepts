import Prelude
import System.Environment ( getArgs )
import Data.List
import Helpers 

-- The main method that will be used for testing / comgand line access
main = do
    args <- getArgs
    filename <- readFile (head args)
    (game,moves) <- readConnectFourFile filename
    print "Result"
    let result = onePlayerOneMove game (head moves)
    printGame result

-- YOUR CODE SHOULD COME AFTER THIS POINT


onePlayerOneMove :: [[Char]] -> Int -> [[Char]]
onePlayerOneMove game move = game 
        where game = reverseList RevGame
                where 
                revGame = onePlayerHelper revGame '1' move
                revGame = reverseList game 
                revGame = putCol move 

reverseList :: [[Char]] -> [[Char]] 
reverseList []      = []
reverseList (x:xs)  = (reverseList xs) ++ [x]
                
onePlayerHelper :: [[Char]] -> Char -> Int -> [[Char]]
onePlayerHelper [] _ _  = []

getElement :: Int -> [Char] -> Char 
getElement 1 (el:els)   = el 
getElement n (el:els)    = getElement (n - 1) els 

dropElement :: Int -> [Char] -> [Char]
dropElement _ []        = []
dropElement i row       = left ++ right 
        where (left, (_:right)) = Data.List.splitAt i row

putElement :: Int -> Char -> [Char] -> [Char] 
putElement _ _ []       = []
putElement n p (y:ys)
        | n == 0        = (p:ys)
        | otherwise     = y:putElement (n - 1) p ys 

getCol :: Int -> [[Char]] -> [Char]
getCol col [row]        = [(getElement col row)]    
getCol col (row:rows)   = (getElement col row):(getCol col rows)

putCol :: Int -> [Char] -> [[Char]] -> [[Char]]
putCol _ [] []          = [] 

dropCol :: Int -> [[Char]] -> [[Char]] 
dropCol _ []            = [] 

getRow :: [[Char]] -> Int -> [Char]
getRow (row:rows) 0     = row 
getRow (row:rows) n     = getRow rows (n - 1)

-- https://stackoverflow.com/questions/5852722/replace-individual-list-elements-in-haskell

putPiece :: Int -> (Char -> Char) -> [[Char]] -> [[Char]]
putPiece _ _ []         = []




    