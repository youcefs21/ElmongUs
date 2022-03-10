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
                    |> filled col -- Col is passed by the map
                    |> move (-50, 6 * (toFloat y - 2)) -- y is like i in a for loop, so this just translates it to the right place
                    |> notifyMouseDown (if List.member col model.finishedList -- If mouse pressed, tell app that mouse was pressed.
                                    then (ClickWire (-50, 6 * (toFloat y - 2)) black)
                                    else (ClickWire (-50, 6 * (toFloat y - 2)) col)) -- If this wire is already in place, tell the app that by sending it the color black
                )
                (List.range 0 3)
                [myPink, myYellow, myBlue, myOrange]
            ++
            -- Endpoint for the wires, works similar to the starting point, but without the notifyTap event
            List.map2 (\y col -> 
                rect 4 4
                    |> filled col
                    |> move (50, 6 * (toFloat y - 2))
                )
                (List.map scrambledColors (List.range 0 3)) -- Scramble the y-coordinates by the preset function
                [myPink, myYellow, myBlue, myOrange]
            ++
            -- Wires
            List.map2 (\y col -> 
                line (-50, 6 * (toFloat y - 2)) (if List.member col model.finishedList 
                                    then 50 -- If connected, put on right side
                                    else -50 -- If not connected, put on left side
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
                (List.map scrambledColors (List.range 0 3))
                [myPink, myYellow, myBlue, myOrange]
            ++
            -- Wires
            List.map2 (\y col -> 
                line (-50, 6 * (toFloat y - 2)) (if List.member col model.finishedList 
                                    then 50 -- If connected, put on right side
                                    else if (model.grabbed == col)
                                        then mouseX -- If this is the one you're holding, move to mouse position
                                        else -50 -- If not already connected and not holding, keep at start
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
                (List.map scrambledColors (List.range 0 3))
                [myPink, myYellow, myBlue, myOrange]
            ++
            -- Wires
            List.map2 (\y col -> 
                line (-50, 6 * (toFloat y - 2)) (50, 6 * (toFloat (scrambledColors y) - 2))
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
snap (x, y) = if (distance (x, y) (50, 6 * (0 - 2)) < 3) then intToCol (unscrambledColors 0)
                else if (distance (x, y) (50, 6 * (1 - 2)) < 3) then intToCol (unscrambledColors 1)
                    else if (distance (x, y) (50, 6 * (2 - 2)) < 3) then intToCol (unscrambledColors 2)
                        else if (distance (x, y) (50, 6 * (3 - 2)) < 3) then intToCol (unscrambledColors 3)
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