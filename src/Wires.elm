module Wires exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import Consts exposing (..)

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
        Waiting -> -- If nothing happening:
            -- Starting point for the wires
            List.map2 (\y col -> 
                rect 4 4
                    |> filled col -- Col is passed by the map
                    |> move (-40, 6 * (toFloat y - 2)) -- y is like i in a for loop, so this just translates it to the right place
                    |> notifyMouseDown (if List.member col model.finishedList -- If wire was already in place, 
                                    then (ClickWire (-40, 6 * (toFloat y - 2)) black) -- tell the app that by sending it the color black
                                    else (ClickWire (-40, 6 * (toFloat y - 2)) col)) -- otherwise send the app the colour of the wire
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
                        , if List.member col model.finishedList  -- same idea for y-coordinates, except run through scrambledColours to move it to the right wire end.
                                    then 6 * (toFloat (scrambledColors y) - 2)
                                    else 6 * (toFloat y - 2))
                    |> outlined (solid 2.5) black -- This is the black outline of the wires themselves.
                )
                (List.range 0 3)
                [myPink, myYellow, myBlue, myOrange]
            ++
            List.map2 (\y col -> 
                line (-40, 6 * (toFloat y - 2)) (if List.member col model.finishedList 
                                    then 40 -- If connected, put on right side
                                    else -40 -- If not connected, put on left side
                        , if List.member col model.finishedList  -- same idea for y-coordinates, except run through scrambledColours to move it to the right wire end.
                                    then 6 * (toFloat (scrambledColors y) - 2)
                                    else 6 * (toFloat y - 2))
                    |> outlined (solid 2) col
                )
                (List.range 0 3)
                [myPink, myYellow, myBlue, myOrange]
        Grabbed (mouseX, mouseY) -> -- If user is dragging a wire with the mouse
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
                line (-40, 6 * (toFloat y - 2)) (if List.member col model.finishedList -- If already connected,
                                    then 40 --  put on right side
                                    else if (model.grabbed == col) -- If the colour the model has stored for the user to be grabbing is the same as the colour of this wire, then move the wire with the mouse.
                                        then mouseX -- If this is the one you're holding, move to mouse position
                                        else -40 -- If not already connected and not holding, keep at start
                        , if List.member col model.finishedList -- Same idea for the y-coordinate
                                    then 6 * (toFloat (scrambledColors y) - 2) -- This is the y-coordinate of the endpoint
                                    else if (model.grabbed == col)
                                        then mouseY
                                        else 6 * (toFloat y - 2))
                    |> outlined (solid 2.5) black
                )
                (List.range 0 3)
                [myPink, myYellow, myBlue, myOrange]
            ++
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
                    |> outlined (solid 2) col
                )
                (List.range 0 3)
                [myPink, myYellow, myBlue, myOrange]
            ++
            -- Tracks mouse movement and checks for mouse up
            [
                rect 190 126 |> ghost -- You can't see it, it's just there to track mouse
                    |> notifyMouseUpAt ConnectWires
                    |> notifyLeave StopWire
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
            List.map2 (\y _ -> 
                line (-40, 6 * (toFloat y - 2)) (40, 6 * (toFloat (scrambledColors y) - 2))
                    |> outlined (solid 2.5) black
                )
                (List.range 0 3)
                [myPink, myYellow, myBlue, myOrange]
            ++
            List.map2 (\y col -> 
                line (-40, 6 * (toFloat y - 2)) (40, 6 * (toFloat (scrambledColors y) - 2))
                    |> outlined (solid 2) col
                )
                (List.range 0 3)
                [myPink, myYellow, myBlue, myOrange]
            ++ [if (model.time - model.endTime) > 1 then 
                    square 1000 |> ghost |> notifyEnter (ToggleWire False)
                else
                    text "Task completed!" |> centered |> filled black]

myPink : Color
myPink = (rgb 220 38 127)

myYellow : Color
myYellow = (rgb 255 176 0)

myBlue : Color
myBlue = (rgb 100 143 255)

myOrange : Color
myOrange = (rgb 254 97 0)

-- Takes the number of the starting point and returns the number of its associated endpoint
scrambledColors num = case num of
    0 -> 3
    1 -> 0
    2 -> 1
    3 -> 2
    _ -> -1

-- Takes the number of an endpoint and returns the number of its associated starting point
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

-- Simple helper function for distance
distance (x1, y1) (x2, y2) = 
    sqrt ((x2 - x1)^2 + (y2 - y1)^2)

snap : (Float, Float) -> Color -- Check each wire number, and see if the distance from the endpoint associated with it to the mouse's coordinates is small enough, and if so returns the colour of the wire.
snap (x, y) = if (distance (x, y) (40, 6 * (0 - 2)) < 3) then intToCol (unscrambledColors 0)
                else if (distance (x, y) (40, 6 * (1 - 2)) < 3) then intToCol (unscrambledColors 1)
                    else if (distance (x, y) (40, 6 * (2 - 2)) < 3) then intToCol (unscrambledColors 2)
                        else if (distance (x, y) (40, 6 * (3 - 2)) < 3) then intToCol (unscrambledColors 3)
                            else black -- If none of the endpoints were close enough to the mouse when it was released, return black as the null colour.

type State = Waiting | Grabbed (Float, Float) | Finished
type alias Model = {time : Float, state : State, grabbed : Color, finishedList : (List Color), endTime : Float}

update : Consts.Msg -> Model -> Model
update msg model = case msg of 
                    -- Literally nothing happens in the Tick event.
                    Tick t _ -> {model | time = t, state = model.state, grabbed = model.grabbed, finishedList = model.finishedList}
                    ClickWire (x, y) col -> { model |
                            state = if col == black -- If colour is the null colour, false alarm
                                then model.state 
                                else Grabbed (x, y), -- Else change the state to grabbed and move that wire.
                            grabbed = col -- Set grabbed to whatever colour was clicked on
                        }
                    StopWire -> case model.state of
                                -- Reset values, since this is only called if the mouse leaves the app
                                Grabbed _ -> {model | state = Waiting, grabbed = black}
                                _ -> model
                    MouseMoveTo coords -> case model.state of
                                            Grabbed _ -> {model | state = Grabbed coords} -- Update the mouse's coordinates for moving the wires.
                                            _ -> model
                    ConnectWires (x, y) -> { model | 
                            finishedList = if (snap (x, y) == model.grabbed) -- If you released the wire on the right endpoint,
                                                then (snap (x, y)) :: model.finishedList -- Add that wire's colour to the list of completed colours.
                                                else model.finishedList, -- Else leave it the same.
                            grabbed = black,
                            state = (
                                    if (List.length model.finishedList >= 3) && -- If there's just one wire left,
                                    (snap (x, y) == model.grabbed)              -- And you just did that wire,
                                        then Finished                           -- You're done!
                                        else Waiting                            -- You're not done!
                                ),
                            endTime = if (List.length model.finishedList >= 3) && (snap (x, y) == model.grabbed) then model.time else model.endTime
                            -- Use endTime to time the "Task Completed" text
                        }
                    _ -> model

init : Model --                              black will work as the null color
init = {time = 0, state = Waiting, grabbed = black, finishedList = [], endTime = 0}

main = gameApp Tick {model = init, view = view, update = update, title = "ElmongUs Wires" }

view : Model -> Collage Consts.Msg
view model = collage 192 128 (myShapes model)