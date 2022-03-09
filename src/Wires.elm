module Wires exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.EllieApp exposing (..)
import String
import Element.Font exposing (monospace)
import Set exposing (Set)
import String exposing (fromFloat)
import Consts exposing (..)
import Element.Font exposing (color)

myShapes model = 
    case model.state of
        Waiting -> 
            -- Starting point for the wires
            List.map2 (\y col -> 
                rect 4 4
                    |> filled col
                    |> move (-50, 6 * (toFloat y - 2))
                )
                (List.range 0 3)
                [myPink, myYellow, myBlue, myOrange]
            ++
            -- Endpoint for the wires
            List.map2 (\y col -> 
                rect 4 4
                    |> filled col
                    |> move (50, 6 * (toFloat y - 2))
                )
                (List.range 0 3)
                [myYellow, myBlue, myOrange, myPink]
        Grabbed delta mouseAt ->
            -- Starting point for the wires
            List.map2 (\y col -> 
                rect 4 4
                    |> filled col
                    |> move (-50, 6 * (toFloat y - 2))
                )
                (List.range 0 3)
                [myPink, myYellow, myBlue, myOrange]
            ++
            -- Endpoint for the wires
            List.map2 (\y col -> 
                rect 4 4
                    |> filled col
                    |> move (50, 6 * (toFloat y - 2))
                )
                (List.range 0 3)
                [myYellow, myBlue, myOrange, myPink]

myPink : Color
myPink = (rgb 220 38 127)

myYellow : Color
myYellow = (rgb 255 176 0)

myBlue : Color
myBlue = (rgb 100 143 255)

myOrange : Color
myOrange = (rgb 254 97 0)

type State = Waiting | Grabbed
                        (Float, Float) -- Offset from down position to draw position
                        (Float, Float) -- current mouse position
type alias Model = {time : Float,state : State}

update : Consts.Msg -> Model -> Model
update msg model = case msg of 
                    Tick t _ -> {time = t, state = model.state}
                    _ -> {time = model.time, state = model.state}

init : Model
init = {time = 0, state = Waiting}

main = gameApp Tick {model = init, view = view, update = update, title = "ElmongUs Wires" }

view model = collage 192 128 (myShapes model)