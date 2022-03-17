module Main exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import Cafeteria exposing (cafeteria)
import MedBay exposing (medbay)
import UpperEng exposing (upperEng)
import Security exposing (security)
import Storage exposing (storage)
import Electrical exposing (electrical)
import Admin exposing (admin)
import Reactor exposing (reactorRoom)
import LowerEng exposing (lowerEng)
import Imposter exposing (..)
import Tuple exposing (first)
import Tuple exposing (second)
import Html exposing (button)


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
      Reactor -> [
        reactorRoom |> group
        , imposter model.impModel
          |> scale 0.3
          |> scaleX direction
          |> move model.impModel.pos,
        let
            x = Tuple.first model.impModel.pos
            y = Tuple.second model.impModel.pos
            showCond = ((x + 50)^2 + (y + 20)^2)^(0.5) < 30
        in
            (buttonToMiniGame (showCond && (not model.leaf))
                |> move (-50, -20))
                |> (if showCond then notifyTap (ToggleLeaf True) else identity)
        ]
      LowerEng -> [
        lowerEng |> group
        , imposter model.impModel
          |> scale 0.3
          |> scaleX direction
          |> move model.impModel.pos
        ]
      Electrical -> [
          electrical |> group
        , imposter model.impModel
          |> scale 0.3
          |> scaleX direction
          |> move model.impModel.pos
        ]
      Storage -> [
        storage
        , imposter model.impModel
          |> scale 0.3
          |> scaleX direction
          |> move model.impModel.pos
        ]
      Admin -> [
        admin
        , imposter model.impModel
          |> scale 0.3
          |> scaleX direction
          |> move model.impModel.pos
        ]

buttonToMiniGame show =
    group [
        circle 10
            |> filled yellow
            |> makeTransparent (if show then 0.8 else 0.5),
        text "wow, a minigame"
            |> centered
            |> sansserif
            |> size 2
            |> filled black
    ]

type State = Caf | MedBay | UpperEng | Security | Reactor | LowerEng | Electrical | Storage | Admin


type Msg = Tick Float GetKeyState
         | ToggleLeaf Bool

type alias Model = { 
    time     : Float , 
    state    : State ,
    impModel : Imposter.Model,
    leaf     : Bool,
    leafTime : Float
  }

init : Model
init = {
    time = 0,
    state = Reactor,
    impModel = Imposter.init,
    leaf = False,
    leafTime = 0
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
                Security ->
                  notifySecurityExit model newImpModel
                Reactor ->
                  notifyReactorExit model newImpModel
                LowerEng ->
                  notifyLowerEngExit model newImpModel
                Electrical ->
                  notifyElectricalExit model newImpModel
                Storage ->
                  notifyStorageExit model newImpModel
                Admin ->
                  notifyAdminExit model newImpModel
        ToggleLeaf b ->
            { model | leaf = b, leafTime = model.time }

notifyCafExit : Model -> Imposter.Model -> Model
notifyCafExit model newImpModel = 
   if (first newImpModel.pos) < -96 then
      {model| state = MedBay,
              impModel = {newImpModel | pos = (90,45),
                preBorderLines = MedBay.preBorderLines
                }
        }
   else
      {model| impModel = {newImpModel| preBorderLines = Cafeteria.preBorderLines}}


notifyMedBayExit : Model -> Imposter.Model -> Model
notifyMedBayExit model newImpModel = 
   if (first newImpModel.pos) < -96 then
      {model| state = UpperEng,
            impModel = {newImpModel | pos = (90,0),
            preBorderLines = UpperEng.preBorderLines
        }
      }
   else
      {model| impModel = {newImpModel| preBorderLines = MedBay.preBorderLines}}


notifyUpperEngExit : Model -> Imposter.Model -> Model
notifyUpperEngExit model newImpModel = 
   if (second newImpModel.pos) < -64 then
      {model| state = Security,
            impModel = {newImpModel | pos = (-50,40),
            preBorderLines = Security.preBorderLines
        }
      }
   else
      {model| impModel = {newImpModel| preBorderLines = UpperEng.preBorderLines}}

notifySecurityExit : Model -> Imposter.Model -> Model
notifySecurityExit model newImpModel = 
   if (second newImpModel.pos) < -64 then
      {model| state = LowerEng,
            impModel = {newImpModel | pos = (-20,60),
            preBorderLines = LowerEng.preBorderLines
        }
      }
   else if (first newImpModel.pos) < -96 then
      {model| state = Reactor,
              impModel = {newImpModel | pos = (60,-30),
                preBorderLines = Reactor.preBorderLines
          }
        }
   else
      {model| impModel = {newImpModel| preBorderLines = Security.preBorderLines}}

notifyReactorExit : Model -> Imposter.Model -> Model
notifyReactorExit model newImpModel = 
    if (first newImpModel.pos) > 96 then
      {model| state = Security,
            impModel = {newImpModel | pos = (-50,(second newImpModel.pos)),
            preBorderLines = Security.preBorderLines
        }
      }
   else if (second newImpModel.pos) < -64 then
      {model| state = LowerEng,
            impModel = {newImpModel | pos = (-35,50),
            preBorderLines = LowerEng.preBorderLines
        }
      }
    else
      {model| impModel = {newImpModel| preBorderLines = Reactor.preBorderLines}}

notifyLowerEngExit : Model -> Imposter.Model -> Model
notifyLowerEngExit model newImpModel = 
    if (first newImpModel.pos) > 96 then
      {model| state = Electrical,
            impModel = {newImpModel | pos = (-50,-50),
            preBorderLines = Electrical.preBorderLines
        }
      }
    else
      {model| impModel = {newImpModel| preBorderLines = LowerEng.preBorderLines}}


notifyElectricalExit : Model -> Imposter.Model -> Model
notifyElectricalExit model newImpModel = 
   if (second newImpModel.pos) < -64 then
      {model| state = Storage,
            impModel = {newImpModel | pos = (-70,-25),
            preBorderLines = Storage.preBorderLines
        }
      }
   else
      {model| impModel = {newImpModel| preBorderLines = Electrical.preBorderLines}}


notifyStorageExit : Model -> Imposter.Model -> Model
notifyStorageExit model newImpModel = 
   if (second newImpModel.pos) > 64 then
      {model| state = Admin,
            impModel = {newImpModel | pos = (-70,-25),
            preBorderLines = Admin.preBorderLines
        }
      }
   else
      {model| impModel = {newImpModel| preBorderLines = Storage.preBorderLines}}


notifyAdminExit : Model -> Imposter.Model -> Model
notifyAdminExit model newImpModel = 
   if (second newImpModel.pos) > 64 then
      {model| state = Caf,
            impModel = {newImpModel | pos = (0,-25),
            preBorderLines = Cafeteria.preBorderLines
        }
      }
   else
      {model| impModel = {newImpModel| preBorderLines = Admin.preBorderLines}}


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