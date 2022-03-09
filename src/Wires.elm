module Wires exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.EllieApp exposing (..)
import String
import Element.Font exposing (monospace)
import Set exposing (Set)
import String exposing (fromFloat)
import Consts exposing (..)
import Element.Font exposing (color)

myShapes : Model -> (List (Shape Consts.Msg))
myShapes model = 
    case model.state of
        Waiting -> 
            -- Starting point for the wires
            List.map2 (\y col -> 
                rect 4 4
                    |> filled col
                    |> move (-50, 6 * (toFloat y - 2))
                    |> notifyMouseDown (if List.member col model.finishedList 
                                    then (ClickWire (-50, 6 * (toFloat y - 2)) black)
                                    else (ClickWire (-50, 6 * (toFloat y - 2)) col))
                )
                (List.range 0 3)
                [myPink, myYellow, myBlue, myOrange]
            ++
            -- Endpoint for the wires
            List.map2 (\y col -> 
                rect 4 4
                    |> filled col
                    |> move (50, 6 * (toFloat y - 2))
                    |> notifyMouseUp (ConnectWires col)
                )
                (List.range 0 3)
                [myYellow, myBlue, myOrange, myPink]
            ++
            -- Wires
            List.map2 (\y col -> 
                line (-50, 6 * (toFloat y - 2)) (if List.member col model.finishedList 
                                    then 50
                                    else -50
                        , if List.member col model.finishedList 
                                    then 32 -- make this endpoint.y or something
                                    else 6 * (toFloat y - 2))
                    |> outlined (solid 3) col
                )
                (List.range 0 3)
                [myPink, myYellow, myBlue, myOrange]
            ++
            [
                text (String.fromInt (List.length model.finishedList))
                |> size 4
                |> centered
                |> filled model.grabbed
                |> move (0, 35)
            ]
        Grabbed (mouseX, mouseY) ->
            -- Tracks mouse movement and checks for mouse up when not touching anything
            [
                rect 190 126 |> ghost
                    --|> notifyMouseUp Stop -- If let go when not touching anything, go back to start.
                    --|> notifyLeave Stop
                    |> notifyMouseMoveAt MouseMoveTo
            ]
            ++
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
                    |> notifyMouseUp (ConnectWires col)
                )
                (List.range 0 3)
                [myYellow, myBlue, myOrange, myPink]
            ++
            -- Wires
            List.map2 (\y col -> 
                line (-50, 6 * (toFloat y - 2)) (if List.member col model.finishedList 
                                    then 50
                                    else if (model.grabbed == col)
                                        then mouseX
                                        else -50
                        , if List.member col model.finishedList 
                                    then 32 -- make this endpoint.y or something
                                    else if (model.grabbed == col)
                                        then mouseY
                                        else 6 * (toFloat y - 2))
                    |> outlined (solid 3) col
                )
                (List.range 0 3)
                [myPink, myYellow, myBlue, myOrange]
        Finished -> 
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
            ++
            -- Wires
            List.map2 (\y col -> 
                line (-50, 6 * (toFloat y - 2)) (50, 32)
                    |> outlined (solid 3) col
                )
                (List.range 0 3)
                [myPink, myYellow, myBlue, myOrange]

myPink : Color
myPink = (rgb 220 38 127)

myYellow : Color
myYellow = (rgb 255 176 0)

myBlue : Color
myBlue = (rgb 100 143 255)

myOrange : Color
myOrange = (rgb 254 97 0)

type State = Waiting | Grabbed (Float, Float) | Finished
type alias Model = {time : Float, state : State, grabbed : Color, finishedList : (List Color)}

update : Consts.Msg -> Model -> Model
update msg model = case msg of 
                    Tick t _ -> {time = t, state = model.state, grabbed = model.grabbed, finishedList = model.finishedList}
                    ClickWire (x, y) col -> {
                            time = model.time,
                            state = if col == black then model.state else Grabbed (x, y),
                            grabbed = col,
                            finishedList = model.finishedList
                        }
                    Stop -> case model.state of
                                Grabbed _ -> {time = model.time, state = Waiting, grabbed = black, finishedList = model.finishedList}
                                _ -> model
                    MouseMoveTo coords -> case model.state of
                                            Grabbed _ -> {model | state = Grabbed coords}
                                            _ -> model
                    ConnectWires col -> {
                                            time = model.time,
                                            state = Waiting,
                                            finishedList = if model.grabbed == col then col :: model.finishedList else model.finishedList,
                                            grabbed = black
                                        }
                    _ -> model

init : Model --                              black will work as the null color
init = {time = 0, state = Waiting, grabbed = black, finishedList = []}

main = gameApp Tick {model = init, view = view, update = update, title = "ElmongUs Wires" }

view : Model -> Collage Consts.Msg
view model = collage 192 128 (myShapes model)