module Main exposing (..)

import Html exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.EllieApp exposing (..)
import Imposter exposing (imposter)
import Swipe


myShapes model = [
        Swipe.draw
    ]

type Msg = Tick Float GetKeyState

type alias Model = { time : Float }

update msg model = 
    case msg of
        Tick t _ -> { time = t }

init = { time = 0 }

main = gameApp Tick { model = init, view = view, update = update, title = "Game Slot" }

view model = collage 192 128 (myShapes model)



