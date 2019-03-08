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
getElement :: [Char] -> Int -> Char 
getElement (el:els) 0 = el 
getElement (el:els) n = getElement els (n - 1)

getCol :: [[Char]] -> Int -> [Char]
getCol [row] col = [(getElement row col)]
getCol (row:rows) col = (getElement row col):(getCol rows col)

onePlayerOneMove :: [[Char]] -> Int -> [[Char]]
onePlayerOneMove game move = game
    where colToPlay = getCol game (move - 1)
            where pointToPlay = case i of
                '-' ->  '1'
        
    