module MedBay exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.EllieApp exposing (..)




preBorderLines = [

  -- top and bottom
--   ((-45,53), (45, 53)),
--   ((-50,-60), (50, -60))

  ]



-- Vent code used in various rooms
vent x y = group
  [
    roundedRect 12 9 2 |> filled (rgb 103 126 127) |> addOutline (solid 1) (rgb 26 32 33) |> move (x, y)
  , roundedRect 10 0.5 1 |> filled (rgb 74 85 100) |> move (x, y - 2.5)
  , roundedRect 10 0.5 1 |> filled (rgb 74 85 100) |> move (x, y - 1)
  , roundedRect 10 0.5 1 |> filled (rgb 74 85 100) |> move (x, y + 0.5)
  , roundedRect 10 0.5 1 |> filled (rgb 74 85 100) |> move (x, y + 2)
  ]

-- Medbay
medbay = group [medbay_room |> move (0, -12), medbay_hallway]

medbay_room = group [medbay_walls,
   medbay_floor,
   hospital_sign
   |> move (-25, 27) |> addOutline (solid 0.8) black,
   hospital_sign
   |> move (25, 27) |> addOutline (solid 0.8) black,
   medbay_beds,
   scanner,
   vent -25 60
   |> rotate (degrees 90)|> scale 0.8
   ]

scanner = group [circle 10
   |> filled (rgb 122 140 145) |> move (40, -38)
   |> addOutline (solid 0.5) black,
   circle 8
   |> filled (rgb 116 197 104) |> move (40, -38)
   |> addOutline (solid 0.5) black,
   circle 6
   |> filled (rgb 103 186 89) |> move (40, -38)
   |> addOutline (solid 0.5) black,
   circle 4
   |> filled (rgb 116 197 104) |> move (40, -38)
   |> addOutline (solid 0.5) black,
   circle 2
   |> filled (rgb 103 186 89) |> move (40, -38)
   |> addOutline (solid 0.5) black
   ]
   
medbay_hallway = group [rectangle 200 30
   |> filled (rgb 133 164 172) |> move (0, 50),
   rectangle 31 28
   |> filled (rgb 133 164 172) |> move (0, 23),
   rectangle 200 2 
   |> filled (rgb 44 48 48) |> move (0, 63) 
   |> addOutline (solid 1) black,
   rectangle 80 2 
   |> filled (rgb 44 48 48) |> move (-56, 34)
   |> addOutline (solid 1) black,
   rectangle 80 2 
   |> filled (rgb 44 48 48) |> move (56, 34)
   |> addOutline (solid 1) black,
   rectangle 2 10
   |> filled (rgb 44 48 48) |> move (-17, 27)
   |> addOutline (solid 1) black,
   rectangle 2 10
   |> filled (rgb 44 48 48) |> move (17, 27)
   |> addOutline (solid 1) black
   ]
   
medbay_beds = group [rectangle 31 12
   |> filled (rgb 38 111 167) |> move (-38, 12)
   |> addOutline (solid 0.5) black,
   rectangle 31 1
   |> filled (rgb 152 184 192) |> move (-38, 6)
   |> addOutline (solid 0.5) black,
   rectangle 30 10
   |> filled (rgb 43 139 194) |> move (-38, 13)
   |> addOutline (solid 0.5) black,
   rectangle 6 8
   |> filled white |> move (-49, 13)
   |> addOutline (solid 0.5) black,
   rectangle 31 12
   |> filled (rgb 38 111 167) |> move (-38, -5)
   |> addOutline (solid 0.5) black,
   rectangle 31 1
   |> filled (rgb 152 184 192) |> move (-38, -11)
   |> addOutline (solid 0.5) black,
   rectangle 30 10
   |> filled (rgb 43 139 194) |> move (-38, -4)
   |> addOutline (solid 0.5) black,
   rectangle 6 8
   |> filled white |> move (-49, -4)
   |> addOutline (solid 0.5) black,
   rectangle 31 12
   |> filled (rgb 38 111 167) |> move (38, 12)
   |> addOutline (solid 0.5) black,
   rectangle 31 1
   |> filled (rgb 152 184 192) |> move (38, 6)
   |> addOutline (solid 0.5) black,
   rectangle 30 10
   |> filled (rgb 43 139 194) |> move (38, 13)
   |> addOutline (solid 0.5) black,
   rectangle 6 8
   |> filled white |> move (49, 13)
   |> addOutline (solid 0.5) black,
   rectangle 31 12
   |> filled (rgb 38 111 167) |> move (38, -5)
   |> addOutline (solid 0.5) black,
   rectangle 31 1
   |> filled (rgb 152 184 192) |> move (38, -11)
   |> addOutline (solid 0.5) black,
   rectangle 30 10
   |> filled (rgb 43 139 194) |> move (38, -4)
   |> addOutline (solid 0.5) black,
   rectangle 6 8
   |> filled white |> move (49, -4)
   |> addOutline (solid 0.5) black
   ]
   
hospital_sign = group [rectangle 2 6
   |> filled (rgb 212 69 47),
   rectangle 6 2
   |> filled (rgb 212 69 47)
   ]
   
medbay_floor = group [rectangle 107 48
   |> filled (rgb 136 155 161) |> move (0, -5.5),
   rectangle 31 2
   |> filled (rgb 49 67 75) |> move (0, 19.5)
   |> addOutline (solid 0.8) black,
   rectangle 87 20.5
   |> filled (rgb 136 155 161) |> move (10, -38.5),
   rightTriangle 20.5 20.5
   |> filled (rgb 136 155 161) |> move (33, 28.75)
   |> rotate (degrees 180),
   rectangle 2 67
   |> filled (rgb 186 205 211) |> move (-17, -15)
   |> addOutline (solid 0.5) black,
   rectangle 1 68
   |> filled black |> move (0, -15),
   rectangle 1 68
   |> filled black |> move (-16, -15),
   rectangle 1 68
   |> filled black |> move (16, -15),
   rectangle 31 0.5
   |> filled black |> move (0, 10),
   rectangle 31 0.5
   |> filled black |> move (0, 0),
   rectangle 31 0.5
   |> filled black |> move (0, -10),
   rectangle 31 0.5
   |> filled black |> move (0, -20),
   rectangle 31 0.5
   |> filled black |> move (0, -30),
   rectangle 31 0.5
   |> filled black |> move (0, -40),
   rectangle 31 0.5
   |> filled black |> move (0, -49),
   rectangle 2 67
   |> filled (rgb 186 205 211) |> move (17, -15)
   |> addOutline (solid 0.5) black
   ]
   
medbay_walls = group [rectangle 200 200 
    |> filled (rgb 60 73 74),       
   rectangle 40 2 
   |> filled (rgb 44 48 48) |> move (36, 32)
   |> addOutline (solid 1) black,
   rectangle 40 2 
   |> filled (rgb 44 48 48) |> move (-36, 32)
   |> addOutline (solid 1) black,
   rectangle 2 60
   |> filled (rgb 44 48 48) |> move (-55, 0)
   |> addOutline (solid 1) black,
   rectangle 2 40
   |> filled (rgb 44 48 48) |> move (55, 13)
   |> addOutline (solid 1) black,
   rectangle 2 30
   |> filled (rgb 44 48 48) |> move (34, -59)
   |> addOutline (solid 1) black
   |> rotate (degrees 45),
   rectangle 2 30
   |> filled (rgb 44 48 48) |> move (-60, 3)
   |> addOutline (solid 1) black
   |> rotate (degrees 45),
   rectangle 108 2 
   |> filled (rgb 44 48 48) |> move (20, -50.5)
   |> addOutline (solid 1) black,
   rectangle 2 24
   |> filled (rgb 44 48 48) |> move (76, -39.5)
   |> addOutline (solid 1) black,
   rectangle 38 8
   |> filled (rgb 180 210 213) |> addOutline (solid 0.8) black
   |> move (35, 27),
   rectangle 38 8
   |> filled (rgb 180 210 213) |> addOutline (solid 0.8) black
   |> move (-35, 27),
   rectangle 50 20.5
   |> filled (rgb 136 155 161) |> move (50, -38.5),
   rightTriangle 20 20
   |> filled (rgb 180 210 213) |> move (54, -28),
   rightTriangle 20 14
   |> filled (rgb 180 210 213) |> move (-74, 28) 
   |> rotate (degrees 180),
   rectangle 1 21
   |> filled black |> move (54, -18),
   rectangle 1 26
   |> filled black |> move (8, -73) |> rotate (degrees 55),
   rectangle 38 4
   |> filled (rgb 42 121 155) |> addOutline (solid 0.8) black
   |> move (35, 21),
   rectangle 38 4
   |> filled (rgb 42 121 155) |> addOutline (solid 0.8) black
   |> move (-35, 21)
   ]