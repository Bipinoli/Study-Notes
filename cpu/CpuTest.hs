module CpuTest where

import Clash.Prelude 
import Instruction (Instr(..), R, WordSize, Imm)
import Execute (Memory)

-- ---------------------- EXAMPLE PROGRAM (GCD) -----------------------
-- // function gcd(a, b)
-- //    while a != b
-- //      if a > b
-- //        a := a - b
-- //      else 
-- //        b := b - a
-- //    return a
-- //
-- // gcd(78, 143) = 13 


-- MVI R1, 78
-- MVI R2, 143

-- :loop
--   SUB R3, R1, R2
--   JEZ R3, end
  
--   GTR R3, R1, R2
--   JNZ R3, greater
  
--   SUB R2, R2, R1
--   JMP loop

--   :greater
--     SUB R1, R1, R2
--     JMP loop

-- :end 
--   HLT
--   // result in R1





--------- GCD program -------
r1 :: R
r1 = 0

r2 :: R
r2 = 1

r3 :: R
r3 = 2

labelEnd :: Imm
labelEnd = 10

labelLoop :: Imm
labelLoop = 2

labelGreater :: Imm
labelGreater = 8

gcdProgram :: [Instr]
gcdProgram = [
        MVI r1 78,
        MVI r2 143,

        -- :loop
        SUB r3 r1 r2,
        JEZ r3 labelEnd,

        GTR r3 r1 r2,
        JNZ r3 labelGreater,

        SUB r2 r2 r1,
        JMP labelLoop,

        -- :greater
        SUB r1 r1 r2,
        JMP labelLoop,

        -- :end
        HLT
    ]


