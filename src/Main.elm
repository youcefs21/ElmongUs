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



type State = Caf


type Msg = Tick Float GetKeyState

type alias Model = { 
    time  : Float , 
    state : State 
  }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Tick _ _ ->
            model


init : Model
init = {
    time = 0,
    state = Caf
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