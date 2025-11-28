module ExecuteTest where

import Clash.Prelude 
import Text.Printf (printf)
import Instruction (Instr(..))
import Execute (Registers, Memory, IP, State, execute)


assertEqual :: (String, State, State) -> IO ()
assertEqual (testname, expected, actual) =
    if expected == actual
    then putStrLn $ printf "\tTest passed: %s" testname
    else putStrLn $ printf "\t\tTest failed! %s \n\t\t\texpected: %s  \n\t\t\tactual: %s" testname (prettyState expected) (prettyState actual)

prettyState :: State -> String
prettyState (regs, memory, ip) = 
    printf "(%s, memory[124] = %s, %d)" (show (take (SNat :: SNat 3) regs)) (show (memory !! 124)) ip

dummyState :: State
dummyState = (regs, memory, ip)
    where 
        regs = (10 :> 20 :> 30 :> Nil) ++ (repeat 0 :: Vec 13 (Signed 32))
        memory = repeat 0 :: Memory
        ip = 0 :: IP


movTest :: (String, State, State)
movTest = ("MOV R1 R2", expected, actual) 
    where 
        instr = MOV 0 1
        (regs, memory, ip) = dummyState
        expectedRegs = (20 :> 20 :> 30 :> Nil) ++ (repeat 0 :: Vec 13 (Signed 32))
        expected = (expectedRegs, memory, ip+1)
        actual = execute dummyState instr

mviTest :: (String, State, State)
mviTest = ("MVI R1 123", expected, actual) 
    where 
        instr = MVI 0 123
        (regs, memory, ip) = dummyState
        expectedRegs = (123 :> 20 :> 30 :> Nil) ++ (repeat 0 :: Vec 13 (Signed 32))
        expected = (expectedRegs, memory, ip+1)
        actual = execute dummyState instr

lodTest :: (String, State, State)
lodTest = ("LOD R1 R2 123", expected, actual) 
    where 
        instr = LOD 0 1 123
        (regs, memory, ip) = dummyState
        regs' = replace 1 1 regs
        memory' = replace 124 100 memory
        expectedRegs = (100 :> 1 :> 30 :> Nil) ++ (repeat 0 :: Vec 13 (Signed 32))
        expected = (expectedRegs, memory', ip+1)
        actual = execute (regs', memory', ip) instr

strTest :: (String, State, State)
strTest = ("STR R1 R2 -2", expected, actual) 
    where 
        instr = STR 0 1 (-2)
        (regs, memory, ip) = dummyState
        regs' = replace 1 126 regs
        expectedMem = replace 124 10 memory
        expected = (regs', expectedMem, ip+1)
        actual = execute (regs', memory, ip) instr

subTest :: (String, State, State)
subTest = ("SUB R1 R2 R3", expected, actual) 
    where 
        instr = SUB 0 1 2
        (regs, memory, ip) = dummyState
        expectedRegs = (-10 :> 20 :> 30 :> Nil) ++ (repeat 0 :: Vec 13 (Signed 32))
        expected = (expectedRegs, memory, ip+1)
        actual = execute dummyState instr

jezTest :: (String, State, State)
jezTest = ("JEZ R1 label", expected, actual) 
    where 
        instr = JEZ 10 100
        (regs, memory, ip) = dummyState
        expected = (regs, memory, 100)
        actual = execute dummyState instr

gtrTest :: (String, State, State)
gtrTest = ("GTR R1 R2 R3", expected, actual) 
    where 
        instr = GTR 0 1 2
        (regs, memory, ip) = dummyState
        expectedRegs = (0 :> 20 :> 30 :> Nil) ++ (repeat 0 :: Vec 13 (Signed 32))
        expected = (expectedRegs, memory, ip+1)
        actual = execute dummyState instr

jnzTest :: (String, State, State)
jnzTest = ("JNZ R1 label", expected, actual) 
    where 
        instr = JNZ 0 100
        (regs, memory, ip) = dummyState
        expected = (regs, memory, 100)
        actual = execute dummyState instr

jmpTest :: (String, State, State)
jmpTest = ("JMP label", expected, actual) 
    where 
        instr = JMP 123
        (regs, memory, ip) = dummyState
        expected = (regs, memory, 123)
        actual = execute dummyState instr


main :: IO ()
main = do
    mapM_ assertEqual [movTest, mviTest, lodTest, strTest, subTest, jezTest, gtrTest, jnzTest, jmpTest]