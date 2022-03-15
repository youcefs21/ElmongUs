module Main exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import Cafeteria exposing (cafeteria)


myShapes : Model -> List (Shape Msg)
myShapes model = 
  case model.state of
    Caf -> [
        cafeteria
      ]
    _ -> []



type State = Caf | MedBay | UpperEng


type Msg = Tick Float GetKeyState

type alias Model = { 
    time  : Float , 
    state : State ,
    x     : Float ,
    y     : Float
  }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Tick _ _ ->
            case model.state of
              Caf ->
                {model | state = notifyCafExit model.x model.y}
              MedBay ->
                {model | state = notifyMedBayExit model.x model.y}
              UpperEng ->
                model


notifyCafExit x _ = 
   if x < -50 then
      MedBay
   else
      Caf


notifyMedBayExit x _ = 
   if x < -50 then
      UpperEng
   else
      MedBay



init : Model
init = {
    time = 0,
    state = Caf,
    x = 0,
    y = 0
  }


main : GameApp Model Msg
main = 
  gameApp Tick { 
    model  = init, 
    title  = "The Best Rocket Game of 1XD3 by Lab 3 Group 2",
    update = update,
    view   = view       
  }


view : Model -> Collage Msg
view model = collage 192 128 ( myShapes model )