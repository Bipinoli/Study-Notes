module BidirectionalShiftRegister.BidirectionalShiftRegister where

import Clash.Prelude
import Clash.Explicit.Testbench


type Value = BitVector 8
type State = Value 

shiftFx :: State -> (Bit, Bit, Value) -> (State, Value)
shiftFx state (load, shiftLeft, datain) = (nextState, outputValue)
    where
        (nextState, outputValue) = case load of 
            1 -> (datain, datain)
            0 -> case shiftLeft of 
                1 -> (shiftL state 1, shiftL state 1)
                0 -> (shiftR state 1, shiftR state 1)


bidirectionalShiftRegister :: HiddenClockResetEnable dom => Signal dom (Bit, Bit, Value) -> Signal dom Value
bidirectionalShiftRegister = mealy shiftFx (0 :: State)


topEntity :: Clock System -> Reset System -> Enable System -> Signal System (Bit, Bit, Value) -> Signal System Value
topEntity = exposeClockResetEnable bidirectionalShiftRegister



testbench :: Signal System Bool
testbench = done 
    where
        clk = tbSystemClockGen (not <$> done)
        rst = systemResetGen
        en = enableGen
        inputs = stimuliGenerator clk rst (
                    (1 :: Bit, 0 :: Bit, 0b11001010 :: BitVector 8) :> 
                    (0, 0, 0) :> (0, 0, 0) :> (0, 1, 0) :> (0, 1, 0) :> (0, 1, 0) :>
                    Nil
                )
        expectedOutputs = outputVerifier' clk rst (
                    (0b11001010 :: BitVector 8) :>
                    0b01100101 :> 0b00110010 :> 0b01100100 :> 0b11001000 :> 0b10010000 :> 
                    Nil
                )
        done = expectedOutputs (topEntity clk rst en inputs)


-- Mark testbench as top entity to generate Verilog testbench
{-# ANN testbench
  (Synthesize
    { t_name   = "testbench"
    , t_inputs = []
    , t_output = PortName "done"
    }) #-}

