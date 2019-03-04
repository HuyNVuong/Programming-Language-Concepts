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
     let result = onePlayerManyMoves game moves
     printGame result

-- YOUR CODE SHOULD COME AFTER THIS POINT
onePlayerManyMoves :: [[Char]] -> [Int] -> [[Char]]
onePlayerManyMoves game moves = game