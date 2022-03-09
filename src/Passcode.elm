module Passcode exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.EllieApp exposing (..)
import String
import Element.Font exposing (monospace)
import Set exposing (Set)
import String exposing (fromFloat)
import Consts exposing (..)

myShapes model = [rectangle 49 53
 |> filled (rgb 165 165 165) |> move (-20, 3)
 |> addOutline (solid 0.5) black, 
 rectangle 49 53
 |> filled (rgb 165 165 165) |> move (31, 3)
 |> addOutline (solid 0.5) black,
 -- Left screen
 polygon [(-20,2),(20,2),(24,-2),(-24,-2)]
  |> filled (rgb 99 101 98) |> rotate (degrees 90) |> move (2, 3),
  polygon [(-20,2),(20,2),(24,-2),(-24,-2)]
  |> filled (rgb 99 101 98) |> rotate (degrees 270) |> move (-42, 3),
  polygon [(-20,2),(20,2),(24,-2),(-24,-2)]
  |> filled (rgb 99 101 98) |> rotate (degrees 360) |> move (-20, -21),
  polygon [(-20,2),(20,2),(24,-2),(-24,-2)]
  |> filled (rgb 204 204 204) |> rotate (degrees 180) |> move (-20, 27),
-- Right screen
  polygon [(-20,2),(20,2),(24,-2),(-24,-2)]
  |> filled (rgb 99 101 98) |> rotate (degrees 90) |> move (53, 3),
  polygon [(-20,2),(20,2),(24,-2),(-24,-2)]
  |> filled (rgb 99 101 98) |> rotate (degrees 270) |> move (9, 3),
  polygon [(-20,2),(20,2),(24,-2),(-24,-2)]
  |> filled (rgb 99 101 98) |> rotate (degrees 360) |> move (31, -21),
  polygon [(-20,2),(20,2),(24,-2),(-24,-2)]
  |> filled (rgb 204 204 204) |> rotate (degrees 180) |> move (31, 27)] ++
    -- This map2 function produces the buttons
    List.map2 (\x y ->
        button (x, y) model -- See function definition for a button below
            |> move (31, 0)
            
        )
        [0, 0, 0, 1, 1, 1, 2, 2, 2] -- x-coordinates
        [0, 1, 2, 0, 1, 2, 0, 1, 2] -- y-coordinates
    ++
    -- This map2 function produces the screen that shows the corrrect sequence of presses
    List.map2 (\x y ->
        square 11        -- ( If showing correct button sequence, this is the current correct button, and the timing is right )
                |> filled (if ((model.state == Showing) && (sequence model.passNum == (x, y)) && (model.showTime < 15)) then lightBlue else black)
                |> move (11 * (toFloat x - 1) - 20, 11 * (toFloat y - 1))
    )
    [0, 0, 0, 1, 1, 1, 2, 2, 2] -- x-coordinates
    [0, 1, 2, 0, 1, 2, 0, 1, 2] -- y-coordinates
    ++
    -- This map function produces the circles above the screen on the left
    List.map (\x -> 
                circle 2 -- Turn the first few green based on how far the user is, make the rest green
                    |> filled (if x <= model.repNum then (rgb 0 190 1) else darkGrey)
                    |> addOutline (solid 0.3) black
                    |> move (7 * (toFloat x - 3) - 20, 20)
        )
        (List.range 1 5)
    ++
    -- This map function produces the circles above the buttons on the right
    List.map (\x -> 
                circle 2
                    |> filled (case model.state of
                                Incorrect -> red -- Turn red if incorrect, turn some green if entering right ones, else turn darkGrey
                                Waiting -> if x <= model.passNum then (rgb 0 190 1) else darkGrey
                                _ -> darkGrey
                                )
                    |> addOutline (solid 0.3) black
                    |> move (7 * (toFloat x - 3) + 31, 20)
        )
        (List.range 1 5)
    
button (x, y) model = group [
        square 10
        -- Change colour based on model.state and some other factors
        |> filled (case model.state of
                Showing -> darkGrey
                Waiting -> grey
                Finished -> if model.showTime < 2 * blinkTime then lightBlue else darkGrey
                Incorrect -> red
            )
        |> addOutline (solid 0.3) black
        -- 11 is the distance from the center of each button
        |> move (11 * (toFloat x - 1), 11 * (toFloat y - 1))
        |> notifyTap (ClickButton (x, y))
    ]

-- Sequence of correct presses.  Works like indexing a list.
sequence i = case i of 
            0 -> (0, 0)
            1 -> (1, 1)
            2 -> (2, 1)
            3 -> (0, 2)
            4 -> (2, 0)
            _ -> (-1, -1)

blinkTime = 20

type State = Waiting | Showing | Incorrect | Finished
type alias Model = {time : Float, passNum : Int, repNum : Int, showTime : Int, state : State}

update : Consts.Msg -> Model -> Model
update msg model = case msg of 
                    Tick t _ -> 
                        case model.state of
                            Showing -> {
                                        time = t,
                                        state = if (model.showTime <= 0 && model.passNum >= model.repNum - 1)
                                                    then Waiting
                                                    else model.state,
                                        repNum = model.repNum, -- repNum is only increased after getting the entire sequence up to repNum right
                                        passNum = if (model.showTime <= 0)
                                                    then (if model.passNum >= model.repNum - 1 
                                                            then 0 
                                                            else model.passNum + 1)
                                                    else model.passNum, 
                                        showTime = if model.showTime <= 0 
                                                    then blinkTime
                                                    else model.showTime - 1
                                    }
                            Waiting -> {
                                    time = t,
                                    state = model.state, -- When waiting, state changes are handled by ClickButton event
                                    repNum = model.repNum, -- repNum is not affected in tick method
                                    passNum = model.passNum, -- When waiting, passNum is affected by only by ClickButton event
                                    showTime = blinkTime -- showTime is only for showing player the answer
                                }
                            Finished -> {
                                    time = t,
                                    state = model.state, -- When waiting, state changes are handled by ClickButton event
                                    repNum = model.repNum, -- repNum is not affected in tick method
                                    passNum = model.passNum, -- When waiting, passNum is affected by only by ClickButton event
                                    showTime = model.showTime + 1 -- showTime is only for showing player the answer
                                }
                            Incorrect -> {
                                        time = t,
                                        state = if (model.showTime <= 0 && model.passNum >= model.repNum - 1)
                                                    then Showing
                                                    else model.state,
                                        repNum = model.repNum, -- repNum is only increased after getting the entire sequence up to repNum right
                                        passNum = 0, 
                                        showTime = if model.showTime <= 0 
                                                    then blinkTime
                                                    else model.showTime - 1
                                    }
                    ClickButton num -> if model.state /= Waiting then model else {
                            time = model.time, 
                            state = if (num == (sequence model.passNum)) -- If a correct guess
                                        then if (model.passNum >= model.repNum - 1) -- If last correct guess in the sequence
                                                then if (model.repNum >= 5) -- If last correct guess
                                                        then Finished
                                                        else Showing
                                                else Waiting
                                        else Incorrect,
                            repNum = if (num == sequence model.passNum)
                                        then (if (model.passNum >= model.repNum - 1)
                                                then model.repNum + 1 
                                                else model.repNum)
                                        else 1,
                            passNum = if (num == (sequence model.passNum) && model.passNum < model.repNum - 1)
                                        then model.passNum + 1 
                                        else 0, 
                            showTime = if model.state == Finished then 0 else model.showTime
                        }


init : Model
init = {time = 0, passNum = 0, repNum = 1, showTime = blinkTime, state = Showing}

main = gameApp Tick {model = init, view = view, update = update, title = "ElmongUs Passcode" }

view model = collage 192 128 (myShapes model)