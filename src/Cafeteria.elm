module Cafeteria exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.EllieApp exposing (..)




preBorderLines = [

  -- random big lines
  ((-69,20), (40, 420)),
  ((-30,20), (-30, 420)),
  ((-9,-30), (-40, -500))


  ]





-- Cafeteria
cafeteria = group [cafe_exterior,
   cafe_tables,
   rectangle 22 2 
   |> filled (rgb 44 48 48) |> move (-85, -10) 
   |> addOutline (solid 1) black,
   rectangle 22 2 
   |> filled (rgb 44 48 48) |> move (-85, 10) 
   |> addOutline (solid 1) black,
   rectangle 22 18
   |> filled (rgb 132 162 170) |> move (-84, 0),
   rectangle 26.5 4
   |> filled (rgb 132 162 170) |> move (0, -62),
   vent 0 -75
   |> rotate (degrees 90) |> scale 0.8,
   wire_box
   |> scale 0.75|> move (0, 56.5)]
   
cafe_tables = group [rectangle 60 15
   |> filled (rgb 66 119 160) |> addOutline (solid 0.5) black,
   rectangle 60 4
   |> filled (rgb 66 119 160) |> addOutline (solid 0.5) black
   |> move (0, -12),
   rectangle 60 4
   |> filled (rgb 66 119 160) |> addOutline (solid 0.5) black
   |> move (0, 12),
   -- bottom left
   rectangle 25 10
   |> filled (rgb 66 119 160) |> addOutline (solid 0.5) black
   |> move (-33, -40),
   rectangle 25 2
   |> filled (rgb 66 119 160) |> addOutline (solid 0.5) black
   |> move (-33, -32),
   rectangle 25 2
   |> filled (rgb 66 119 160) |> addOutline (solid 0.5) black
   |> move (-33, -48),
   -- bottom right
   rectangle 25 10
   |> filled (rgb 66 119 160) |> addOutline (solid 0.5) black
   |> move (33, -40),
   rectangle 25 2
   |> filled (rgb 66 119 160) |> addOutline (solid 0.5) black
   |> move (33, -32),
   rectangle 25 2
   |> filled (rgb 66 119 160) |> addOutline (solid 0.5) black
   |> move (33, -48),
   -- top left
   rectangle 25 10
   |> filled (rgb 66 119 160) |> addOutline (solid 0.5) black
   |> move (-33, 40),
   rectangle 25 2
   |> filled (rgb 66 119 160) |> addOutline (solid 0.5) black
   |> move (-33, 32),
   rectangle 25 2
   |> filled (rgb 66 119 160) |> addOutline (solid 0.5) black
   |> move (-33, 48),
   -- top right
   rectangle 25 10
   |> filled (rgb 66 119 160) |> addOutline (solid 0.5) black
   |> move (33, 40),
   rectangle 25 2
   |> filled (rgb 66 119 160) |> addOutline (solid 0.5) black
   |> move (33, 32),
   rectangle 25 2
   |> filled (rgb 66 119 160) |> addOutline (solid 0.5) black
   |> move (33, 48)]
   
cafe_exterior = group [rectangle 200 200 
   |> filled (rgb 60 73 74),
   rectangle 2 74 
   |> filled (rgb 44 48 48) |> move (74, 0) 
   |> addOutline (solid 1) black,
   rectangle 2 26 
   |> filled (rgb 44 48 48) |> move (-75, 24) 
   |> addOutline (solid 1) black,
   rectangle 36 2 
   |> filled (rgb 44 48 48) |> move (-32, -62) 
   |> addOutline (solid 1) black,
   rectangle 2 34 
   |> filled (rgb 44 48 48) |> rotate (degrees 45)|> move (63, 49) 
   |> addOutline (solid 1) black,
   rectangle 2 36 
   |> filled (rgb 44 48 48) |> rotate (degrees 45)|> move (-62, -50) 
   |> addOutline (solid 1) black,
   rectangle 2 36 
   |> filled (rgb 44 48 48) |> rotate (degrees 135)|> move (62, -50)
   |> addOutline (solid 1) black,
   rectangle 2 34 
   |> filled (rgb 44 48 48) |> rotate (degrees 135)|> move (-63, 49) 
   |> addOutline (solid 1) black,
   rectangle 98 40
   |> filled (rgb 161 165 150) |> move (1, -40.5),
   rectangle 90 113
   |> filled (rgb 161 165 150) |> move (0, -4),
   rectangle 146 67
   |> filled (rgb 161 165 150) |> move (0, -4),
   rightTriangle 24 24
   |> filled (rgb 161 165 150) |> move (44.5, 29),
   rightTriangle 26 24
   |> filled (rgb 161 165 150) |> rotate (degrees 180)|> move (-48, -37),
   rightTriangle 23 24
   |> filled (rgb 161 165 150) |> rotate (degrees 270)|> move (49.6, -37),
   rightTriangle 24 24
   |> filled (rgb 161 165 150) |> rotate (degrees 90) |> move (-44, 29),
   rightTriangle 6 5
   |> filled (rgb 83 135 143) |> addOutline (solid 0.5) black |> move (-74, 30),
   rightTriangle 5 6
   |> filled (rgb 83 135 143) |> addOutline (solid 0.5) black 
   |> rotate (degrees 90)|> move (74, 30),
   rectangle 145 6
   |> filled (rgb 179 181 167),
   rectangle 145 6
   |> filled (rgb 179 181 167) |> move (0, 26),
   rectangle 145 6
   |> filled (rgb 179 181 167) |> move (0, -26),
   rectangle 120 6
   |> filled (rgb 179 181 167) |> rotate (degrees 90),
   rectangle 6 120
   |> filled (rgb 179 181 167) |> move (24, 0),
   rectangle 6 120
   |> filled (rgb 179 181 167) |> move (-24, 0),
   rectangle 6 120
   |> filled (rgb 179 181 167) |> move (-45, 0),
   rectangle 6 120
   |> filled (rgb 179 181 167) |> move (45, 0),
   rectangle 2 28 
   |> filled (rgb 44 48 48) |> move (-74.5, -24) 
   |> addOutline (solid 1) black,
   rectangle 100 8 
   |> filled (rgb 83 135 143) |> move (0, 57) 
   |> addOutline (solid 0.5) black,
   rectangle 8 36 
   |> filled (rgb 83 135 143) |> rotate (degrees 135)|> move (-58, 45.75)
   |> addOutline (solid 0.5) black,
   rectangle 8 36 
   |> filled (rgb 83 135 143) |> rotate (degrees 45)|> move (58, 46) 
   |> addOutline (solid 0.5) black,
   rectangle 20 7
   |> filled (rgb 83 135 143) |> move (-39, 57),
   rectangle 20 7
   |> filled (rgb 83 135 143) |> move (39, 57),
   rectangle 36 2 
   |> filled (rgb 44 48 48) |> move (32, -62) 
   |> addOutline (solid 1) black,
   rectangle 102 2 
   |> filled (rgb 44 48 48) |> move (0, 61) 
   |> addOutline (solid 1) black
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