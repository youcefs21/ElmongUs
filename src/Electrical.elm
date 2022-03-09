module Electrical exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.EllieApp exposing (..)

myShapes _ =
  [
    background
  , boxes
  , vent -58 40
  , wall_buttons
  , wires
  ]

background = group
  [
    rect 200 200 |> filled (rgb 60 74 74)
  , polygon [(0,0), (0,160),(120,154),(120,110),(90,90),(90,40),(65,15),(35,15),(35,0)]
      |> filled (rgb 41 48 49) |> move (-68, -72) |> addOutline (solid 1.5) (rgb 12 21 21) |> scale 1.025
  , polygon [(0,0), (0,160),(120,154),(120,110),(90,90),(90,40),(65,15),(35,15),(35,0)]
      |> filled (rgb 90 93 79) |> move (-70, -70) |> addOutline (solid 1.5) (rgb 12 21 21)
  , rect 120 15 |> filled (rgb 145 146 126) |> move (-10, 56) |> addOutline (solid 1) (rgb 12 21 21)
  , rect 3 200 |> filled (rgb 41 48 49) |> move (-70, 0) |> addOutline (solid 1.5) (rgb 12 21 21)
  , rect 3 30 |> filled (rgb 41 48 49) |> move (-35, -70) |> addOutline (solid 1.5) (rgb 12 21 21)
  ]
  
boxes = group
  [
  -- front boxes
    rect 50 10 |> filled (rgb 88 112 112) |> move (-43, 15) |> addOutline (solid 1) (rgb 12 21 21)
  , rect 50 15 |> filled (rgb 126 150 151) |> move (-43, 2.5) |> addOutline (solid 1) (rgb 12 21 21)
  , rect 10 15 |> filled (rgb 126 150 151) |> move (-43, 2.5) |> addOutline (solid 1) (rgb 12 21 21)
  , rect 7 12 |> filled (rgb 64 71 74) |> move (-33, 2.5) |> addOutline (solid 0.75) (rgb 12 21 21) 
  , rect 7 12 |> filled (rgb 64 71 74) |> move (-23, 2.5) |> addOutline (solid 0.75) (rgb 12 21 21) 
  , rect 15 12 |> filled (rgb 126 150 151) |> move (-58, 2.5) |> addOutline (solid 1) (rgb 12 21 21)
  , isosceles 4 4 |> filled (rgb 222 186 24) |> move (-58, 2.5) |> addOutline (solid 0.75) (rgb 12 21 21)
  
  -- set of upper boxes
  , rect 10 5 |> filled (rgb 88 112 112) |> move (-20, 57) |> addOutline (solid 1) (rgb 12 21 21)
  , rect 10 10 |> filled (rgb 126 150 151) |> move (-20, 50) |> addOutline (solid 1) (rgb 12 21 21)
  , rect 10 5 |> filled (rgb 88 112 112) |> move (-8, 57) |> addOutline (solid 1) (rgb 12 21 21)
  , rect 10 10 |> filled (rgb 126 150 151) |> move (-8, 50) |> addOutline (solid 1) (rgb 12 21 21)
  , rect 10 5 |> filled (rgb 88 112 112) |> move (4, 57) |> addOutline (solid 1) (rgb 12 21 21)
  , rect 10 10 |> filled (rgb 126 150 151) |> move (4, 50) |> addOutline (solid 1) (rgb 12 21 21)
  
  -- top right box
  , rect 35 14 |> filled (rgb 151 154 145) |> move (32, 50) |> addOutline (solid 1) (rgb 12 21 21)
  , rect 35 5 |> filled (rgb 121 120 110) |> move (32, 59) |> addOutline (solid 1) (rgb 12 21 21)
  , rect 10 18 |> outlined (solid 1) (rgb 12 21 21) |> move (34, 52)
  , rect 7 8 |> outlined (solid 1) (rgb 12 21 21) |> move (34, 51)
  , isosceles 3 3 |> filled (rgb 222 186 24) |> move (34, 50.5) |> addOutline (solid 0.5) (rgb 12 21 21)
  ]
  
vent x y = group
  [
    roundedRect 12 9 2 |> filled (rgb 148 168 173) |> addOutline (solid 1) (rgb 26 32 33) |> move (x, y)
  , roundedRect 10 0.5 1 |> filled (rgb 74 85 100) |> move (x, y - 2.5)
  , roundedRect 10 0.5 1 |> filled (rgb 74 85 100) |> move (x, y - 1)
  , roundedRect 10 0.5 1 |> filled (rgb 74 85 100) |> move (x, y + 0.5)
  , roundedRect 10 0.5 1 |> filled (rgb 74 85 100) |> move (x, y + 2)
  ]
  
wall_buttons = group
  [
    rect 10 5 |> filled (rgb 128 150 159) |> move (-38, 55) |> addOutline (solid 1) (rgb 12 21 21)
  , rect 10 7 |> filled (rgb 30 32 38) |> move (-58, 55) |> addOutline (solid 1) (rgb 12 21 21)
  , rect 8.5 5.5 |> outlined (solid 0.5) (rgb 113 128 130) |> move (-58, 55)
  , circle 1.5 |> filled (rgb 121 122 143) |> move (-58, 55)
  , circle 0.5 |> filled (rgb 226 17 18) |> move (-55, 52.5)
  
  , rect 5 3 |> filled (rgb 126 150 151) |> move (-8, 50) |> addOutline (solid 1) (rgb 12 21 21)
  ]
  
wires = group
  [
    roundedRect 80 1.5 1 |> filled (rgb 0 0 0) |> move (-28, 30)
  , roundedRect 25 1.5 1 |> filled (rgb 0 0 0) |> rotate (degrees 33) |> move (20, 36)
  , roundedRect 25 1.5 1 |> filled (rgb 173 130 0) |> move (-55, -50)
  , roundedRect 5 1.5 1 |> filled (rgb 173 130 0) |> rotate (degrees 33) |> move (-42, -49)
  , roundedRect 20 1.5 1 |> filled (rgb 173 130 0) |> rotate (degrees -33) |> move (-48, -38)
  , roundedRect 1.5 6 1 |> filled (rgb 173 130 0) |> move (-40, -45.5)
  , roundedRect 1.5 6 1 |> filled (rgb 173 130 0) |> move (-56, -30.5)
  , roundedRect 5 1.5 1 |> filled (rgb 173 130 0) |> rotate (degrees 33) |> move (-54, -27)
  , roundedRect 60 1.5 1 |> filled (rgb 173 130 0) |> rotate (degrees -20) |> move (-25, -36)
  , oval 10 40 |> outlined (solid 1.5) black |> move (43, 70)
  , circle 20 |> outlined (solid 1) (rgb 146 39 26) |> move (-30, 80)
  , oval 10 40 |> outlined (solid 1.5) black  |> rotate (degrees 10) |> move (-65, 75)
  , oval 40 20 |> outlined (solid 1.5) (rgb 66 55 60) |> rotate (degrees 10) |> move (-10, 68)
  , roundedRect 40 1.5 1 |> filled (rgb 0 0 0) |> move (-48, -20)
  , roundedRect 45 1.5 1 |> filled (rgb 0 0 0) |> rotate (degrees -20) |> move (-8, -28)
  , roundedRect 50 1 1 |> filled (rgb 134 38 25) |> rotate (degrees -20) |> move (-44, 25)
  , roundedRect 30 1 1 |> filled (rgb 134 38 25) |> rotate (degrees -40) |> move (-56, 23)
  , roundedRect 35 1 1 |> filled (rgb 66 56 57) |> rotate (degrees -30) |> move (-53, 23)
  , roundedRect 40 1 1 |> filled (rgb 66 56 57) |> rotate (degrees -15) |> move (-49, 23)
  , roundedRect 20 1.5 1 |> filled black |> rotate (degrees -50) |> move (-62, 20)
  , roundedRect 60 1 1 |> filled (rgb 11 30 81) |> rotate (degrees 50) |> move (12, 20)
  , roundedRect 42 1 1 |> filled (rgb 11 30 81) |> rotate (degrees -70) |> move (0, -22)
  , roundedRect 1.5 20 1 |> filled black |> move (-33, -2)
  , roundedRect 1.5 20 1 |> filled black |> move (-23, -2)
  , roundedRect 45 1.5 1 |> filled black |> rotate (degrees -30) |> move (-4, -22)
  , roundedRect 53 1.5 1 |> filled black |> rotate (degrees -30) |> move (-10, -24)
  ]


init = {
    time = 0
    }

type Msg = Tick Float GetKeyState


update msg model =
    case msg of
       Tick t _ -> 
            { model | time = t }

main = gameApp Tick {
    model = init,
    view = view,
    update = update,
    title = "Unit Circle" 
    }


view model = collage 192 128 (myShapes model)
