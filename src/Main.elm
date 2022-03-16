module Main exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import Cafeteria exposing (cafeteria)
import MedBay exposing (medbay)
import UpperEng exposing (upperEng)
import Security exposing (security)
import Imposter exposing (..)
import Tuple exposing (first)
import Tuple exposing (second)


myShapes : Model -> List (Shape Msg)
myShapes model = 
  let
      direction = if model.impModel.left then 1 else -1
  in
    
    case model.state of
      Caf -> [
          cafeteria
          -- , Imposter.toLineOutliness model.impModel.preBorderLines |> group
          , imposter model.impModel
            |> scale 0.3
            |> scaleX direction
            |> move model.impModel.pos
        ]
      MedBay -> [
          medbay
          -- , Imposter.toLineOutliness model.impModel.preBorderLines |> group
          , imposter model.impModel
            |> scale 0.3
            |> scaleX direction
            |> move model.impModel.pos
        ]
      UpperEng -> [
        upperEng |> group
        -- , Imposter.toLineOutliness model.impModel.preBorderLines |> group
        , imposter model.impModel
          |> scale 0.3
          |> scaleX direction
          |> move model.impModel.pos
        ]
      Security -> [
        security |> group
        , imposter model.impModel
          |> scale 0.3
          |> scaleX direction
          |> move model.impModel.pos
        ]
      Reactor -> []
      LowerEng -> []



type State = Caf | MedBay | UpperEng | Security | Reactor | LowerEng


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
                  notifyUpperEngExit model newImpModel
                -- Security ->
                --   notifySecurityExit model newImpModel
                _ ->
                  {model| impModel = newImpModel}

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
      {model| state = UpperEng,
            impModel = {newImpModel | pos = (90,0),
            preBorderLines = UpperEng.preBorderLines
        }
      }
   else
      {model| impModel = newImpModel}

notifyUpperEngExit : Model -> Imposter.Model -> Model
notifyUpperEngExit model newImpModel = 
   if (second newImpModel.pos) < -64 then
      {model| state = Security,
            impModel = {newImpModel | pos = (-50,40),
            preBorderLines = Security.preBorderLines
        }
      }
   else
      {model| impModel = newImpModel}

-- notifySecurityExit : Model -> Imposter.Model -> Model
-- notifySecurityExit model newImpModel = 
--    if (second newImpModel.pos) < -64 then
--       {model| state = LowerEng,
--             impModel = {newImpModel | pos = (-20,40),
--             preBorderLines = LowerEng.preBorderLines
--         }
--       }
--    else if (first newImpModel.pos) < -96 then
--       {model| state = Reactor,
--               impModel = {newImpModel | pos = (90,45),
--                 preBorderLines = Reactor.preBorderLines
--           }
--         }
--    else
--       {model| impModel = newImpModel}



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