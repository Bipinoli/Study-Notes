module FourBitCounter where

import Clash.Prelude
import Clash.Explicit.Testbench


--
-- counter :: forall n . KnownNat n => Bit -> Unsigned n -> Unsigned n 
-- counter clear count = if bitToBool clear then 0 else count + 1
--
-- -- 4 bit counter
-- topEntity:: Clock System -> Bit -> Unsigned 4 -> Unsigned 4
-- topEntity = exposeClock counter
--

counter :: HiddenClockResetEnable dom => Signal dom (Unsigned 4)
counter = register 0 (counter + 1)

-- topEntity :: HiddenClockResetEnable dom => Signal dom (Unsigned 4)
-- topEntity = counter

topEntity :: Clock System -> Reset System -> Enable System -> Signal System (Unsigned 4)
topEntity = exposeClockResetEnable counter

testbench :: Signal System Bool
testbench = done
  where 
    clk = tbSystemClockGen (not <$> done)
    rst = systemResetGen
    en = enableGen
    expectedOutput = outputVerifier' clk rst ((0 :> 1 :> 2 :> 3 :> 4 :> 5 :> 6 :> 7 :> 8 :> 9 :> 10 :> 11 :> 12 :> 13 :> 14 :> 15 :> 0 :> Nil) :: Vec 17 (Unsigned 4))
    done = expectedOutput (topEntity clk rst en)

-- Mark testbench as top entity to generate Verilog
{-# ANN testbench
  (Synthesize
    { t_name   = "testbench"
    , t_inputs = []
    , t_output = PortName "done"
    }) #-}
