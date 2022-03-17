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
import Tuple exposing (first, second)
import Imposter exposing (..)
import Leaf exposing (..)
import Consts exposing (..)
import Wires exposing (..)
import Swipe exposing (..)
import Passcode exposing (..)


myShapes : Model -> List (Shape Consts.Msg)
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
          |> move model.impModel.pos,
        let
            x = first model.impModel.pos
            y = second model.impModel.pos
            showCond = ((x - 37)^2 + (y - 40)^2)^(0.5) < 30
        in
            (buttonToMiniGame (showCond && (not model.leaf))
                |> move (37, 40))
                |> (if showCond then notifyTap (TogglePass True) else identity),
        if model.pass then
            Passcode.myShapes model.passModel
                |> group
        else group []
        ]
      Reactor -> [
        reactorRoom |> group
        , imposter model.impModel
          |> scale 0.3
          |> scaleX direction
          |> move model.impModel.pos,
        let
            x = first model.impModel.pos
            y = second model.impModel.pos
            showCond = ((x + 50)^2 + (y + 20)^2)^(0.5) < 30
        in
            (buttonToMiniGame (showCond && (not model.leaf))
                |> move (-50, -20))
                |> (if showCond then notifyTap (ToggleLeaf True) else identity),
        if model.leaf then
            Leaf.myShapes model.leafModel
              |> group
        else group []
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
          |> move model.impModel.pos,
            let
                x = first model.impModel.pos
                y = second model.impModel.pos
                showCond = ((x + 38)^2 + (y - 54)^2)^(0.5) < 30
            in
                (buttonToMiniGame (showCond && (not model.leaf))
                    |> move (-38, 54))
                    |> (if showCond then notifyTap (ToggleWire True) else identity),
            if model.wire then
                Wires.myShapes model.wireModel
                    |> group
            else group []
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
          |> move model.impModel.pos,
        let
            x = first model.impModel.pos
            y = second model.impModel.pos
            showCond = ((x - 50)^2 + (y + 5)^2)^(0.5) < 30
        in
            (buttonToMiniGame (showCond && (not model.leaf))
                |> move (50, -5))
                |> (if showCond then notifyTap (ToggleSwipe True) else identity),
        if model.swipe then
            Swipe.myShapes model.swipeModel
                |> group
        else group []
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
        |> scale 0.7

type State = Caf | MedBay | UpperEng | Security | Reactor | LowerEng | Electrical | Storage | Admin

type alias Model = { 
    time     : Float , 
    state    : State ,
    impModel : Imposter.Model,
    leaf     : Bool,
    leafModel : Leaf.Model,
    wire     : Bool,
    wireModel : Wires.Model,
    swipe    : Bool,
    swipeModel : Swipe.Model,
    pass : Bool,
    passModel : Passcode.Model
  }

init : Model
init = {
    time = 0,
    state = Caf,
    impModel = Imposter.init,
    leaf = False,
    leafModel = Leaf.init,
    wire = False,
    wireModel = Wires.init,
    swipe = False,
    swipeModel = Swipe.init,
    pass = False,
    passModel = Passcode.init
  }

update : Consts.Msg -> Model -> Model
update msg model =
    case msg of
        Tick t k ->
            let
              newModel = { model | time = t }
              inMiniGame = model.leaf || model.wire || model.swipe || model.pass
              newImpModel = if inMiniGame then model.impModel else Imposter.update (Tick t k) model.impModel
              newLeafModel = if model.leaf then Leaf.update (Tick t k) model.leafModel else model.leafModel
              newWireModel = if model.wire then Wires.update (Tick t k) model.wireModel else model.wireModel
              newSwipeModel = if model.swipe then Swipe.update (Tick t k) model.swipeModel else model.swipeModel
              newPassModel = if model.pass then Passcode.update (Tick t k) model.passModel else model.passModel
            in
              
              case model.state of
                Caf ->
                  notifyCafExit newModel newImpModel
                MedBay ->
                  notifyMedBayExit newModel newImpModel
                UpperEng ->
                  notifyUpperEngExit newModel newImpModel
                Security ->
                  notifySecurityExit newModel newImpModel newPassModel
                Reactor ->
                  notifyReactorExit newModel newImpModel newLeafModel
                LowerEng ->
                  notifyLowerEngExit newModel newImpModel
                Electrical ->
                  notifyElectricalExit newModel newImpModel newWireModel
                Storage ->
                  notifyStorageExit newModel newImpModel
                Admin ->
                  notifyAdminExit newModel newImpModel newSwipeModel
        ToggleLeaf b ->
            { model | leaf = b, leafModel = { time = model.time, points = pointsFromRandomDotOrg, state = Leaf.Waiting, delay = 0, startTime = model.time } }
        ToggleWire b ->
            { model | wire = b, wireModel = Wires.init }
        ToggleSwipe b ->
            { model | swipe = b, swipeModel = Swipe.init }
        TogglePass b ->
            { model | pass = b, passModel = Passcode.init }
        MouseDownAt a b ->
            { model | leafModel = Leaf.update (MouseDownAt a b) model.leafModel }
        MouseMoveTo a ->
            { model | leafModel = if model.leaf then Leaf.update (MouseMoveTo a) model.leafModel else model.leafModel,
                      wireModel = if model.wire then Wires.update (MouseMoveTo a) model.wireModel else model.wireModel }
        Stop a ->
            { model | leafModel = Leaf.update (Stop a) model.leafModel }
        ClickWire a b ->
            { model | wireModel = Wires.update (ClickWire a b) model.wireModel }
        StopWire ->
            { model | wireModel = Wires.update (StopWire) model.wireModel }
        ConnectWires a ->
            { model | wireModel = Wires.update (ConnectWires a) model.wireModel }
        MoveTop ->
            { model | swipeModel = Swipe.update (MoveTop) model.swipeModel }
        Move a ->
            { model | swipeModel = Swipe.update (Move a) model.swipeModel }
        ToggleMove a b ->
            { model | swipeModel = Swipe.update (ToggleMove a b) model.swipeModel }
        Finish ->
            { model | swipeModel = Swipe.update (Finish) model.swipeModel }
        ClickButton a ->
            { model | passModel = Passcode.update (ClickButton a) model.passModel }

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

notifySecurityExit model newImpModel newPassModel = 
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
      {model| impModel = {newImpModel| preBorderLines = Security.preBorderLines},
              passModel = newPassModel }

notifyReactorExit model newImpModel newLeafModel = 
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
      {model | impModel = { newImpModel | preBorderLines = Reactor.preBorderLines },
              leafModel = newLeafModel }

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


notifyElectricalExit model newImpModel newWireModel = 
   if (second newImpModel.pos) < -64 then
      {model| state = Storage,
            impModel = {newImpModel | pos = (-70,-25),
            preBorderLines = Storage.preBorderLines
        }
      }
   else
      {model| impModel = {newImpModel| preBorderLines = Electrical.preBorderLines},
              wireModel = newWireModel }


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


notifyAdminExit model newImpModel newSwipeModel = 
   if (second newImpModel.pos) > 64 then
      {model| state = Caf,
            impModel = {newImpModel | pos = (0,-25),
            preBorderLines = Cafeteria.preBorderLines
        }
      }
   else
      {model| impModel = {newImpModel| preBorderLines = Admin.preBorderLines},
              swipeModel = newSwipeModel }


main : GameApp Model Consts.Msg
main = 
  gameApp Tick { 
    model  = init, 
    title  = "Elmongus",
    update = update,
    view   = view       
  }


view : Model -> Collage Consts.Msg
view model = collage 192 128 ( myShapes model )