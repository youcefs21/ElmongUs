module Admin exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.EllieApp exposing (..)




preBorderLines = [

    ]


-- wire_box model used in various rooms
wire_box = group [rectangle 8 6
   |> filled (rgb 144 148 151)
   |> addOutline (solid 0.5) black,
   rightTriangle 3 1.5
   |> filled (rgb 83 87 90) |> rotate (degrees 90) |> move (0, -0.5),
   rightTriangle 3 1.5
   |> filled (rgb 83 87 90) |> rotate (degrees 270) |> move (0, 0.5),
   rectangle 2.5 0.5
   |> filled (rgb 83 87 90)]
   
-- Vent code used in various rooms
vent x y = group
  [
    roundedRect 12 9 2 |> filled (rgb 103 126 127) |> addOutline (solid 1) (rgb 26 32 33) |> move (x, y)
  , roundedRect 10 0.5 1 |> filled (rgb 74 85 100) |> move (x, y - 2.5)
  , roundedRect 10 0.5 1 |> filled (rgb 74 85 100) |> move (x, y - 1)
  , roundedRect 10 0.5 1 |> filled (rgb 74 85 100) |> move (x, y + 0.5)
  , roundedRect 10 0.5 1 |> filled (rgb 74 85 100) |> move (x, y + 2)
  ]
  
-- Admin
admin = group [admin_walls,
   admin_top,
   vent -20 -68
   |> scale 0.8,
   admin_interior,
   wire_box
   |> move (-42, 36)
   ]
   
admin_interior = group [rectangle 8 6
   |> filled (rgb 80 87 95) |> move (-16, 36)
   |> addOutline (solid 0.8) black,
   rectangle 4 1
   |> filled black |> move (-16, 36),
   rectangle 99.5 2
   |> filled (rgb 121 81 90) |> addOutline (solid 0.8) (rgb 103 65 76)
   |> move (24.5, 6),
   rectangle 99.5 2
   |> filled (rgb 121 81 90) |> addOutline (solid 0.8) (rgb 103 65 76)
   |> move (24.5, -26),
   rectangle 2 88.5
   |> filled (rgb 121 81 90) |> addOutline (solid 0.8) (rgb 103 65 76)
   |> move (-5, -16.5),
   rectangle 2 88.5
   |> filled (rgb 121 81 90) |> addOutline (solid 0.8) (rgb 103 65 76)
   |> move (15, -16.5),
   rectangle 2 88.5
   |> filled (rgb 121 81 90) |> addOutline (solid 0.8) (rgb 103 65 76)
   |> move (35, -16.5),
   rectangle 2 84.5
   |> filled (rgb 121 81 90) |> addOutline (solid 0.8) (rgb 103 65 76)
   |> move (55, -14.5),
   rectangle 20 20
   |> filled (rgb 61 74 71) |> move (25, -12)
   |> addOutline (solid 0.5) black,
   rectangle 50 20
   |> filled (rgb 57 75 71) |> move (25, -10)
   |> addOutline (solid 0.5) black,
   rectangle 50 20
   |> filled (rgb 94 122 106) |> move (25, -8)
   |> addOutline (solid 0.5) black,
   rectangle 30 14
   |> filled (rgb 60 169 104) |> move (25, -8)
   |> addOutline (solid 0.5) black,
   rectangle 4 14
   |> filled (rgb 137 170 147) |> move (3, -8)
   |> addOutline (solid 0.5) black,
   rectangle 4 14
   |> filled (rgb 137 170 147) |> move (47, -8)
   |> addOutline (solid 0.5) black,
   rectangle 4 4
   |> filled (rgb 162 181 172) |> move (47, -3)
   |> addOutline (solid 0.5) black,
   rectangle 8 8
   |> filled (rgb 103 20 40) |> move (47, -39)
   |> addOutline (solid 0.5) black,
   rectangle 8 8
   |> filled (rgb 103 20 40) |> move (47, -47)
   |> addOutline (solid 0.5) black,
   rectangle 8 8
   |> filled (rgb 141 38 63) |> move (49, -39)
   |> addOutline (solid 0.5) black,
   rectangle 8 8
   |> filled (rgb 141 38 63) |> move (49, -47)
   |> addOutline (solid 0.5) black,
   rectangle 8 8
   |> filled (rgb 141 38 63) |> move (49, -55)
   |> addOutline (solid 0.5) black,
   rectangle 8 8
   |> filled (rgb 141 38 63) |> move (41, -55)
   |> addOutline (solid 0.5) black,
   rectangle 8 8
   |> filled (rgb 141 38 63) |> move (33, -55)
   |> addOutline (solid 0.5) black,
   rectangle 8 8
   |> filled (rgb 141 38 63) |> move (25, -55)
   |> addOutline (solid 0.5) black,
   rectangle 8 8
   |> filled (rgb 141 38 63) |> move (17, -55)
   |> addOutline (solid 0.5) black,
   rectangle 8 8
   |> filled (rgb 141 38 63) |> move (9, -55)
   |> addOutline (solid 0.5) black]

admin_top = group [rectangle 14 10
   |> filled (rgb 63 71 73)|> move (5, 37)
   |> addOutline (solid 0.5) black,
   rectangle 14 10
   |> filled (rgb 63 71 73)|> move (25, 37)
   |> addOutline (solid 0.5) black,
   rectangle 14 10
   |> filled (rgb 63 71 73)|> move (45, 37)
   |> addOutline (solid 0.5) black,
   rectangle 12 8
   |> filled (rgb 76 217 63) |> move (5, 37)
   |> addOutline (solid 0.5) black,
   rectangle 12 8
   |> filled (rgb 76 217 63) |> move (25, 37)
   |> addOutline (solid 0.5) black,
   rectangle 12 8
   |> filled (rgb 76 217 63) |> move (45, 37)
   |> addOutline (solid 0.5) black,
   rectangle 2 18
   |> filled (rgb 44 48 48) |> move (-5, 37) 
   |> addOutline (solid 1) black,
   rectangle 2 18
   |> filled (rgb 44 48 48) |> move (15, 37) 
   |> addOutline (solid 1) black,
   rectangle 2 18
   |> filled (rgb 44 48 48) |> move (35, 37) 
   |> addOutline (solid 1) black,
   rectangle 2 18
   |> filled (rgb 44 48 48) |> move (55, 37) 
   |> addOutline (solid 1) black,
   admin_chair
   |> addOutline (solid 0.5) black |> move (5, 28),
   admin_chair
   |> addOutline (solid 0.5) black |> move (25, 28),
   admin_chair
   |> addOutline (solid 0.5) black |> move (45, 28)]
   
admin_chair = group [wedge 5 0.5
   |> filled (rgb 141 38 63) |> rotate (degrees 90),
   rectangle 10 8
   |> filled (rgb 141 38 63)
   |> move (0, -4),
   rectangle 10 2
   |> filled (rgb 103 20 40) |> move (0, -8)
   |> addOutline (solid 0.5) black,
   rectangle 2 2
   |> filled (rgb 103 20 40) |> move (-4, -10),
   rectangle 2 2
   |> filled (rgb 103 20 40) |> move (4, -10)]
   
admin_walls = group [rectangle 200 200 
   |> filled (rgb 60 73 74),
   rectangle 2 200
   |> filled (rgb 44 48 48) |> move (-85, 0) 
   |> addOutline (solid 1) black,
   rectangle 2 50
   |> filled (rgb 44 48 48) |> move (-55, 70) 
   |> addOutline (solid 1) black,
   rectangle 2 70
   |> filled (rgb 44 48 48) |> move (-55, -28) 
   |> addOutline (solid 1) black,
   rectangle 130 2
   |> filled (rgb 44 48 48) |> move (9, 45) 
   |> addOutline (solid 1) black,
   rectangle 30 2
   |> filled (rgb 44 48 48) |> move (-41, 8) 
   |> addOutline (solid 1) black,
   rectangle 2 70
   |> filled (rgb 44 48 48) |> move (-27, -28) 
   |> addOutline (solid 1) black,
   rectangle 80 2
   |> filled (rgb 44 48 48) |> move (14, -62) 
   |> addOutline (solid 1) black,
   rectangle 2 86
   |> filled (rgb 44 48 48) |> move (76, 3) 
   |> addOutline (solid 1) black,
   rectangle 2 33
   |> filled (rgb 44 48 48) |> rotate (degrees 135)
   |> move (64, -51) |> addOutline (solid 1) black,
   rectangle 131 15
   |> filled (rgb 109 130 142) |> move (9, 36) 
   |> addOutline (solid 0.5) black,
   rectangle 26 150
   |> filled (rgb 132 162 170) |> move (-70, 0),
   rectangle 38 18
   |> filled (rgb 132 162 170) |> move (-45, 19),
   rectangle 78 89
   |> filled (rgb 121 81 90) |> move (13.5, -16.5),
   rectangle 30 66
   |> filled (rgb 121 81 90) |> move (59.5, -5),
   rightTriangle 22 23
   |> filled (rgb 121 81 90) |> rotate (degrees 270) |> move (52.5, -38)]