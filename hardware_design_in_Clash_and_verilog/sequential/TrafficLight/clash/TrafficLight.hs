module TrafficLight.TrafficLight where

import Clash.Prelude
import Clash.Explicit.Testbench


data State = Red | Green | Yellow
type StateRep = Unsigned 2

state2Rep :: State -> StateRep
state2Rep Red = 1
state2Rep Green = 2
state2Rep Yellow = 3

rep2State :: StateRep -> State
rep2State 1 = Red
rep2State 2 = Green
rep2State 3 = Yellow
rep2State _ = error "Invalid State"

-- Moore machine
trafficFx :: StateRep -> StateRep
trafficFx state = case rep2State state of 
    Red -> state2Rep Green
    Green -> state2Rep Yellow
    Yellow -> state2Rep Red

mooreMachine :: (HiddenClockResetEnable dom, NFDataX s) => (s -> s) -> s -> Signal dom s
mooreMachine transitionFx initialState = currentState
    where 
        currentState = register initialState nextState
        nextState = transitionFx <$> currentState

traffic :: HiddenClockResetEnable dom => Signal dom StateRep 
traffic = mooreMachine trafficFx (state2Rep Red)

topEntity :: Clock System -> Reset System -> Enable System -> Signal System StateRep
topEntity = exposeClockResetEnable traffic


testbench :: Signal System Bool
testbench = done
    where
        clk = tbSystemClockGen (not <$> done)
        rst = systemResetGen
        en = enableGen
        expectedOutputs = outputVerifier' clk rst $ map state2Rep (Red :> Green :> Yellow :> Red :> Green :> Yellow :> Red :> Green :> Nil)
        done = expectedOutputs (topEntity clk rst en)


-- Mark testbench as top entity to generate Verilog testbench
{-# ANN testbench
  (Synthesize
    { t_name   = "testbench"
    , t_inputs = []
    , t_output = PortName "done"
    }) #-}
