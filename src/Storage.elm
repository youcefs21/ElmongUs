module Storage exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)



preBorderLines = [

    ]

-- Storages
storage = group [storage_walls, storage_interior]

storage_interior = group [rectangle 50 25
   |> filled (rgb 131 96 96) |> move (25, -7.5)
   |> addOutline (solid 0.5) black,
   rectangle 50 15
   |> filled (rgb 111 68 79) |> move (25, 10)
   |> addOutline (solid 0.5) black,
   rectangle 30 32
   |> filled (rgb 93 127 110) |> move (15, -25)
   |> addOutline (solid 0.5) black,
   rectangle 30 15
   |> filled (rgb 62 102 93) |> move (15, -10)
   |>addOutline (solid 0.5) black,
   rectangle 20 20
   |> filled (rgb 70 108 129) |> move (-10, -15)
   |> addOutline (solid 0.5) black,
   rectangle 20 12
   |> filled (rgb 56 75 99) |> move (-10, 0)
   |> addOutline (solid 0.5) black,
   oil_can
   |> addOutline (solid 0.5) black,
   wire_box
   |> move (6, 42)]
   
oil_can = group [ wedge 4 0.5
   |> filled (rgb 175 33 73) |> rotate (degrees 90) |> move (-10, -27),
   rectangle 8 6
   |> filled (rgb 175 33 73) |> move (-10, -29.5),
   rectangle 1 2
   |> filled black |> rotate (degrees 45)|> move (-13, -23),
   rectangle 6 0.5
   |> filled black |> rotate (degrees 45)|> move (-10, -28),
   rectangle 6 0.5
   |> filled black |> rotate (degrees 135)|> move (-10, -28)
   ]
   
storage_walls = group [
   rectangle 200 200 
   |> filled (rgb 60 73 74),
   rectangle 132 75
   |> filled (rgb 93 102 108) |> move (17, -3),
   rectangle 90 30
   |> filled (rgb 93 102 108) |> move (38, -50),
   rightTriangle 42 20
   |> filled (rgb 93 102 108) |> rotate (degrees 180) |> move (-7, -40),
   rectangle 2 90
   |> filled (rgb 116 123 104) |> move (-20, -9.5)
   |> addOutline (solid 0.3) black,
   rectangle 2 95
   |> filled (rgb 116 123 104) |> move (16, -13)
   |> addOutline (solid 0.3) black,
   rectangle 2 95
   |> filled (rgb 116 123 104) |> move (57, -13)
   |> addOutline (solid 0.3) black,
   rectangle 135 2
   |> filled (rgb 116 123 104) |> move (18, 0)
   |> addOutline (solid 0.3) black,
   rectangle 135 2
   |> filled (rgb 116 123 104) |> move (18, -35)
   |> addOutline (solid 0.3) black,
   rectangle 2 120
   |> filled (rgb 44 48 48) |> move (85, -10) 
   |> addOutline (solid 1) black,
   rectangle 30 2
   |> filled (rgb 44 48 48) |> move (71, 51) 
   |> addOutline (solid 1) black,
   rectangle 27.5 16
   |> filled (rgb 130 134 137) |> move (69.5, 42) 
   |> addOutline (solid 0.5) black,
   rectangle 25 10
   |> filled (rgb 130 134 137) |> rotate (degrees 45)
   |> move (-39.25, 38),
   rectangle 25 5
   |> filled (rgb 130 134 137) |> rotate (degrees 45)
   |> move (-41, 33),
   rectangle 25 0.15
   |> filled black |> rotate (degrees 45)
   |> move (-41, 29.5)
   |> addOutline (solid 0.5) black,
   rectangle 53.5 16
   |> filled (rgb 130 134 137) |> move (-9.5, 42) 
   |> addOutline (solid 0.5) black,
   rectangle 2 12
   |> filled (rgb 44 48 48) |> move (57, 58) 
   |> addOutline (solid 1) black,
   rectangle 2 14
   |> filled (rgb 44 48 48) |> move (16, 57) 
   |> addOutline (solid 1) black,
   rectangle 20 2
   |> filled (rgb 44 48 48) |> rotate (degrees 45)
   |> move (-43, 44) 
   |> addOutline (solid 1) black,
   rectangle 90 2
   |> filled (rgb 44 48 48) |> move (40, -62) 
   |> addOutline (solid 1) black,
   rectangle 51 2
   |> filled (rgb 44 48 48) |> move (-11, 51) 
   |> addOutline (solid 1) black,
   rectangle 50 2
   |> filled (rgb 44 48 48) |> move (-75, -41.5) 
   |> addOutline (solid 1) black,
   rectangle 50 2
   |> filled (rgb 44 48 48) |> move (-75, -14) 
   |> addOutline (solid 1) black,
   rectangle 50 2
   |> filled (rgb 44 48 48) |> rotate (degrees 155)
   |> move (-28, -52) 
   |> addOutline (solid 1) black,
   rectangle 2 52
   |> filled (rgb 44 48 48) |> move (-50, 11) 
   |> addOutline (solid 1) black,
   rectangle 2 4
   |> filled black |> move (59, -59),
   rectangle 2 4
   |> filled yellow |> move (59, -55),
   rectangle 2 4
   |> filled black |> move (59, -51),
   rectangle 2 4
   |> filled yellow |> move (59, -47),
   rectangle 2 4
   |> filled black |> move (59, -43),
   rectangle 2 4
   |> filled yellow |> move (59, -39),
   rectangle 2 4
   |> filled black |> move (83, -59),
   rectangle 2 4
   |> filled yellow |> move (83, -55),
   rectangle 2 4
   |> filled black |> move (83, -51),
   rectangle 2 4
   |> filled yellow |> move (83, -47),
   rectangle 2 4
   |> filled black |> move (83, -43),
   rectangle 2 4
   |> filled yellow |> move (83, -39),
   rectangle 4 2 
   |> filled black |> move (60, -37),
   rectangle 4 2 
   |> filled yellow |> move (64, -37),
   rectangle 4 2 
   |> filled black |> move (68, -37),
   rectangle 6 2 
   |> filled yellow |> move (72, -37),
   rectangle 4 2 
   |> filled black |> move (76, -37),
   rectangle 4 2 
   |> filled yellow |> move (80, -37),
   rectangle 4 2 
   |> filled black |> move (84, -37),
   rectangle 22 22.75
   |> filled (rgb 69 81 88) |> move (71, -49.5),
   rectangle 60 24
   |> filled (rgb 134 163 171) |> move (-79, -28),
   rectangle 38 30
   |> filled (rgb 134 163 171) |> move (36.5, 50),
   rectangle 60 10
   |> filled (rgb 60 110 119) |> move (-79, -21)
   |> addOutline (solid 0.5) black
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