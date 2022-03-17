module Consts exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)

type Msg = Tick Float GetKeyState
         | ToggleLeaf Bool
         | MouseDownAt (Float,Float) (Float,Float)
         | MouseMoveTo (Float,Float)
         | Stop (Float, Float)