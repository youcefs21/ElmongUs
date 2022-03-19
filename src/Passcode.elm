module Passcode exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.EllieApp exposing (..)
import String
import Element.Font exposing (monospace)
import Set exposing (Set)
import String exposing (fromFloat)
import Consts exposing (..)

myShapes model = [
    rectangle 49 53
        |> filled (rgb 165 165 165) |> move (-20, 3)
        |> addOutline (solid 0.5) black, 
    rectangle 49 53
        |> filled (rgb 165 165 165) |> move (31, 3)
        |> addOutline (solid 0.5) black,
    -- Left screen that shows you the 
    polygon [(-20,2),(20,2),(24,-2),(-24,-2)]
        |> filled (rgb 99 101 98) |> rotate (degrees 90) |> move (2, 3),
    polygon [(-20,2),(20,2),(24,-2),(-24,-2)]
        |> filled (rgb 99 101 98) |> rotate (degrees 270) |> move (-42, 3),
    polygon [(-20,2),(20,2),(24,-2),(-24,-2)]
        |> filled (rgb 99 101 98) |> rotate (degrees 360) |> move (-20, -21),
    polygon [(-20,2),(20,2),(24,-2),(-24,-2)]
        |> filled (rgb 204 204 204) |> rotate (degrees 180) |> move (-20, 27),
    -- Right screen where you input the button presses
    polygon [(-20,2),(20,2),(24,-2),(-24,-2)]
        |> filled (rgb 99 101 98) |> rotate (degrees 90) |> move (53, 3),
    polygon [(-20,2),(20,2),(24,-2),(-24,-2)]
        |> filled (rgb 99 101 98) |> rotate (degrees 270) |> move (9, 3),
    polygon [(-20,2),(20,2),(24,-2),(-24,-2)]
        |> filled (rgb 99 101 98) |> rotate (degrees 360) |> move (31, -21),
    polygon [(-20,2),(20,2),(24,-2),(-24,-2)]
        |> filled (rgb 204 204 204) |> rotate (degrees 180) |> move (31, 27)]
    ++
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
        square 11
            |> filled (if 
                    ((model.state == Showing) &&          -- If the model is showing what the correct button sequence is,
                    (sequence model.passNum == (x, y)) && -- the button currently being drawn is the one the model wants to light up,
                    (model.showTime < 15))                -- and The model is not in the space in-between lighting up buttons where all buttons are black,
                        then lightBlue -- Then light up this button to show it's the next correct one in the sequence;
                        else black     -- Else leave it off.
                )
            |> move (11 * (toFloat x - 1) - 20, 11 * (toFloat y - 1))
        )
        [0, 0, 0, 1, 1, 1, 2, 2, 2] -- x-coordinates
        [0, 1, 2, 0, 1, 2, 0, 1, 2] -- y-coordinates
    ++
    -- This map function produces the circles above the screen on the left
    List.map (\x -> 
                circle 2 -- Turn the first few green based on how far the user is, make the rest green
                    |> filled (
                        if x <= model.repNum   -- If the number of the circle being drawn is lower or equal to the number of circles that need to be lit up,
                            then (rgb 0 190 1) -- then light it up
                            else darkGrey
                        )
                    |> addOutline (solid 0.3) black
                    |> move (7 * (toFloat x - 3) - 20, 20)
        )
        (List.range 1 5) -- x-coordinates
    ++
    -- This map function produces the circles above the buttons on the right
    List.map (\x -> 
                circle 2
                    |> filled (
                        case model.state of
                            Incorrect -> red -- Turn red if incorrect
                            Waiting -> ( -- If user is inputting presses, light up the number of correct guesses they have inputted
                                    if x <= model.passNum 
                                        then (rgb 0 190 1) 
                                        else darkGrey
                                )
                            _ -> darkGrey
                        )
                    |> addOutline (solid 0.3) black
                    |> move (7 * (toFloat x - 3) + 31, 20)
        )
        (List.range 1 5) -- x-coordinates

-- Function to create a button
button (x, y) model = group [
        square 10
        -- Change colour based on model.state and some other factors
        |> filled (case model.state of
                Showing -> darkGrey -- darkGrey instead of grey to show that the user can't press the button right now
                Waiting -> grey
                Finished -> (
                        if model.showTime < 2 * blinkTime -- For first blinkTime number of frames, 
                            then lightBlue                -- light up all buttons to show that you're done
                             else darkGrey                -- Then turn off again.
                    )
                Incorrect -> red -- Light up all the buttons if you press an incorrect one.
            )
        |> addOutline (solid 0.3) black
        -- 11 is the distance from the center of each button to the next
        |> move (11 * (toFloat x - 1), 11 * (toFloat y - 1))
        |> notifyTap (ClickButton (x, y)) -- If clicked, send the (x, y) coordinates that act like an id for this button
    ]

-- Sequence of correct presses.  Works like indexing a list.
sequence i = case i of 
            0 -> (0, 0) -- Returns tuples that work both as the (x, y) coordinates of a button and as the id of a button
            1 -> (1, 1)
            2 -> (2, 1)
            3 -> (0, 2)
            4 -> (2, 0)
            _ -> (-1, -1)

blinkTime = 20 -- Time a button should light up before turning off again.

type State = Waiting | Showing | Incorrect | Finished

type alias Model = {
        time     : Float, -- Normal time
        passNum  : Int,   -- When model.state == Waiting, this counts the number of buttons you've pressed.  
                          -- When model.state == Showing, it records which button is currently being shown.
        repNum   : Int,   -- Number of correct cycles the user has done so far
        showTime : Int,   -- A frame counter that the model uses to time lighting up buttons
        state    : State  -- State
    }

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
                            Waiting -> {model | time = t, showTime = blinkTime} -- Not much changes during a frame when the model is waiting for input
                            Finished -> {model | time = t, showTime = model.showTime + 1} -- Not much changes when finished,
                                            -- Except showTime, which counts up so that the buttons will only flash blue for the first blinkTime number of frames
                            Incorrect -> {
                                        time = t,
                                        state = if model.showTime <= 0 -- If time is up
                                                    then Showing       -- Go back to showing
                                                    else Incorrect,    -- Else keep flashing red
                                        repNum = model.repNum,
                                        passNum = 0, -- If user inputted an incorrect sequence, the number of correct sequences they've entered resets.
                                        showTime = if model.showTime <= 0 -- Count down showtime to 0.
                                                    then blinkTime
                                                    else model.showTime - 1
                                    }
                    ClickButton num -> if model.state /= Waiting then model else { -- If user clicked button at wrong time, do nothing
                            time = model.time, 
                            state = if (num == (sequence model.passNum)) -- If a correct button press
                                        then if (model.passNum >= model.repNum - 1) -- If last correct guess in the current sequence
                                                then if (model.repNum >= 5) -- If last correct sequence, then user is done, else it shows the next part of the sequence
                                                        then Finished
                                                        else Showing
                                                else Waiting
                                        else Incorrect,
                            repNum = if (num == sequence model.passNum) -- If a correct guess
                                        then (if (model.passNum >= model.repNum - 1) -- If last correct guess of the current sequence, increase the number of correct sequences
                                                then model.repNum + 1 -- increase the number of correct sequences
                                                else model.repNum)
                                        else 1, -- If an incorrect guess, reset
                            passNum = if (num == (sequence model.passNum) && -- If a correct guess
                                         model.passNum < model.repNum - 1) -- and this isn't the last correct guess of the sequence,
                                            then model.passNum + 1 -- Increase the number of correct guesses of this sequence
                                            else 0, -- Either because the user inputted an incorrect guess, or because passnum will be used differently when model.state == Showing
                            showTime =  model.showTime
                        }


init : Model
init = {time = 0, passNum = 0, repNum = 1, showTime = blinkTime, state = Showing}

main = gameApp Tick {model = init, view = view, update = update, title = "ElmongUs Passcode" }

view model = collage 192 128 (myShapes model)