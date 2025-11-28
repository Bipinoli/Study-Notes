module SimpleLatch where

import Clash.Prelude
import Clash.Explicit.Testbench

b :: HiddenClockResetEnable dom => Signal dom (Signed 32) -> Signal dom (Signed 32)
b a = register 0 a
 
topEntity :: Clock System -> Reset System -> Enable System -> Signal System (Signed 32) -> Signal System (Signed 32)
topEntity = exposeClockResetEnable b