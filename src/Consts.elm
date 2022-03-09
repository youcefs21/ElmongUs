module Consts exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.EllieApp exposing (..)


type Msg =  Tick Float GetKeyState | 
            ClickButton (Int, Int) | 
            ClickWire Color


type alias Theme = {
    curve      : Color, 
    grid       : Color, 
    buttons    : Color,
    background : Color,
    movingLine : Color
  }