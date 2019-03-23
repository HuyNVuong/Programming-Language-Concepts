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
     let result = manyPlayersManyMoves game moves
     printGame result

-- YOUR CODE SHOULD COME AFTER THIS POINT
manyPlayersManyMoves :: [[Char]] -> [Int] -> [[Char]]
manyPlayersManyMoves game moves = manyPlayersHelper game '1' moves 