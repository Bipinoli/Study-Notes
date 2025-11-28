module RingBuffer where

import Clash.Prelude
import Clash.Explicit.Testbench


type MemorySize = 10
type Value = Signed 8
type Memory = Vec MemorySize Value
type HeadPos = Unsigned 4 -- 4 bits to store upto 10
type TailPos = Unsigned 4

data Instr = Push Value | Pop


ringBufferFx :: (Memory, HeadPos, TailPos) -> Instr -> ((Memory, HeadPos, TailPos), Value)
ringBufferFx (memory, head, tail) instr = ((nextMemory, nextHead, nextTail), output)
    where
        (nextMemory, nextHead, nextTail, output) = case instr of
            Push val -> (replace head val memory, (head + 1) `mod` 10, tail, 0)
            Pop -> (memory, head, (tail + 1) `mod` 10, memory !! tail)


-- mealy : https://hackage.haskell.org/package/clash-prelude-1.8.1/docs/Clash-Prelude.html#v:mealy
ringBuffer :: HiddenClockResetEnable dom => Signal dom Instr -> Signal dom Value
ringBuffer = mealy ringBufferFx (repeat 0 :: Memory, 0 :: HeadPos, 0 :: TailPos)


topEntity :: Clock System -> Reset System -> Enable System -> Signal System Instr -> Signal System Value
topEntity = exposeClockResetEnable ringBuffer


testbench :: Signal System Bool
testbench = done
    where
        clk = tbSystemClockGen (not <$> done)
        rst = systemResetGen
        en = enableGen
        inputs = stimuliGenerator clk rst (Push 1 :> Push 2 :> Push 3 :> Pop :> Pop :> Push 4 :> Push 5 :> Pop :> Pop :> Nil)
        -- intentionally wrong '13' to trigger tail failure
        expectedOutputs = outputVerifier' clk rst (0 :> 0 :> 0 :> 1 :> 2 :> 0 :> 0 :> 13 :> 4 :> Nil) 
        done = expectedOutputs (topEntity clk rst en inputs)


-- Mark testbench as top entity to generate Verilog testbench
{-# ANN testbench
  (Synthesize
    { t_name   = "testbench"
    , t_inputs = []
    , t_output = PortName "done"
    }) #-}
