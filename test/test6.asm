# Test 006
# Commands tested:
#   Tests store commands

.set noreorder

main:   addi $3, $0, -1          # $3 = 0xffffffff
        addi $4, $0, 0x10        # $4 = 0x10
        sw   $3, 0($4)           # Store 0xffffffff in 0x10
        addi $6, $0, 0x5555      # $6 = 0x5555
        sll  $6, $6, 8           # $4 = 0x00555500
        lw   $5, 0($4)           # load $5 = 0x550000ff
        sw   $5, 4($4)           # Store 0x550000ff in 0x14 (test checks this)


