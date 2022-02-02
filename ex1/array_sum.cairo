#         .o.        oooooooooooo ooo        ooooo ooooo     ooo ooooooooooooo ooooo   ooooo 
#        .888.      d'""""""d888' `88.       .888' `888'     `8' 8'   888   `8 `888'   `888' 
#       .8"888.           .888P    888b     d'888   888       8       888       888     888  
#      .8' `888.         d888'     8 Y88. .P  888   888       8       888       888ooooo888  
#     .88ooo8888.      .888P       8  `888'   888   888       8       888       888     888  
#    .8'     `888.    d888'    .P  8    Y     888   `88.    .8'       888       888     888  
#   o88o     o8888o .8888888888P  o8o        o888o    `YbodP'        o888o     o888o   o888o                                                                                                                                                                                

%builtins output

from starkware.cairo.common.serialize import serialize_word
from starkware.cairo.common.alloc import alloc

# Computes the sum of the memory elements at addresses:
#   arr + 0, arr + 1, ..., arr + (size - 1).
func array_sum(arr : felt*, size) -> (sum):
    if size == 0:
        return (sum=0)
    end

    # If size is not zero proceed with the calculation.
    let (sum_of_rest) = array_sum(arr=arr + 1, size=size - 1)
    return (sum=[arr] + sum_of_rest)
end

func main{output_ptr : felt*}():
    const ARRAY_SIZE = 6
    let(ptr) = alloc()
    assert[ptr] = 2
    assert[ptr+1] = 3
    assert[ptr+2] = 5
    assert[ptr+3] = 7
    assert[ptr+4] = 11
    assert[ptr+5] = 17
    let(sum) = array_sum(arr=ptr, size=ARRAY_SIZE)
    serialize_word(sum)
    return ()
end