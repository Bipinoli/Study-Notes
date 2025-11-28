-- Non pipelined CPU design based on: https://github.com/Bipinoli/VeriRISCy

-- Current limitations:
-- 1. Memory is a State within the CPU which should be a device outside connected via bus.Applicative
-- 2. Memory is not properly parameterised
-- 3. .... many others to list here ..

module Cpu where

import Clash.Prelude
import qualified Clash.Sized.Vector as V
import Clash.Explicit.Testbench

import Instruction (WordSize, Instr(..), R, Imm, decode, encode)
import Execute (IP, Registers, Memory, State, execute)



fetch :: IP -> Memory -> WordSize   
fetch ip memory = memory !! ip


cycle :: State -> State
cycle (regs, memory, ip) = state'
    where 
        instrEncoded = fetch ip memory
        instr = decode instrEncoded
        state' = execute (regs, memory, ip) instr


cpu :: HiddenClockResetEnable dom => Signal dom State 
cpu = currentState
    where 
        currentState = register initialState nextState
        initialState = (repeat 0 :: Registers, memory, 0 :: IP) :: State
        nextState = Cpu.cycle <$> currentState
        memory = repeat 0 :: Memory
        



topEntity :: Clock System -> Reset System -> Enable System -> Signal System State
topEntity = exposeClockResetEnable cpu





-- testbench :: Signal System Bool
-- testbench = done
--     where
--         clk = tbSystemClockGen (not <$> done)
--         rst = systemResetGen
--         en = enableGen
--         inputs = stimuliGenerator clk rst (initialState :> Nil)
--         initialState = (repeat 0 :: Registers, memory, 0 :: IP) :: State
--         memory = (encodedProgram ++ (repeat 0)) :: Memory
--         encodedProgram = (map encode $ V.unsafeFromList gcdProgram) :: Vec 11 WordSize
--         gcdProgram = [
--                 MVI r1 78,
--                 MVI r2 143,

--                 -- :loop
--                 SUB r3 r1 r2,
--                 JEZ r3 labelEnd,

--                 GTR r3 r1 r2,
--                 JNZ r3 labelGreater,

--                 SUB r2 r2 r1,
--                 JMP labelLoop,

--                 -- :greater
--                 SUB r1 r1 r2,
--                 JMP labelLoop,

--                 -- :end
--                 HLT
--             ] :: [Instr]
--         r1 = 0 :: R
--         r2 = 1 :: R
--         r3 = 2 :: R
--         labelEnd = 10 :: Imm
--         labelLoop = 2 :: Imm
--         labelGreater = 8 :: Imm 
