module UpperEng exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)

myShapes _ = upperEng



preBorderLines = [

    ]


upperEng = [
        background
    , lines |> clip (polygon [(20,-0.75),(0.75,-20),(0.75,-93.75),(99.5,-93.75),(99.5,-0.75)]
        |> filled (rgb 111 105 98) |> move (-85, 39.5)) 
    , rect 60 36 |> filled (rgb 44 42 38) |> move (-40, -8) |> addOutline (solid 0.75) (rgb 12 21 21)
    , rect 60 8 |> filled (rgb 81 77 74) |> move (-40, 14) |> addOutline (solid 0.75) (rgb 12 21 21)
    , floor2
    , duplicate_x rail 8 10 |> move (-40, 44)
    , roundedRect 76 2 1 |> filled (rgb 197 161 83) |> move (-45, 28) |> addOutline (solid 0.75) (rgb 69 47 22)
    , engine_outline
    , engine
    , engine_shading |> clip (engine)
    , engine_detail
    , duplicate_x rail 10 6 |> move (-18, 0)
    , floor1
    , reactor_box
    , vent 4 32
    , walls
    , hall
    ]


background = group
  [
    rect 200 200 |> filled (rgb 60 74 74)
  , polygon [(20,0),(0,-20),(0,-110),(100,-110),(100,0)]
      |> filled (rgb 42 49 49) |> move (-83.25, 55) |> scale 1.05 |> addOutline (solid 1.5) (rgb 12 21 21)
  , polygon [(20,0),(0,-20),(0,-110),(100,-110),(100,0)]
      |> filled (rgb 111 105 98) |> move (-85, 55) |> addOutline (solid 1.5) (rgb 12 21 21)
  , rect 78.5 15 |> filled (rgb 127 122 106) |> move (-25, 46.5) |> addOutline (solid 1) (rgb 12 21 21)
  , polygon [(0,0),(0,15),(20,35),(20,20)] |> filled (rgb 127 122 106) |> move (-84, 20)  |> addOutline (solid 1) (rgb 12 21 21)
    
  ]
  
lines = group
  [
    rect 1 150 |> filled (rgb 80 77 69) |> move (12, 0)
  , rect 1 150 |> filled (rgb 80 77 69) |> move (-6, 0)
  , rect 1 150 |> filled (rgb 80 77 69) |> move (-24, 0)
  , rect 1 150 |> filled (rgb 80 77 69) |> move (-42, 0)
  , rect 1 150 |> filled (rgb 80 77 69) |> move (-60, 0)
  , rect 1 150 |> filled (rgb 80 77 69) |> move (-78, 0)
  , rect 150 1 |> filled (rgb 80 77 69) |> move (-20, 38)
  , rect 150 1 |> filled (rgb 80 77 69) |> move (-20, 22)
  , rect 150 1 |> filled (rgb 80 77 69) |> move (-20, 6)
  , rect 150 1 |> filled (rgb 80 77 69) |> move (-20, -10)
  , rect 150 1 |> filled (rgb 80 77 69) |> move (-20, -26)
  , rect 150 1 |> filled (rgb 80 77 69) |> move (-20, -42)
  ]

engine_outline = group
  [
    oval 30 50 |> outlined (solid 2) (rgb 12 21 21) |> move (-25, 0) 
  , rect 60 50 |> outlined (solid 2) (rgb 12 21 21) |> move (-54, 0)
  ]

engine = group
  [
    oval 30 50 |> filled (rgb 153 102 94) |> move (-25, 0) 
  , rect 60 50 |> filled (rgb 153 102 94) |> move (-54, 0) 
  ]
  
engine_detail = group
  [
    roundedRect 3 15 3 |> filled (rgb 24 212 218) |> move (-10, 0) |> addOutline (solid 1) (rgb 14 111 141)
  , roundedRect 1 8 1 |> filled (rgb 223 255 254) |> move (-9.75, 1.75)
  , rect 1.5 50 |> filled (rgb 237 250 249) |> move (-30, 0) |> addOutline (solid 0.5) (rgb 12 21 21)
  --, roundedRect 40 8 6 |> filled (rgb 89 81 73) |> move (-60, -13) |> addOutline (solid 0.5) (rgb 12 21 21)
  --, roundedRect 30 6 5 |> filled (rgb 89 81 73) |> move (-52, 25) |> addOutline (solid 0.5) (rgb 12 21 21)
  , rect 20 15 |> filled (rgb 56 81 81) |> move (-54, 12) |> addOutline (solid 0.5) (rgb 12 21 21)
  
  -- coil
  , roundedRect 2 12 2 |> filled (rgb 122 117 97) |> move (-54, 10) |> addOutline (solid 0.5) (rgb 72 57 44) |> clip (rect 20 15 |> filled (rgb 56 81 81) |> move (-54, 12))
  , roundedRect 2 12 2 |> filled (rgb 122 117 97) |> move (-56, 10) |> addOutline (solid 0.5) (rgb 72 57 44) |> clip (rect 20 15 |> filled (rgb 56 81 81) |> move (-54, 12))
  , roundedRect 2 12 2 |> filled (rgb 122 117 97) |> move (-58, 10) |> addOutline (solid 0.5) (rgb 72 57 44) |> clip (rect 20 15 |> filled (rgb 56 81 81) |> move (-54, 12))
  , roundedRect 2 12 2 |> filled (rgb 122 117 97) |> move (-60, 10) |> addOutline (solid 0.5) (rgb 72 57 44) |> clip (rect 20 15 |> filled (rgb 56 81 81) |> move (-54, 12))
  , roundedRect 2 12 2 |> filled (rgb 122 117 97) |> move (-52, 10) |> addOutline (solid 0.5) (rgb 72 57 44) |> clip (rect 20 15 |> filled (rgb 56 81 81) |> move (-54, 12))
  , roundedRect 2 12 2 |> filled (rgb 122 117 97) |> move (-50, 10) |> addOutline (solid 0.5) (rgb 72 57 44) |> clip (rect 20 15 |> filled (rgb 56 81 81) |> move (-54, 12))
  , roundedRect 2 12 2 |> filled (rgb 122 117 97) |> move (-48, 10) |> addOutline (solid 0.5) (rgb 72 57 44) |> clip (rect 20 15 |> filled (rgb 56 81 81) |> move (-54, 12))
  , roundedRect 2 12 2 |> filled (rgb 122 117 97) |> move (-46, 10) |> addOutline (solid 0.5) (rgb 72 57 44) |> clip (rect 20 15 |> filled (rgb 56 81 81) |> move (-54, 12))
  , roundedRect 2 12 2 |> filled (rgb 122 117 97) |> move (-62, 10) |> addOutline (solid 0.5) (rgb 72 57 44) |> clip (rect 20 15 |> filled (rgb 56 81 81) |> move (-54, 12))
  , roundedRect 2 12 2 |> filled (rgb 122 117 97) |> move (-64, 10) |> addOutline (solid 0.5) (rgb 72 57 44) |> clip (rect 20 15 |> filled (rgb 56 81 81) |> move (-54, 12))
  , roundedRect 2 12 2 |> filled (rgb 122 117 97) |> move (-44, 10) |> addOutline (solid 0.5) (rgb 72 57 44) |> clip (rect 20 15 |> filled (rgb 56 81 81) |> move (-54, 12))
  

  , roundedRect 15 60 10 |> filled (rgb 85 46 44) |> move (-78, -2) |> addOutline (solid 1) (rgb 12 21 21)
  , roundedRect 10 60 6 |> filled (rgb 115 69 69) |> move (-80, 0) |> addOutline (solid 1) (rgb 12 21 21)
  
  --, oval 15 5 |> filled (rgb 155 101 93) |> rotate (degrees 10) |> move(-25, -12) |> addOutline (solid 0.75) (rgb 12 21 21)
  --, oval 15 5 |> filled (rgb 155 101 93) |> rotate (degrees -10) |> move(-25, 15) |> addOutline (solid 0.75) (rgb 12 21 21)
  ]
  
engine_shading = group
  [
    rect 80 8 |> filled (rgb 115 69 69) |> move (-50, -22)
  , rect 30 8 |> filled (rgb 115 69 69) |> rotate (degrees 50)|> move (-20, -18)
  , oval 30 10 |> filled (rgb 205 168 160) |> rotate (degrees -45) |> move (-14.5, 7)
  , oval 30 10 |> filled (rgb 153 102 94) |> rotate (degrees -30) |> move (-20, 6.5)
  , oval 20 10 |> filled (rgb 153 102 94) |> rotate (degrees 36) |> move (-20, -11)
  , rect 60 5 |> filled (rgb 205 168 160) |> move (-54, 16)
  , rect 1 50 |> filled (rgb 12 21 21) |> move (-24, 0)
  ]

floor1 = group
  [
    rect 80 4 |> filled (rgb 181 127 52) |> move (-26.5, -31) |> addOutline (solid 1.5) (rgb 153 101 38)
  , rect 81 5 |> outlined (solid 0.75) (rgb 85 49 27) |> move (-26.5, -31)
  , roundedRect 70 2 1 |> filled (rgb 197 161 83) |> move (-42, -16) |> addOutline (solid 0.75) (rgb 69 47 22)
  , roundedRect 2 46 1 |> filled (rgb 197 161 83) |> move (-8, 6) |> addOutline (solid 0.75) (rgb 69 47 22)
  ]
  
floor2 = group
  [
    rect 80 4 |> filled (rgb 181 127 52) |> move (-26.5, 23) |> addOutline (solid 1.5) (rgb 153 101 38)
  , rect 81 5 |> outlined (solid 0.75) (rgb 85 49 27) |> move (-26.5, 23) 
  ]
  
rail = group
  [
    roundedRect 2 10 1 |> filled (rgb 180 125 68) |> move (-40, -21) |> addOutline (solid 0.75) (rgb 69 47 22)
  ]

reactor_box = group
  [
    rect 20 24 |> filled (rgb 70 95 93) |> move (-74.25, -22) |> addOutline (solid 0.75) (rgb 38 53 51)
  , rect 20 5 |> filled (rgb 95 125 121) |> move (-74.25, -12) |> addOutline (solid 0.75) (rgb 38 53 51)
  , rect 20 10 |> filled (rgb 123 156 152) |> move (-74.25, -5) |> addOutline (solid 0.75) (rgb 38 53 51)
  , rect 4 10 |> filled (rgb 95 125 121) |> move (-62, -13.5)
  , polygon [(0,0),(0,18),(5,21),(5,3)] |> filled (rgb 70 95 93) |> move (-64.25, -33.5) |> addOutline (solid 0.75) (rgb 38 53 51)
  , polygon [(0,0),(0,9),(5,6),(5,-3)] |> filled (rgb 95 125 121) |> move (-64.25, -9) |> addOutline (solid 0.75) (rgb 38 53 51)
  ]

vent x y = group
  [
    roundedRect 12 9 2 |> filled (rgb 148 168 173) |> addOutline (solid 1) (rgb 26 32 33) |> move (x, y)
  , roundedRect 10 0.5 1 |> filled (rgb 74 85 100) |> move (x, y - 2.5)
  , roundedRect 10 0.5 1 |> filled (rgb 74 85 100) |> move (x, y - 1)
  , roundedRect 10 0.5 1 |> filled (rgb 74 85 100) |> move (x, y + 0.5)
  , roundedRect 10 0.5 1 |> filled (rgb 74 85 100) |> move (x, y + 2)
  ]
  
walls = group
  [
    rect 10 15 |> filled (rgb 93 86 60) |> move (-60, 46.5) |> addOutline (solid 0.75) (rgb 12 21 21)
  , rect 10 15 |> filled (rgb 93 86 60) |> move (-25, 46.5) |> addOutline (solid 0.75) (rgb 12 21 21)
  ]
  
hall = group
  [
    rect 40 30 |> filled (rgb 81 77 72) |> move (-28,-69.75) |> addOutline (solid 1) (rgb 12 21 21)
  , rect 90 40 |> filled (rgb 126 150 157) |> move (60,-10) |> addOutline (solid 1) (rgb 12 21 21)
  , rect 90 2.5 |> filled (rgb 42 49 49) |> move (60, 24) |> addOutline (solid 1.5) (rgb 12 21 21)
  , rect 90 2.5 |> filled (rgb 42 49 49) |> move (60, -30) |> addOutline (solid 1.5) (rgb 12 21 21)
  , rect 90 15 |> filled (rgb 76 119 130) |> move (60, 15) |> addOutline (solid 1) (rgb 12 21 21)
  , rect 2.5 40 |> filled (rgb 42 49 49) |> move (-49.5, -75) |> addOutline (solid 1.5) (rgb 12 21 21)
  , rect 2.5 40 |> filled (rgb 42 49 49) |> move (-6.25, -75) |> addOutline (solid 1.5) (rgb 12 21 21)
  ]

-- will duplicate a shape (or group of shapes) along the same x-axis
duplicate_x shape spacing ammount = 
    List.map (\ idx -> shape |> move (spacing * toFloat idx, 0))
         (List.range 0 (ammount - 1))
      |> group
