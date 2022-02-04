%builtins output

from starkware.cairo.common.serialize import serialize_word
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.dict_access import DictAccess
from starkware.cairo.common.squash_dict import squash_dict
from starkware.cairo.common.registers import get_fp_and_pc

struct Location:
    member row: felt
    member col: felt
end

struct DictAccess:
    member key : felt
    member prev_value : felt
    member new_value : felt
end

func verify_valid_location(loc : Location*):
    tempvar row = loc.row
    assert row * (row - 1) * (row - 2) * (row - 3) = 0

    tempvar col = loc.col
    assert col * (col - 1) * (col - 2) * (col - 3) = 0

    return()
end

func verify_adjacend_locations(loc1: Location*, loc2: Location*):
    alloc_locals
    local row_diff = loc1.row - loc2.row
    local col_diff = loc1.col - loc2.col

    if row_diff == 0:
        assert col_diff * col_diff = 1
        return()
    else:
        assert row_diff * row_diff = 1
        assert col_diff = 0
        return()
    end
end

func verify_location_list(loc_list: Location*, n_steps):
    verify_valid_location(loc=loc_list)

    if n_steps ==0:
        return()
    end

    verify_adjacend_locations(loc1=loc_list, loc2= loc_list + Location.SIZE)

    verify_location_list(loc_list = loc_list + Location.SIZE, n_steps = n_steps-1)
    return()
end

func main{output_ptr : felt*}():
    alloc_locals

    local loc_tuple : (Location, Location, Location, Location, Location) = (
        Location(row=0, col=2),
        Location(row=1, col=2),
        Location(row=1, col=3),
        Location(row=2, col=3),
        Location(row=3, col=3),
        )

    # Get the value of the frame pointer register (fp) so that
    # we can use the address of loc_tuple.
    let (__fp__, _) = get_fp_and_pc()
    # Since the tuple elements are next to each other we can use the
    # address of loc_tuple as a pointer to the 5 locations.
    verify_location_list(
        loc_list=cast(&loc_tuple, Location*), n_steps=4)
    return ()
end


