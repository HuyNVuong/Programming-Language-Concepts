enqueue :: e -> [e] -> [e]
enqueue el list = list ++ [el]

dequeue :: [e] -> (e, [e])
dequeue (h:t) = (h, t)

size :: [e] -> Integer
size [] = 0
size (h:t) = 1 + (size t)
