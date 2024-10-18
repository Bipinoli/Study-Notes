module Execute where

import Clash.Prelude
import Instruction (WordSize, Instr(..), toSigned, signed2BV)

type RegSize = Signed 32
type Memory = Vec 1024 WordSize
type Registers = Vec 16 RegSize
type IP = RegSize
type State = (Registers, Memory, IP)

execute :: State -> Instr -> State
execute (regs, memory, ip) instr = case instr of
    MOV r1 r2 -> (newRegs, memory, ip + 1)
        where newRegs = replace r1 (regs !! r2) regs
    MVI r1 imm -> (newRegs, memory, ip + 1)
        where newRegs = replace r1 (resize imm) regs
    LOD r1 r2 imm -> (newRegs, memory, ip + 1)
        where
            newRegs = replace r1 val regs
            val = toSigned $ memory !! ((regs !! r2) + resize imm)
    STR r1 r2 imm -> (regs, newMemory, ip + 1)
        where
            newMemory = replace indx val memory
            indx = (regs !! r2) + resize imm
            val = signed2BV $ regs !! r1
    ADD r1 r2 r3 -> (newRegs, memory, ip + 1)
        where newRegs = replace r1 ((regs !! r2) + (regs !! r3)) regs
    SUB r1 r2 r3 -> (newRegs, memory, ip + 1)
        where newRegs = replace r1 ((regs !! r2) - (regs !! r3)) regs
    MUL r1 r2 r3 -> (newRegs, memory, ip + 1)
        where newRegs = replace r1 ((regs !! r2) * (regs !! r3)) regs
    AND r1 r2 r3 -> (newRegs, memory, ip + 1)
        where newRegs = replace r1 ((regs !! r2) .&. (regs !! r3)) regs
    ORR r1 r2 r3 -> (newRegs, memory, ip + 1)
        where newRegs = replace r1 ((regs !! r2) .|. (regs !! r3)) regs
    NOT r1 r2 -> (newRegs, memory, ip + 1)
        where
            newRegs = case regs !! r2 of
                0x0 -> replace r1 1 regs
                _ -> replace r1 0 regs
    LES r1 r2 r3 -> (newRegs, memory, ip + 1)
        where
            newRegs = replace r1 newVal regs
            newVal = if (regs !! r2) < (regs !! r3) then 1 else 0
    GTR r1 r2 r3 -> (newRegs, memory, ip + 1)
        where
            newRegs = replace r1 newVal regs
            newVal = if (regs !! r2) > (regs !! r3) then 1 else 0
    JEZ r1 imm -> (regs, memory, newIp)
        where newIp = if (regs !! r1) == 0 then resize imm else ip + 1
    JNZ r1 imm -> (regs, memory, newIp)
        where newIp = if (regs !! r1) /= 0 then resize imm else ip + 1
    JMP imm -> (regs, memory, resize imm)
    _ -> (regs, memory, ip)
