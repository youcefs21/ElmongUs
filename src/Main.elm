module Main exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import Cafeteria exposing (cafeteria)
import MedBay exposing (medbay)
import Imposter exposing (..)
import Tuple exposing (first)


myShapes : Model -> List (Shape Msg)
myShapes model = 
  case model.state of
    Caf -> [
        cafeteria
        , Imposter.toLineOutliness model.impModel.preBorderLines |> group
        , imposter 0
          |> scale 0.3
          |> move model.impModel.pos
      ]
    MedBay -> [
        medbay
        , Imposter.toLineOutliness model.impModel.preBorderLines |> group
        , imposter 0
          |> scale 0.3
          |> move model.impModel.pos
      ]
    _ -> []



type State = Caf | MedBay | UpperEng


type Msg = Tick Float GetKeyState

type alias Model = { 
    time     : Float , 
    state    : State ,
    impModel : Imposter.Model
  }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Tick t k ->
            let
              newImpModel = Imposter.update (Imposter.Tick t k) model.impModel
            in
              
              case model.state of
                Caf ->
                  notifyCafExit model newImpModel
                MedBay ->
                  notifyMedBayExit model newImpModel
                UpperEng ->
                  model

notifyCafExit : Model -> Imposter.Model -> Model
notifyCafExit model newImpModel = 
   if (first newImpModel.pos) < -96 then
      {model| state = MedBay,
              impModel = {newImpModel | pos = (90,45),
                preBorderLines = MedBay.preBorderLines
                }
        }
   else
      {model| impModel = newImpModel}


notifyMedBayExit : Model -> Imposter.Model -> Model
notifyMedBayExit model newImpModel = 
   if (first newImpModel.pos) < -96 then
      {model| state = UpperEng, impModel = newImpModel}
   else
      {model| impModel = newImpModel}



init : Model
init = {
    time = 0,
    state = Caf,
    impModel = Imposter.init
  }


main : GameApp Model Msg
main = 
  gameApp Tick { 
    model  = init, 
    title  = "Elmongus",
    update = update,
    view   = view       
  }


view : Model -> Collage Msg
view model = collage 192 128 ( myShapes model )