module MatrixMultiplier.MatrixMultiplier where

import Clash.Prelude

type Value = Signed 16
type Matrix a b = Vec a (Vec b Value)


dotProduct :: KnownNat a => Vec a Value -> Vec a Value -> Value
dotProduct a b = foldl (\acc (x,y) -> acc + x * y) 0 (zip a b)

matMult :: forall a b c. (KnownNat a, KnownNat b, KnownNat c) 
    => Matrix a b -> Matrix b c -> Matrix a c
matMult a b = y
    where
        bt = transpose b
        y = map (\ar -> map (dotProduct ar) bt) a

topEntity :: Matrix 3 3 -> Matrix 3 3 -> Matrix 3 3
topEntity = matMult

-- test
-- let a = ((1 :> 2 :> 3 :> Nil) :> (4 :> 5 :> 6 :> Nil) :> (7 :> 8 :> 9 :> Nil) :> Nil) :: Matrix 3 3
-- topEntity a a 