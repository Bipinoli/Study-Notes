module CpuTest where

import Text.Printf (printf)
import Clash.Prelude 
import qualified Clash.Sized.Vector as V
import Instruction (Instr(..), R, WordSize, Imm, encode)
import Execute (Memory, IP, Registers, State, RegSize)
import qualified Cpu 

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




-- ---------------------- EXAMPLE PROGRAM (Factorial) ----------------------- 
-- // function factorial(n):
-- //    count := n
-- //    ans := 1
-- //    while (count > 1) 
-- //      ans := ans * count
-- //      count := count - 1
-- //    return ans
-- //
-- // factorial(5) = 120


-- MVI R1, 1 // ans 
-- MVI R2, 5 // count 

-- MVI R3, 1
-- :loop
--   GTR R4, R2, R3
--   JEZ R4, end
  
--   MUL R1, R1, R2
--   SUB R2, R2, R3

--   JMP loop

-- :end
--   HLT
--   // answer in R1
-------------------------------------------------------------------------



assertEqual :: (String, RegSize, RegSize) -> IO ()
assertEqual (testname, expected, actual) =
    if expected == actual
    then putStrLn $ printf "\tTest passed: %s" testname
    else putStrLn $ printf "\t\tTest failed! %s \n\t\t\texpected: %s  \n\t\t\tactual: %s" testname (show expected) (show actual)


gcdTest :: (String, RegSize, RegSize) 
gcdTest = ("gcd(78, 143) = 13", expected, actual)
    where 
        expected = 13 :: RegSize
        actual = finalRegs !! 0 
        (finalRegs, _, finalIp) = result
        -- 100 cpu cycles should be more than enough for the program
        result = foldl (\state _ -> Cpu.cycle state) initialState (repeat 0 :: Vec 100 Bit)
        initialState = (repeat 0 :: Registers, memory, 0 :: IP) :: State
        memory = (encodedProgram ++ (repeat 0)) :: Memory
        encodedProgram = (map encode $ V.unsafeFromList gcdProgram) :: Vec 11 WordSize
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
            ] :: [Instr]
        r1 = 0 :: R
        r2 = 1 :: R
        r3 = 2 :: R
        labelEnd = 10 :: Imm
        labelLoop = 2 :: Imm
        labelGreater = 8 :: Imm





factorialTest :: (String, RegSize, RegSize) 
factorialTest = ("factorial(5) = 120", expected, actual)
    where 
        expected = 120 :: RegSize
        actual = finalRegs !! 0 
        (finalRegs, _, finalIp) = result
        -- 100 cpu cycles should be more than enough for the program
        result = foldl (\state _ -> Cpu.cycle state) initialState (repeat 0 :: Vec 100 Bit)
        initialState = (repeat 0 :: Registers, memory, 0 :: IP) :: State
        memory = (encodedProgram ++ (repeat 0)) :: Memory
        encodedProgram = (map encode $ V.unsafeFromList program) :: Vec 11 WordSize
        program = [
                MVI r1 1,
                MVI r2 5,

                MVI r3 1,
                -- :loop
                GTR r4 r2 r3,
                JEZ r4 labelEnd,

                MUL r1 r1 r2,
                SUB r2 r2 r3,

                JMP labelLoop,

                -- :end
                HLT
            ] :: [Instr]
        r1 = 0 :: R
        r2 = 1 :: R
        r3 = 2 :: R
        r4 = 3 :: R
        labelEnd = 8 :: Imm
        labelLoop = 3 :: Imm



main :: IO ()
main = do
    mapM_ assertEqual [gcdTest, factorialTest]
