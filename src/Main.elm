module Main exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)


myShapes model = 
  case model.state of
    Caf -> [

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
        Tick t _ ->
            model

init = {
    time = 0,
    state = Caf
  }


main = 
  gameApp Tick { 
    model  = init, 
    title  = "The Best Rocket Game of 1XD3 by Lab 3 Group 2",
    update = update,
    view   = view       
  }


view model = collage 192 128 ( myShapes model )
