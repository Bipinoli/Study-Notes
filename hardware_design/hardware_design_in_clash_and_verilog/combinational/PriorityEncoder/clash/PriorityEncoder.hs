module PriorityEncoder.PriorityEncoder where

import Clash.Prelude
import Clash.Explicit.Testbench


type Channels = BitVector 8
type Selected = Unsigned 3

priorityEncoder :: (Bit, Channels) -> Selected
priorityEncoder (enable, channels) =
    if bitToBool enable then
        if channels .&. 0b10000000 /= 0 then 7
        else if channels .&. 0b01000000 /= 0 then 6
        else if channels .&. 0b00100000 /= 0 then 5
        else if channels .&. 0b00010000 /= 0 then 4
        else if channels .&. 0b00001000 /= 0 then 3
        else if channels .&. 0b00000100 /= 0 then 2
        else if channels .&. 0b00000010 /= 0 then 1
        else if channels .&. 0b00000001 /= 0 then 0
        else undefined
    else undefined

topEntity :: (Bit, Channels) -> Selected
topEntity = priorityEncoder


-- testbench :: Vec 2 Bool
-- testbench =  done
--     where
--         inputs = (1 :: Bit, 0b01111111 :: Channels) :> (1, 0b00111111) :> Nil
--         expectedOutputs = (6 :: Selected) :> 5 :> Nil
--         outputs = map topEntity inputs
--         done = zipWith (==) outputs expectedOutputs


-- -- Mark testbench as top entity to generate Verilog testbench
-- {-# ANN testbench
--   (Synthesize
--     { t_name   = "testbench"
--     , t_inputs = []
--     , t_output = PortName "done"
--     }) #-}