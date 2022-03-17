module Security exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.EllieApp exposing (..)

myShapes _ =
  [
    bg
  , floors
  , lines
      |> clip (polygon [(-29,0),(-29,90),(-5,115),(20,115),(39,90),(39,0)]
                  |> filled (rgb 52 104 91)
                  |> move (30, -60))
   , oval 100 90 |> filled (rgb 91 141 117) |> move (30, 47) |> makeTransparent 0.8
       |> clip (lines |> clip (polygon [(-29,0),(-29,90),(-5,115),(20,115),(39,90),(39,0)]
                  |> filled (rgb 52 104 91)
                  |> move (30, -60)))
   , wall
   , walls
   , computer
   , vent 60 -53
  ]


preBorderLines = [
      ((-75, -70), (-75, -53)),
      ((-75, -53), (-100, -53)),
      ((-100, -19), (-75, -19)),
      ((-75, -19), (-75, 64)),
      ((-75, 64), (-35, 64)),
      ((-35, 64), (-35, -19)),
      ((-35, -19), (0, -19)),
      ((0, -19), (0, 15)),
      ((0, 15), (25, 41)),
      ((25, 41), (50, 41)),
      ((50, 41), (70, 15)),
      ((70, 15), (70, -61)),
      ((70, -61), (0, -61)),
      ((0, -61), (0, -53)),
      ((0, -53), (-35, -53)),
      ((-35, -53), (-35, -70))
    ]


security = [
    bg
  , floors
  , lines
      |> clip (polygon [(-29,0),(-29,90),(-5,115),(20,115),(39,90),(39,0)]
                  |> filled (rgb 52 104 91)
                  |> move (30, -60))
   , oval 100 90 |> filled (rgb 91 141 117) |> move (30, 47) |> makeTransparent 0.8
       |> clip (lines |> clip (polygon [(-29,0),(-29,90),(-5,115),(20,115),(39,90),(39,0)]
                  |> filled (rgb 52 104 91)
                  |> move (30, -60)))
   , wall
   , walls
   , computer
   , vent 60 -53
    ]

bg = group
  [
     rect 200 200 |> filled (rgb 60 73 74)
  ]

floors = group
  [
    polygon [(-33,-5),(-33,92),(-7,119),(22,119),(43,92),(43,-5)]
      |> filled (rgb 44 47 46)
      |> move (30, -60)
      |> addOutline (solid 1.5) (rgb 26 32 33)
  , polygon [(-30,-1),(-30,91),(-5,116),(20,116),(40,91),(40,-1)]
      |> filled (rgb 52 104 91)
      |> move (30, -60)
      |> addOutline (solid 1.5) (rgb 26 32 33)
  , oval 100 90 |> filled (rgb 91 141 117) |> move (30, 47) |> clip (polygon [(-29,0),(-29,91),(-5,116),(20,115),(39,91),(39,0)]
                                                                       |> filled (rgb 129 152 143)
                                                                       |> move (30, -60))
  , rect 40 200 |> filled (rgb 86 82 77) |> move (-55, 0)
  , rect 100 40 |> filled (rgb 86 82 77) |> move (-50, -33)
  --, text "SECURITY" |> sansserif |> bold |> filled (rgb 63 73 66) |> scale 0.7 |> move (-45, -35)
  --, text "REACTOR" |> sansserif |> bold |> filled (rgb 51 49 62) |> scale 0.7 |> move (-110, -35)
  --, rect 7 10 |> filled (rgb 63 73 66) |> move (-10, -43)
  --, rect 7 10 |> filled (rgb 63 73 66) |> move (-10, -20)
  ]
  
lines = group
  [
     rect 1 200 |> filled (rgb 47 93 84) |> move (15,0)
  ,  rect 1 200 |> filled (rgb 47 93 84) |> move (30,0)
  ,  rect 1 200 |> filled (rgb 47 93 84) |> move (45,0)
  ,  rect 1 200 |> filled (rgb 47 93 84) |> move (60,0)
  ,  rect 150 1 |> filled (rgb 47 93 84) |> move (60,30)
  ,  rect 150 1 |> filled (rgb 47 93 84) |> move (60,0)
  ,  rect 150 1 |> filled (rgb 47 93 84) |> move (60,15)
  ,  rect 150 1 |> filled (rgb 47 93 84) |> move (60,-15)
  ,  rect 150 1 |> filled (rgb 47 93 84) |> move (60,-30)
  ,  rect 150 1 |> filled (rgb 47 93 84) |> move (60,-45)
  ,  rect 150 1 |> filled (rgb 47 93 84) |> move (60,-60)
  ]
  
wall = group
  [
    polygon [(-29,0),(-29,91),(-5,116),(20,116),(39,91),(39,0)]
      |> filled (rgb 129 152 143)
      |> move (30, -60)
      |> subtract (polygon [(-29,0),(-29,91),(-5,116),(20,116),(39,91),(39,0)]
                  |> filled (rgb 129 152 143)
                  |> move (30, -75))
  , polygon [(-29,0),(-29,91),(-5,116),(20,116),(39,91),(39,0)]
      |> filled (rgb 129 152 143)
      |> move (30, -75)
      |> addOutline (solid 1.5) (rgb 26 32 33)
      |> subtract (polygon [(-29,0),(-29,91),(-5,116),(20,116),(39,91),(39,0)]
                  |> filled (rgb 129 152 143)
                  |> move (30, -75))
  ]
  
walls = group 
  [
    rect 35 17 |> filled (rgb 45 49 48) |> move (-17, -7) |> addOutline (solid 1.5) (rgb 26 32 33)
  , rect 35 17 |> filled (rgb 45 49 48) |> move (-93, -7) |> addOutline (solid 1.5) (rgb 26 32 33)
  , rect 1.5 2.5   |> filled (rgb 45 49 48) |> move (-1.5, 2)
  , rect 35 17 |> filled (rgb 131 127 115) |> move (-17, -10) |> addOutline (solid 1.5) (rgb 26 32 33)
  , rect 35 17 |> filled (rgb 131 127 115) |> move (-93, -10) |> addOutline (solid 1.5) (rgb 26 32 33)
  , rect 35 3 |> filled (rgb 45 49 48) |> move (-17, -55) |> addOutline (solid 1.5) (rgb 26 32 33)
  , rect 35 3 |> filled (rgb 45 49 48) |> move (-95, -55) |> addOutline (solid 1.5) (rgb 26 32 33)
  , rect 3 20 |> filled (rgb 45 49 48) |> move (-77, -63.5) |> addOutline (solid 1.5) (rgb 26 32 33)
  , rect 3 20 |> filled (rgb 45 49 48) |> move (-33, -63.5) |> addOutline (solid 1.5) (rgb 26 32 33)
  , rect 3 70 |> filled (rgb 45 49 48) |> move (-33, 33.5) |> addOutline (solid 1.5) (rgb 26 32 33)
  , rect 3 70 |> filled (rgb 45 49 48) |> move (-77, 33.5) |> addOutline (solid 1.5) (rgb 26 32 33)
  ]
  
computer = group
  [
    roundedRect 20 10 2|> filled (rgb 48 59 60) |> addOutline (solid 1) (rgb 26 32 33) |> move (37, 50)
  , roundedRect 18 7 2|> filled (rgb 182 232 214) |> addOutline (solid 0.5) (rgb 26 32 33) |> move (37, 49)
  , polygon [(0,4),(6,8),(6,4),(0,0)]|> filled (rgb 48 59 60) |> addOutline (solid 1) (rgb 26 32 33) |> move (18, 42)
  , polygon [(0,3),(6,7),(6,4),(0,0)]|> filled (rgb 182 232 214) |> addOutline (solid 1) (rgb 26 32 33) |> move (18.5, 42.5)
  , polygon [(-0,4),(-6,8),(-6,4),(-0,0)]|> filled (rgb 48 59 60) |> addOutline (solid 1) (rgb 26 32 33) |> move (56, 42)
  , polygon [(-0,3),(-6,7),(-6,4),(-0,0)]|> filled (rgb 182 232 214) |> addOutline (solid 1) (rgb 26 32 33) |> move (55.5, 42.5)
  , roundedRect 20 7 2 |> filled (rgb 66 54 49) |> move (37, 40) |> addOutline (solid 1) (rgb 26 32 33)
  , roundedRect 18 6 2 |> filled (rgb 116 112 89) |> move (37, 41) |> addOutline (solid 0.5) (rgb 26 32 33)
  , roundedRect 8 3 1 |> filled (rgb 204 236 234) |> move (35, 41) |> addOutline (solid 0.5) (rgb 26 32 33)
  , oval 2 3 |> filled (rgb 204 236 234) |> move (42, 41) |> addOutline (solid 0.5) (rgb 26 32 33)
  
  
  
  
  ]
 
vent x y = group
  [
    roundedRect 12 9 2 |> filled (rgb 103 126 127) |> addOutline (solid 1) (rgb 26 32 33) |> move (x, y)
  , roundedRect 10 0.5 1 |> filled (rgb 74 85 100) |> move (x, y - 2.5)
  , roundedRect 10 0.5 1 |> filled (rgb 74 85 100) |> move (x, y - 1)
  , roundedRect 10 0.5 1 |> filled (rgb 74 85 100) |> move (x, y + 0.5)
  , roundedRect 10 0.5 1 |> filled (rgb 74 85 100) |> move (x, y + 2)
  ]
  
  
  
  
  
  
  
  
  
  
  
  
