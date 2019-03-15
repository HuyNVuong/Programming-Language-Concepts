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
    --- Debugging
    -- let result = putPieceToGame game '5' 8 (head moves)
    --- End of debugging   
    printGame result

-- YOUR CODE SHOULD COME AFTER THIS POINT

onePlayerOneMove :: [[Char]] -> Int -> [[Char]]
onePlayerOneMove game move = oneMoveHelper game '1' (move - 1)
