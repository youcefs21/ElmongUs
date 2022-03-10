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
myShapes model = [rectangle 90 10
                  |> filled (rgb 191 194 199) |> move (0, 31.5)|> addOutline (solid 0.3) black,
                  rectangle 90 10
                  |> filled (rgb 191 194 199) |> move (0, -37.5)|> addOutline (solid 0.3) black,
                  rectangle 10 15 
                  |> filled (rgb 191 194 199) |> move (-40, 19)|> addOutline (solid 0.3) black,
                  rectangle 10 30 
                  |> filled (rgb 191 194 199) |> move (-40, -3)|> addOutline (solid 0.3) black,
                  rectangle 10 15
                  |> filled (rgb 191 194 199) |> move (-40, -25)|> addOutline (solid 0.3) black,
                  rectangle 10 15 
                  |> filled (rgb 191 194 199) |> move (40, 19)|> addOutline (solid 0.3) black,
                  rectangle 10 30 
                  |> filled (rgb 191 194 199) |> move (40, -3)|> addOutline (solid 0.3) black,
                  rectangle 10 15
                  |> filled (rgb 191 194 199) |> move (40, -25)|> addOutline (solid 0.3) black,
                  rectangle 69.75 59
                  |> filled (rgb 95 99 105) |> makeTransparent 0.8|> move (0, -3) |> addOutline (solid 0.3) black,
                  rectangle 2 30
                  |> filled (rgb 220 38 127) |> makeTransparent 0.8 |> move (-8, 11.5) |> addOutline (solid 0.3) black,
                  rectangle 2 32
                  |> filled (rgb 255 176 0) |> makeTransparent 0.8 |> move (-10, 10.5) |> addOutline (solid 0.3) black,
                  rectangle 2 34
                  |> filled (rgb 100 143 255) |> makeTransparent 0.8 |> move (-12, 9.5) |> addOutline (solid 0.3) black,
                  rectangle 2 36
                  |> filled (rgb 254 97 0) |> makeTransparent 0.8 |> move (-14, 8.5) |> addOutline (solid 0.3) black,
                  -- horizontal
                  rectangle 20 2
                  |> filled (rgb 220 38 127) |> makeTransparent 0.8 |> move (1, -4.5) |> addOutline (solid 0.3) black,
                  rectangle 20 2
                  |> filled (rgb 255 176 0) |> makeTransparent 0.8 |> move (-1, -6.5) |> addOutline (solid 0.3) black,
                  rectangle 20 2
                  |> filled (rgb 100 143 255) |> makeTransparent 0.8 |> move (-3, -8.5) |> addOutline (solid 0.3) black,
                  rectangle 20 2
                  |> filled (rgb 254 97 0) |> makeTransparent 0.8 |> move (-5, -10.5) |> addOutline (solid 0.3) black,
                  -- vertical 2
                  rectangle 2 29
                  |> filled (rgb 220 38 127) |> makeTransparent 0.8 |> move (12, -18) |> addOutline (solid 0.3) black,
                  rectangle 2 27
                  |> filled (rgb 255 176 0) |> makeTransparent 0.8 |> move (10, -19) |> addOutline (solid 0.3) black,
                  rectangle 2 25
                  |> filled (rgb 100 143 255) |> makeTransparent 0.8 |> move (8, -20) |> addOutline (solid 0.3) black,
                  rectangle 2 23
                  |> filled (rgb 254 97 0) |> makeTransparent 0.8 |> move (6, -21) |> addOutline (solid 0.3) black] ++
    case model.state of
        Waiting -> 
            -- Starting point for the wires
            List.map2 (\y col -> 
                rect 4 4
                    |> filled col -- Col is passed by the map
                    |> move (-40, 6 * (toFloat y - 2)) -- y is like i in a for loop, so this just translates it to the right place
                    |> notifyMouseDown (if List.member col model.finishedList -- If mouse pressed, tell app that mouse was pressed.
                                    then (ClickWire (-40, 6 * (toFloat y - 2)) black)
                                    else (ClickWire (-40, 6 * (toFloat y - 2)) col)) -- If this wire is already in place, tell the app that by sending it the color black
                    |> addOutline (solid 0.25) black
                )
                (List.range 0 3)
                [myPink, myYellow, myBlue, myOrange]
            ++
            -- Endpoint for the wires, works similar to the starting point, but without the notifyTap event
            List.map2 (\y col -> 
                rect 4 4
                    |> filled col
                    |> move (40, 6 * (toFloat y - 2))
                    |> addOutline (solid 0.25) black
                )
                (List.map scrambledColors (List.range 0 3)) -- Scramble the y-coordinates by the preset function
                [myPink, myYellow, myBlue, myOrange]
            ++
            -- Wires
            List.map2 (\y col -> 
                line (-40, 6 * (toFloat y - 2)) (if List.member col model.finishedList 
                                    then 40 -- If connected, put on right side
                                    else -40 -- If not connected, put on left side
                        , if List.member col model.finishedList  -- same idea for y-coordinates
                                    then 6 * (toFloat (scrambledColors y) - 2)
                                    else 6 * (toFloat y - 2))
                    |> outlined (solid 3) col
                )
                (List.range 0 3)
                [myPink, myYellow, myBlue, myOrange]
        Grabbed (mouseX, mouseY) ->
            -- Starting point for the wires
            List.map2 (\y col -> 
                rect 4 4
                    |> filled col
                    |> move (-40, 6 * (toFloat y - 2))
                    |> addOutline (solid 0.25) black
                )
                (List.range 0 3)
                [myPink, myYellow, myBlue, myOrange]
            ++
            -- Endpoint for the wires
            List.map2 (\y col -> 
                rect 4 4
                    |> filled col
                    |> move (40, 6 * (toFloat y - 2))
                    |> addOutline (solid 0.25) black
                )
                (List.map scrambledColors (List.range 0 3))
                [myPink, myYellow, myBlue, myOrange]
            ++
            -- Wires
            List.map2 (\y col -> 
                line (-40, 6 * (toFloat y - 2)) (if List.member col model.finishedList 
                                    then 40 -- If connected, put on right side
                                    else if (model.grabbed == col)
                                        then mouseX -- If this is the one you're holding, move to mouse position
                                        else -40 -- If not already connected and not holding, keep at start
                        , if List.member col model.finishedList -- Same idea for the y-coordinate
                                    then 6 * (toFloat (scrambledColors y) - 2) -- This is the y-coordinate of the endpoint
                                    else if (model.grabbed == col)
                                        then mouseY
                                        else 6 * (toFloat y - 2))
                    |> outlined (solid 3) col
                )
                (List.range 0 3)
                [myPink, myYellow, myBlue, myOrange]
            ++
            -- Tracks mouse movement and checks for mouse up
            [
                rect 190 126 |> ghost -- You can't see it, it's just there to track moues
                    |> notifyMouseUpAt ConnectWires
                    |> notifyLeave Stop
                    |> notifyMouseMoveAt MouseMoveTo
            ]
        Finished -> 
            -- Starting point for the wires
            List.map2 (\y col -> 
                rect 4 4
                    |> filled col
                    |> move (-40, 6 * (toFloat y - 2))
                    |> addOutline (solid 0.3) black
                )
                (List.range 0 3)
                [myPink, myYellow, myBlue, myOrange]
            ++
            -- Endpoint for the wires
            List.map2 (\y col -> 
                rect 4 4
                    |> filled col
                    |> move (40, 6 * (toFloat y - 2))
                    |> addOutline (solid 0.3) black
                )
                (List.map scrambledColors (List.range 0 3))
                [myPink, myYellow, myBlue, myOrange]
            ++
            -- Wires
            List.map2 (\y col -> 
                line (-40, 6 * (toFloat y - 2)) (40, 6 * (toFloat (scrambledColors y) - 2))
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

-- Takes the order of the end point and returns a new scrambled number.
scrambledColors num = case num of
    0 -> 3
    1 -> 0
    2 -> 1
    3 -> 2
    _ -> -1

unscrambledColors num = case num of
    3 -> 0
    0 -> 1
    1 -> 2
    2 -> 3
    _ -> -1

-- Takes the number of wire and returns the color associated with that wire
intToCol : Int -> Color
intToCol num = case num of
    0 -> myPink
    1 -> myYellow
    2 -> myBlue
    3 -> myOrange
    _ -> black

distance (x1, y1) (x2, y2) = 
    sqrt ((x2 - x1)^2 + (y2 - y1)^2)

snap : (Float, Float) -> Color
snap (x, y) = if (distance (x, y) (40, 6 * (0 - 2)) < 3) then intToCol (unscrambledColors 0)
                else if (distance (x, y) (40, 6 * (1 - 2)) < 3) then intToCol (unscrambledColors 1)
                    else if (distance (x, y) (40, 6 * (2 - 2)) < 3) then intToCol (unscrambledColors 2)
                        else if (distance (x, y) (40, 6 * (3 - 2)) < 3) then intToCol (unscrambledColors 3)
                            else black

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
                    ConnectWires (x, y) -> {
                                            time = model.time,
                                            finishedList = if (snap (x, y) == model.grabbed) then (snap (x, y)) :: model.finishedList else model.finishedList,--if model.grabbed == col then col :: model.finishedList else model.finishedList,
                                            grabbed = black,
                                            state = if (List.length model.finishedList >= 3) && (snap (x, y) == model.grabbed)  then Finished else Waiting
                                        }
                    _ -> model

init : Model --                              black will work as the null color
init = {time = 0, state = Waiting, grabbed = black, finishedList = []}

main = gameApp Tick {model = init, view = view, update = update, title = "ElmongUs Wires" }

view : Model -> Collage Consts.Msg
view model = collage 192 128 (myShapes model)