module Imposter exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import Tuple exposing (first, second)


myShapes model =
  [
    rect 200 200 |> filled (rgb 60 74 74)
    , toLineOutliness preBorderLines |> group
    , imposter 0
    |> scale 0.3
    |> move model.pos
    |> move (0,2.5)
  ]


type alias Lines =
    {
      vertical : Bool
    , slope : Float
    , point1 : (Float, Float)
    , point2 : (Float, Float)
    }



preBorderLines = [
  ((-10,0) , (10,0)),
  ((-10,0), (-15, 5)),
  ((10,0), (15, 5)),
  ((15,5), (15, 500)),
  ((-15,5), (-15, 500)),

  -- random big lines
  ((-69,20), (40, 420)),
  ((-30,20), (-30, 420)),
  ((-9,-30), (-40, -500)),

  -- box
  ((30,30), (40, 30)),
  ((40,30), (40, 40)),
  ((40,40), (30, 40)),
  ((30,40), (30, 30))


  ]

suspeed = 1

thiccness = 4

borderLines = toBorderLines preBorderLines




toLineOutliness pairs = 
    case pairs of
        [] -> 
          []

        ((pair1 , pair2) :: otherLines) ->
          (line pair1 pair2 |> outlined (solid 0.5) (rgb 0 182 255)) :: toLineOutliness otherLines


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
    pos = (20,0)
    }

type Msg = Tick Float GetKeyState

update msg model = 
    case msg of
        Tick t (_, _ , (deltaX,deltaY)) -> 
            { model | time = t , pos = (movePlayer model.pos (deltaX*suspeed,deltaY*suspeed))}



movePlayer (x,y) (deltaX,deltaY) = validateMove (x,y) (x+deltaX,y+deltaY) borderLines

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



main = gameApp Tick {
    model = init,
    view = view,
    update = update,
    title = "wall test" 
    }

view model = collage 192 128 (myShapes model)

{- imposter -}
colorPro deg shade = hsl deg 1 (if shade then 0.3 else 0.45) 
goggle = rgb 153 204 204
goggleShade = rgb 89 140 140
imposter deg = 
    let
        size = 20
    in
        group [
            group [
                curve (0,0) [Pull (15,-2) (17,8), Pull (21,39) (0,38)]
                    |> filled (colorPro deg True),
                circle (size * 0.3)
                    |> filled (colorPro deg False)
                    |> scaleY 0.7
                    |> rotate (degrees -20)
                    |> move (size / 2, size * 1.6),
                curve (0,0) [Pull (15,-2) (17,8), Pull (21,39) (0,38)]
                    |> outlined (solid (size * 0.1 / (size * 0.02))) black
            ]
                |> scaleX -1
                |> scaleY 1.1
                |> scale (size * 0.02)
                |> move (-size / 2.4, -size / 2),
            roundedRect size (size * 1.5) (size * 0.5)
                |> filled (colorPro deg True),
            circle (size * 0.75)
                |> filled (colorPro deg False)
                |> scaleX 0.68
                |> scaleY 0.9
                |> move (size / 23 - 0.05, size / 10),
            roundedRect size (size * 1.5) (size * 0.5)
                |> outlined (solid (size * 0.1)) black,
            group [
                leg size (colorPro deg True),
                curve (0,-2) [Pull (-3,-24) (8,-22), 
                            Pull (15,-23) (15,-8), 
                            Pull (16,35) (15,26)]
                    |> outlined (solid (1 / (size * 0.015))) black
                    |> scaleX -1.3
                    |> scale (size * 0.02)
                    |> move (-size / 11, -size / 1.55)
            ],
            group [
                leg size (colorPro deg True),
                curve (0,-2) [Pull (-3,-24) (8,-22), 
                            Pull (15,-23) (15,-8), 
                            Pull (16,35) (15,26)]
                    |> outlined (solid (1 / (size * 0.015))) black
                    |> scaleX -1.3
                    |> scale (size * 0.02)
                    |> move (-size / 11.2, -size / 1.55)
            ]
                |> scaleX -1
                |> move (size / 100, 0),
            group [
                roundedRect size (size * 1.5) (size * 0.5)
                    |> filled goggleShade,
                circle size
                    |> filled goggle
                    |> clip (
                        roundedRect size (size * 1.5) (size * 0.5) 
                            |> ghost
                            |> move (size / 4, -size / 4)
                            |> scaleY 0.8
                            |> scaleX 0.6),
                roundedRect size (size * 1.5) (size * 0.5)
                    |> outlined (solid (size * 0.1 / 0.4)) black
            ]
                |> scale 0.4
                |> scaleY 1.2
                |> rotate (degrees 90)
                |> move (size / 4, size / 4),
            roundedRect (size * 0.75) (size * 1.75) (size * 0.5)
                |> filled white
                |> rotate (degrees 90)
                |> scale 0.1
                |> move (size / 2.7, size / 3.3)
        ]

leg size color = group [
    curve (0,0) [Pull (-3,-24) (8,-22), 
                 Pull (15,-23) (15,-8), 
                 Pull (16,35) (13,26), 
                 Pull (13,7) (0,0)]
        |> filled color
        |> scaleX -1.3
        |> scale (size * 0.02)
        |> move (-size / 11, -size / 1.55)
    ]


