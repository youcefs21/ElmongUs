module Passcode exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.EllieApp exposing (..)
import String
import Element.Font exposing (monospace)
import Set exposing (Set)
import String exposing (fromFloat)
import Consts exposing (..)

myShapes model = 
    List.map2 (\x y ->
        button (x, y) model
            |> move (17, 0)
    )
    [0, 0, 0, 1, 1, 1, 2, 2, 2]
    [0, 1, 2, 0, 1, 2, 0, 1, 2]
    ++
    List.map2 (\x y ->
        square 11
                |> filled (if ((model.state == Showing) && (sequence model.passNum == (x, y))) then lightBlue else black)
                |> move (11 * (toFloat x - 1) - 17, 11 * (toFloat y - 1))
    )
    [0, 0, 0, 1, 1, 1, 2, 2, 2]
    [0, 1, 2, 0, 1, 2, 0, 1, 2]
    ++
    [
        text (case model.state of Showing -> "Showing" 
                                  Waiting -> "Waiting"
                                  Incorrect -> "Incorrect"
                                  Finished -> "Finished")
            |> size 4
            |> centered
            |> filled black
            |> move (0, 35){-},
        text (String.fromInt model.showTime)
            |> size 4
            |> centered
            |> filled black
            |> move (0, 30),
        text (String.fromInt model.passNum)
            |> size 4
            |> centered
            |> filled black
            |> move (0, 25),
        text (String.fromInt model.repNum)
            |> size 4
            |> centered
            |> filled black
            |> move (0, 20),
        square 5
            |> filled model.testCol
            |> move (0, -35)
    -}]
    
button (x, y) model = group [
        square 10
        |> filled grey
        |> move (11 * (toFloat x - 1), 11 * (toFloat y - 1))
        |> notifyTap (ClickButton (x, y))
    ]
    
sequence i = case i of 
            0 -> (0, 0)
            1 -> (1, 0)
            2 -> (2, 0)
            3 -> (0, 1)
            4 -> (1, 1)
            default -> (0, 0)

type State = Waiting | Showing | Incorrect | Finished
type alias Model = {time : Float, passNum : Int, repNum : Int, showTime : Int, testCol : Color, state : State}

update : Consts.Msg -> Model -> Model
update msg model = case msg of 
                    Tick t _ -> 
                        if model.state == Showing 
                            then {
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
                                                    then 10 
                                                    else model.showTime - 1,
                                        testCol = model.testCol
                                    }
                                else { -- model.state = Waiting
                                        time = t,
                                        state = model.state, -- When waiting, state changes are handled by ClickButton event
                                        repNum = model.repNum, -- repNum is not affected in tick method
                                        passNum = model.passNum, -- When waiting, passNum is affected by only by ClickButton event
                                        showTime = 10, -- showTime is only for showing player the answer
                                        testCol = model.testCol
                                    }
                    ClickButton num -> if model.state /= Waiting then model else {
                            time = model.time, 
                            state = if (num == (sequence model.passNum)) -- If a correct guess
                                        then if (model.passNum >= model.repNum - 1) -- If last correct guess in the sequence
                                                then if (model.repNum >= 5) -- If last correct guess
                                                        then Finished
                                                        else Showing
                                                else Waiting
                                        else Showing,
                            repNum = if (num == sequence model.passNum)
                                        then (if (model.passNum >= model.repNum - 1)
                                                then model.repNum + 1 
                                                else model.repNum)
                                        else 1,
                            passNum = if (num == (sequence model.passNum) && model.passNum < model.repNum - 1)
                                        then model.passNum + 1 
                                        else 0, 
                            showTime = model.showTime,
                            testCol = if num == (sequence model.passNum) 
                                        then white 
                                        else red
                        }


init : Model
init = {time = 0, passNum = 0, repNum = 1, showTime = 10, testCol = white, state = Showing}

main = gameApp Tick {model = init, view = view, update = update, title = "ElmongUs Passcode" }

view model = collage 192 128 (myShapes model)