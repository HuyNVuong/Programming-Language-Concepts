enqueue :: e -> [e] -> [e]
enqueue el list = list ++ [el]

dequeue :: [e] -> e
dequeue (h:t) = h

size :: [e] -> Integer
size [] = 0
size (h:t) = 1 + (size t)
