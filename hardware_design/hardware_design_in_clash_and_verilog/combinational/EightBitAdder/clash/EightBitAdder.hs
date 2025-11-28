module EightBitAdder where

import Clash.Prelude
import GHC.TypeLits (KnownNat)

--  Truth table (full adder)
--  -----------
--   A  B  C  Y  C1
--   0  0  0  0  0
--   0  0  1  1  0
--   0  1  0  1  0
--   0  1  1  0  1
--   1  0  0  1  0
--   1  0  1  0  1
--   1  1  0  0  1
--   1  1  1  1  1
--
fullAdder :: Bit -> Bit -> Bit -> (Bit, Bit)
fullAdder a b c = (y, c1)
  where y = (a .|. b .|. c) .&. (a `xor` b `xor` c)
        c1 = (a .&. b) .|. (b .&. c) .|. (c .&. a)


-- forall n . makes the function generic over any natural number n.
-- KnownNat n ensures n is a compile-time known natural number, so the function can safely work with vectors of size n.

-- rippleCarryAdder :: forall n . KnownNat n => Vec n Bit -> Vec n Bit -> Bit -> (Vec n Bit, Bit)
-- rippleCarryAdder ass bss cins = go (reverse ass) (reverse bss) cins
--   where
--     go :: forall n . KnownNat n => Vec n Bit -> Vec n Bit -> Bit -> (Vec n Bit, Bit)
--     go Nil Nil cin = (Nil, cin)
--     go (Cons a as) (Cons b bs) cin =
--       let
--         (y, cout) = fullAdder a b cin
--         (ys, cfinal) = go as bs cout
--       in
--         (ys :< y, cfinal)


rippleCarryAdder :: forall n . KnownNat n => Vec n Bit -> Vec n Bit -> Bit -> (Bit, Vec n Bit)
rippleCarryAdder as bs cin = 
  mapAccumR (\acc (a, b) -> let (y, cout) = fullAdder a b acc in (cout, y)) cin (zip as bs)


-- test: 234 + 212 + (carry = 0)
-- let a = (1 :> 1 :> 1 :> 0 :> 1 :> 0 :> 1 :> 0 :> Nil) :: Vec 8 Bit -- 234
-- let b = (1 :> 1 :> 0 :> 1 :> 0 :> 1 :> 0 :> 0 :> Nil) :: Vec 8 Bit -- 212


-- 8 bit rippple carry adder
topEntity:: Vec 8 Bit -> Vec 8 Bit -> Bit -> (Bit, Vec 8 Bit)
topEntity  = rippleCarryAdder

