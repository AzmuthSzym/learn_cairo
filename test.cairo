%builtins output

from starkware.cairo.common.serialize import serialize_word
from starkware.cairo.common.alloc import alloc

func main{output_ptr : felt*}():
    alloc_locals
    local dddd
    assert(dddd) = 10
    serialize_word(dddd)
    serialize_word(dddd-20)
    # serialize_word(6 / 3)
    # serialize_word(10 / 3)
    # serialize_word(7 / 3)
    # serialize_word(4 / 3)
    # serialize_word(1206167596222043737899107594365023368541035738443865566657697352045290673496 * 4)
    return ()
end

#func main():
#    [ap] = 1000; ap++
#    [ap] = 2000; ap++
#    [ap] = [ap - 2] + [ap - 1]; ap++
#    ret
#end