module Cpu where

import Clash.Prelude

-- Non pipelined CPU design based on: https://github.com/Bipinoli/VeriRISCy
import Instruction (WordSize, Instr, decode)
import Execute (IP, Registers, Memory, State, execute)



fetch :: IP -> Memory -> WordSize   
fetch ip memory = memory !! ip


cycle :: State -> State
cycle (regs, memory, ip) = state'
    where 
        instrEncoded = fetch ip memory
        instr = decode instrEncoded
        state' = execute (regs, memory, ip) instr
