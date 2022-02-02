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


# Computes the product of all even elements in the array:
#  ([arr] * [arr + 2] * ...)
func array_even_mul(arr : felt*, size) -> (mul):
    if size == 0:
        return (mul=1)
    end

    let(partial_mul) = array_even_mul(arr=arr + 2, size = size - 2)
    return (mul=[arr] * partial_mul)
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
    let(mul) = array_even_mul(arr=ptr, size=ARRAY_SIZE)
    serialize_word(mul)
    return ()
end