module Reactor exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.EllieApp exposing (..)

-- Your shapes go here!
myShapes _ =
  [
      reactorRoom
  ]



preBorderLines = [
  ((68,65),(68,-8)),
  ((68,-8),(18,-8)),
  ((18,-8), (18,22)),
  ((18,22), (-20,22)),
  ((-20,22), (-20,57)),
  ((-20,57), (-42,57)),
  ((-42,57), (-42,45)),
  ((-42,45), (-70,28)),
  ((-70,28), (-70,22)),
  ((-70,22), (-50,22)),
  ((-50,22), (-50,-12)),
  ((-50,-12), (-47,-14)),
  ((-47,-14), (-47,-30)),
  ((-47,-30), (-41,-30)),
  ((-41,-30), (-41,-37)),
  ((-41,-37), (-72,-37)),
  ((-72,-37), (-72,-62)),
  ((-72,-62), (17,-62)),
  ((17,-62), (17,-50)),
  ((17,-50), (68,-50)),
  ((68,-50), (68,-70))
    ]


reactorRoom = [
    rect 200 200 |> filled (rgb 58 73 73)
  , floors
  , lines |> clip floors
  , circle 80 |> filled (rgb 102 97 135) |> move (-90, -40) |> clip floors
  , circle 80 |> filled (rgb 71 65 105) |> move (-90, -40) |> clip lines
  , rect 52 30 |> filled (rgb 90 86 112) |> move (-6, -38) |> addOutline (solid 1) (rgb 42 42 60)
  , circle 80 |> filled (rgb 125 125 156) |> move (-90, -40) |> clip (rect 52 30 |> filled (rgb 90 86 112) |> move (-6, -38) |> addOutline (solid 1) (rgb 42 42 60))
  , floor_detail
  , wall_outline
  , vent -50 22
  , wall
  , pipe
  , reactor
  , wall_detail
  , hall
  , tasks
    ]

floors = group 
  [
    polygon [(0,0),(0,100),(40,125),(70,125),(70,90),(110,90),(110,0)]
      |> filled (rgb 65 61 92)
      |> move (-90, -65)
  ]
  
lines = group
  [
    rect 1.5 200 |> filled (rgb 52 44 85) |> move (20, 0)
  , rect 1.5 200 |> filled (rgb 52 44 85) |> move (-10, 0)
  , rect 1.5 200 |> filled (rgb 52 44 85) |> move (-40, 0)
  , rect 1.5 200 |> filled (rgb 52 44 85) |> move (-70, 0)
  , rect 200 1.5 |> filled (rgb 52 44 85) |> move (0, 30)
  , rect 200 1.5 |> filled (rgb 52 44 85) |> move (0, 0)
  , rect 200 1.5 |> filled (rgb 52 44 85) |> move (0, -30)
  , rect 200 1.5 |> filled (rgb 52 44 85) |> move (0, -60)
  ]

wall_outline = group
  [
    rect 4 110 |> filled (rgb 44 44 44) |> move (20, -30) |> addOutline (solid 1.5) (rgb 12 21 21)
  , rect 41.5 4 |> filled (rgb 44 44 44) |> move (1.25, 27) |> addOutline (solid 1.5) (rgb 12 21 21)
  , rect 4 34.5 |> filled (rgb 44 44 44) |> move (-17.5, 42.25) |> addOutline (solid 1.5) (rgb 12 21 21)
  , rect 47.5 4 |> filled (rgb 44 44 44) |> rotate (degrees 32) |> move (-70.5, 50.5) |> addOutline (solid 1.5) (rgb 12 21 21)
  , rect 34.5 4 |> filled (rgb 44 44 44) |> move (-32.75, 62.25) |> addOutline (solid 1.5) (rgb 12 21 21)
  , rect 4 110 |> filled (rgb 44 44 44) |> move (-89.75, -15.75) |> addOutline (solid 1.5) (rgb 12 21 21)
  ]
  
floor_detail = group
  [
    polygon [(0,-40),(0,85),(30,50),(30,10)]
      |> filled (rgb 103 98 137)
      |> move (-62, -70)
      |> addOutline (solid 1) (rgb 42 42 60)
  , polygon [(0,-40),(0,85),(30,50),(30,10)]
      |> filled (rgb 121 121 151)
      |> move (-67, -70)
      |> addOutline (solid 1) (rgb 42 42 60)
  , rect 22 90 |> filled (rgb 121 121 151) |> move (-77, -30)
  , rect 5 30 |> filled (rgb 121 121 151) |> move (-34.5, -40) |> addOutline (solid 1) (rgb 42 42 60)
  , rect 52 30 |> outlined (solid 1) (rgb 42 42 60) |> move (-6, -38)
  , roundedRect 40 2 2 |> filled (rgb 31 163 177) |> move (-3, -20) |>addOutline (solid 1) (rgb 12 83 118)
  , roundedRect 40 2 2 |> filled (rgb 31 163 177) |> move (-3, -56) |>addOutline (solid 1) (rgb 12 83 118)
  ]
  
vent x y = group
  [
    roundedRect 12 9 2 |> filled (rgb 103 126 127) |> addOutline (solid 1) (rgb 26 32 33) |> move (x, y)
  , roundedRect 10 0.5 1 |> filled (rgb 74 85 100) |> move (x, y - 2.5)
  , roundedRect 10 0.5 1 |> filled (rgb 74 85 100) |> move (x, y - 1)
  , roundedRect 10 0.5 1 |> filled (rgb 74 85 100) |> move (x, y + 0.5)
  , roundedRect 10 0.5 1 |> filled (rgb 74 85 100) |> move (x, y + 2)
  ]
  
pipe = group
  [
    roundedRect 15 110 8 |> filled (rgb 46 55 92) |> move (-80, -25) |> addOutline (solid 1) (rgb 26 32 33)
  , roundedRect 15 50 8 |> filled (rgb 46 55 92)  |> rotate (degrees -57.5) |> move (-65, 33) |> addOutline (solid 1) (rgb 26 32 33)
  , roundedRect 14 20 8 |> filled (rgb 46 55 92) |> move (-80, 20)
  , roundedRect 9 50 5 |> filled (rgb 68 76 110) |> move (-79, 0)
  , roundedRect 9 35 5 |> filled (rgb 68 76 110) |> rotate (degrees -57.5) |> move (-68, 30)
  ]
  
reactor = group
  [
    oval 40 15 |> filled (rgb 90 105 135) |> move (-67, -40) |> addOutline (solid 1) (rgb 26 32 33)
  , rect 40 20 |> filled (rgb 90 105 135) |> move (-67, -30) |> addOutline (solid 1) (rgb 26 32 33)
  , rect 39 20 |> filled (rgb 90 105 135) |> move (-67, -31)
  , rect 14 12 |> filled (rgb 47 55 93) |> move (-75, -41)
  , rect 14 20 |> filled (rgb 47 55 93) |> move (-79.75, -32)
  , roundedRect 5 35 3 |> filled (rgb 243 249 249) |> move (-52, 0) |> addOutline (solid 1) (rgb 145 189 210)
  , oval 40 15 |> filled (rgb 47 55 93) |> move (-67, -20) |> addOutline (solid 1) (rgb 26 32 33)
  , roundedRect 15 50 8 |> filled (rgb 46 55 92) |> move (-80, -60) |> addOutline (solid 1) (rgb 26 32 33)
  , roundedRect 9 50 5 |> filled (rgb 68 76 110) |> move (-79, -65)
  , oval 32 10 |> filled (rgb 88 103 133) |> move (-67, -17) |> addOutline (solid 1) (rgb 26 32 33)
  , rect 32 30 |> filled (rgb 88 103 133) |> move (-67, -2) |> addOutline (solid 1) (rgb 26 32 33)
  , rect 31 30 |> filled (rgb 88 103 133) |> move (-67, -3)
  , oval 32 10 |> filled (rgb 88 103 133) |> move (-67, 13) |> addOutline (solid 1) (rgb 26 32 33)
  , oval 20 6 |> filled (rgb 80 48 96) |> move (-67,15) |> addOutline (solid 1) (rgb 26 32 33)
  , roundedRect 6 35 3 |> filled (rgb 243 249 249) |> move (-75, -5) |> addOutline (solid 1) (rgb 145 189 210)
  , roundedRect 5 35 3 |> filled (rgb 243 249 249) |> move (-85, -2) |> addOutline (solid 1) (rgb 145 189 210)
  , roundedRect 6 35 3 |> filled (rgb 243 249 249) |> move (-60, -5) |> addOutline (solid 1) (rgb 145 189 210)
  , oval 20 6 |> filled (rgb 80 48 96) |> move (-67,15) 
  , oval 8 15 |> filled (rgb 51 60 100) |> rotate (degrees 90) |> move (-67, 16) |> addOutline (solid 0.75) (rgb 26 32 33)
  , roundedRect 2 20 2|> filled (rgb 81 98 118) |> move (-67.5, -12) |> addOutline (solid 1) (rgb 26 32 33)
  , roundedRect 1 20 2|> filled (rgb 81 98 118) |> move (-80.5, -9) |> addOutline (solid 0.75) (rgb 26 32 33)
  , roundedRect 2 20 2|> filled (rgb 81 98 118) |> move (-51.5, -9) |> addOutline (solid 1) (rgb 26 32 33)
  ]
  
wall = group
  [
    polygon [(0,0),(0,10),(37,33),(37,23)] |> filled (rgb 85 78 139) |> move (-87, 27) |> addOutline (solid 1) (rgb 26 32 33)
  , rect 30 12 |> filled (rgb 85 78 139) |> move (-34.75, 53.75) |> addOutline (solid 1) (rgb 26 32 33)
  , rect 38 12 |> filled (rgb 85 78 139) |> move (-1, 18.5) |> addOutline (solid 1) (rgb 26 32 33)
  ]
  
wall_detail = group
  [
    rect 10 5 |> filled (rgb 148 162 168) |> move (-1, 18) |> addOutline (solid 0.75) (rgb 26 32 33)
  , rect 8 8 |> filled (rgb 93 96 106) |> move (-30, 54) |> addOutline (solid 0.75) (rgb 26 32 33)
  , circle 2.5 |> filled (rgb 30 115 110) |> move (-30, 54) |> addOutline (solid 0.75) (rgb 19 67 63)
  ]
  
hall = group
  [
    rect 90 40 |> filled (rgb 81 77 72) |> move (62.5, -38) |> addOutline (solid 1) (rgb 27 31 27)
  , rect 40 200 |> filled (rgb 81 77 72) |> move (87.5, -20) |> addOutline (solid 1) (rgb 27 31 27)
  , rect 90 40 |> filled (rgb 81 77 72) |> move (63.5, -38)
  , rect 50 15 |> filled (rgb 99 94 83) |> move (42.5, -10.5) |> addOutline (solid 1) (rgb 27 31 27)
  , rect 50 4 |> filled (rgb 44 44 44) |> move (42.75, -0.5) |> addOutline (solid 1.5) (rgb 12 21 21)
  , rect 4 80 |> filled (rgb 44 44 44) |> move (66, 38) |> addOutline (solid 1.5) (rgb 12 21 21)
  , rect 4 80 |> filled (rgb 44 44 44) |> move (66, -99) |> addOutline (solid 1.5) (rgb 12 21 21)
  , rect 50 4 |> filled (rgb 44 44 44) |> move (42.75, -55.5) |> addOutline (solid 1.5) (rgb 12 21 21)
  ]

tasks = group
  [
    rect 10 4 |> filled (rgb 87 112 129) |> rotate (degrees 32) |> move (-60, 33) |> addOutline (solid 1) (rgb 12 21 21)
  , square 10 |> filled (rgb 79 87 127) |> move (-46, -38) |> addOutline (solid 1) (rgb 12 21 21)
  ]
  
  