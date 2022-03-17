module Consts exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)

type Msg = Tick Float GetKeyState
         | ToggleLeaf Bool
         | ToggleWire Bool
         | ToggleSwipe Bool
         | TogglePass Bool
         | MouseDownAt (Float,Float) (Float,Float)
         | MouseMoveTo (Float,Float)
         | Stop (Float, Float)
         | ClickButton (Int, Int) 
         | ClickWire (Float, Float) Color 
         | StopWire 
         | ConnectWires (Float, Float)
         | MoveTop
         | Move (Float, Float)
         | ToggleMove Bool (Float, Float)
         | Finish