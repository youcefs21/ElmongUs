module Imposter exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import Tuple exposing (first, second)
import Cafeteria


myShapes model =
  [
    rect 200 200 |> filled (rgb 60 74 74)
    , toLineOutliness model.preBorderLines |> group
    , imposter model
    |> scale 0.3
    |> move model.pos
    |> move (0,2.5)
  ]


imposter model = frame2Img (floor model.frame)

frame1Imposter = frame2Img 1

type alias Lines =
    {
      vertical : Bool
    , slope : Float
    , point1 : (Float, Float)
    , point2 : (Float, Float)
    }




suspeed = 1

thiccness = 4





toLineOutliness pairs = 
    case pairs of
        [] -> 
          []

        ((pair1 , pair2) :: otherLines) ->
          (line pair1 pair2 |> outlined (solid 0.5) red) :: toLineOutliness otherLines


toBorderLines : List ( (Float,Float), (Float,Float) ) -> List Lines
toBorderLines pairs = 
    case pairs of
        [] -> 
          []

        (((x1,y1) , (x2,y2)) :: otherLines) ->
          if x1 == x2 then
            {vertical = True, slope=0, point1 = (x1,y1), point2 = (x2,y2)} :: toBorderLines otherLines
          else if abs((y1 - y2)/(x1 - x2)) > 1 then
            {vertical = True, slope=(x1 - x2)/(y1 - y2), point1 = (x1,y1), point2 = (x2,y2)} :: toBorderLines otherLines
          else
            {vertical = False, slope=(y1 - y2)/(x1 - x2), point1 = (x1,y1), point2 = (x2,y2)} :: toBorderLines otherLines




init = {
    time = 0,
    pos = (40,0),
    preBorderLines = Cafeteria.preBorderLines,
    left = True,
    frame = 1
    }

type alias Model = { 
    time  : Float , 
    pos   : (Float, Float),
    preBorderLines : List ((Float, Float), (Float, Float)),
    left : Bool,
    frame : Float
  }


type Msg = Tick Float GetKeyState

update msg model = 
    case msg of
        Tick t (_, _ , (deltaX,deltaY)) -> 
            { model | time = t
            , pos = (
                movePlayer model.pos (deltaX*suspeed,deltaY*suspeed) (toBorderLines model.preBorderLines)
              )
            , left = if deltaX == 0 then
              model.left 
            else if deltaX > 0 then
              True 
            else False
            , frame = if deltaX == 0 && deltaY == 0 then 1 else if model.frame + frameRate >= 11 then 1 else model.frame + frameRate

            }



movePlayer (x,y) (deltaX,deltaY) borderLines = validateMove (x,y) (x+deltaX,y+deltaY) borderLines

sign n = 
  if n > 0 then 1 else -1

validateMove : (Float, Float) -> (Float, Float) -> List Lines -> (Float, Float)
validateMove (oldX,oldY) (newX,newY) lines = 
    case lines of
        [] -> 
          (newX,newY)

        ({vertical, slope, point1, point2} :: otherLines) ->
            -- if deltaB changes signs, use (oldX,oldY) otherwise call validateMove on rest of lines 
            let
                x1 = first point1
                y1 = second point1
                x2 = first point2
                y2 = second point2
                oldBdiffX = ((y1 - oldY) + slope*(oldX - x1))
                newBdiffX = ((y1 - newY) + slope*(newX - x1))
                oldBdiffY = ((x1 - oldX) + slope*(oldY - y1))
                newBdiffY = ((x1 - newX) + slope*(newY - y1))
                distanceFromPoint1 = (sqrt ((newY - y1) ^ 2 + (newX - x1) ^ 2))
                distanceFromPoint2 = (sqrt ((newY - y2) ^ 2 + (newX - x2) ^ 2))
            in
              if vertical then
                if (
                    (sign oldBdiffY == -1 && newBdiffY < -thiccness) ||
                    (sign oldBdiffY == 1 && newBdiffY > thiccness)   ||              
                     newY > (max y1 y2)                      ||
                    newY < (min y1 y2)
                   )
                   && distanceFromPoint1 > thiccness
                   && distanceFromPoint2 > thiccness
                then 
                  validateMove (oldX,oldY) (newX,newY) otherLines
                else if slope == 0 && distanceFromPoint1 > thiccness && distanceFromPoint2 > thiccness then
                  validateMove (oldX,oldY) (oldX,newY) otherLines
                else
                  (oldX, oldY)
              else 
                if (
                    (sign oldBdiffX == -1 && newBdiffX < -thiccness) || 
                    (sign oldBdiffX == 1 && newBdiffX > thiccness)   ||
                     newX > (max x1 x2)                      ||
                     newX < (min x1 x2) 
                   )
                   && distanceFromPoint1 > thiccness
                   && distanceFromPoint2 > thiccness
                then 
                  validateMove (oldX,oldY) (newX,newY) otherLines
                else if slope == 0 && distanceFromPoint1 > thiccness && distanceFromPoint2 > thiccness then
                  validateMove (oldX,oldY) (newX,oldY) otherLines
                else
                  (oldX, oldY)


main : GameApp Model Msg
main = gameApp Tick {
    model = init,
    view = view,
    update = update,
    title = "wall test" 
    }

view model = collage 192 128 (myShapes model)

{- imposter -}

goggle = rgb 135 204 224
goggleShade = rgb 60 128 162
c1 = rgb 255 0 0
c2 = rgb 135 0 56

frame2Img f = case f of
  1 -> frame1
  2 -> frame2
  3 -> frame3
  4 -> frame4
  5 -> frame5
  6 -> frame6
  7 -> frame7
  8 -> frame8
  9 -> frame9
  10 -> frame10
  _ -> frame1

frame10 = frame7

frame9 = group
  [
    shadow 
  , backpack 0 4
  , group7 |> move (0, 3)
  ]

frame8 = group
  [
    shadow
  , backpack 0 7
  , group7 |> move (0,3)
  ]

frame7 = group
  [
    shadow
  , backpack 0 4
  , roundedRect 12 8 3 |> filled c2 |> rotate (degrees -40) |> move (9,-13) |> addOutline (solid 2) black 
  , body7
  , goggles1
  ]

frame6 = group
  [
    shadow
  , backpack 0 2
  , roundedRect 8 12 3 |> filled c2 |> move (2,-14) |> addOutline (solid 2) black
  , body6
  , roundedRect 12 8 3 |> filled c2 |> rotate (degrees 10) |> move (-4,-14) |> addOutline (solid 2) black
  , square 5 |> filled c2 |> rotate (degrees -20) |> move (-2,-10)
  , goggles1
  ]

frame5 = frame2

frame4 = group
  [
    shadow
  , backpack 0 2 |> move (0,5)
  , group2 |> move (0,3)
  ]

frame3 = group
  [
    shadow
  , backpack 0 2 |> move (0,5)
  , group2 |> move (0, 5)
  ]

frame2 = group
  [
    shadow
  , backpack 0 2
  , group2
  ]
  
group2 = group
  [
    roundedRect 12 8 3 |> filled c2 |> rotate (degrees -20) |> move (-9,-14) |> addOutline (solid 2) black
  , body2
  , goggles1
  ]
  
group7 = group
  [
    roundedRect 12 8 3 |> filled c2 |> rotate (degrees -40) |> move (9,-13) |> addOutline (solid 2) black 
  , body7
  , goggles1
  ]

frame1 = group
  [ 
    shadow
  , backpack 0 0
  , body1
  , goggles1
  ]

body1 = group
  [
    body
  , leg1 -6 -12
  , leg1 6 -11
  , bodyShadow |> clip body
  ] |> addOutline (solid 4) black

body2 = group
  [
    body
  , leg1 0 0 |> rotate (degrees 40) |> move (4, -12)
  , bodyShadow |> clip body
  ] |> addOutline (solid 4) black
  
body6 = group
  [
    roundedRect 19 24 9 |> filled c2
  , bodyShadow |> move (-0.5, 3) |> clip (roundedRect 19 24 9 |> filled c2)
  ] |> addOutline (solid 4) black
  
body7 = group
  [
    body
  , bodyShadow |> clip body
  , roundedRect 12 6 2 |> filled c2 |> rotate (degrees -10) |> move (-10,-12)
  ] |> addOutline (solid 4) black
  
goggles1 = group
  [
    goggles 
  , gogglesShadow |> clip goggles
  , gogglesOutline
  ]

body = group
  [
    roundedRect 18 28 9 |> filled c2
  ]
  
bodyShadow = group
  [
    roundedRect 16 30 9 |> filled c1 |> move (2, 5)
  ]
  
goggles = group
  [
    roundedRect 16 11 6 |> filled goggleShade |> move (4,5)
  ]
  
gogglesOutline = group
  [
    roundedRect 16 11 6 |> outlined (solid 2) black |> move (4,5)
  ]
  
gogglesShadow = group
  [
    roundedRect 15 9 5 |> filled goggle |> move (6, 8)
  , roundedRect 6 1.75 1 |> filled white |> move (5.5,7)
  ]
  
leg1 x y = group
  [ 
    roundedRect 6 18 2 |> filled c2 |> move (x,y)
  ]
  
backpack x y = group
   [
     roundedRect 6 18 2.5 |> filled c2 |> move (x - 12, y - 5)
   , roundedRect 6 6 2 |> filled c1 |> move (x - 12, y + 3) |> clip (roundedRect 6 20 2.5 |> filled c2 |> move (x - 13, y - 5))
   , roundedRect 6 18 2.5 |> outlined (solid 2) black |> move (x - 12, y - 4)
   ]

shadow = group
  [
    oval 28 6 |> filled black |> move (-1, -21) |> makeTransparent 0.6
  ]


  
frameRate = 0.25

