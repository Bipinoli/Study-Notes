module FourBitCounter where

import Clash.Prelude
import GHC.TypeLits (KnownNat)


counter :: forall n . KnownNat n => Bit -> Unsigned n -> Unsigned n 
counter clear count = if bitToBool clear then 0 else count + 1

-- 4 bit counter
topEntity:: Clock System -> Bit -> Unsigned 4 -> Unsigned 4
topEntity = exposeClock counter
