module ColTest exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import Imposter exposing (imposter)
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


suspeed = 1

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

borderLines = toBorderLines preBorderLines




toLineOutliness pairs = 
    case pairs of
        [] -> 
          []

        ((pair1 , pair2) :: otherLines) ->
          (line pair1 pair2 |> outlined (solid 0.5) (rgb 0 182 255)) :: toLineOutliness otherLines



toBorderLines pairs = 
    case pairs of
        [] -> 
          []

        (((x1,y1) , (x2,y2)) :: otherLines) ->
          if x1 == x2 then
            {vertical = True, slope=0, point1 = (x1,y1), point2 = (x2,y2)} :: toBorderLines otherLines
          else
            {vertical = False, slope=(y1-y2)/(x1-x2), point1 = (x1,y1), point2 = (x2,y2)} :: toBorderLines otherLines




init = {
    time = 0,
    pos = (20,0)
    }

type Msg = Tick Float GetKeyState

update msg model = 
    case msg of
        Tick t (_, _ , (deltaX,deltaY)) -> 
            { model | time = t , pos = (movePlayer model.pos (deltaX*suspeed,deltaY*suspeed))}



movePlayer (x,y) (deltaX,deltaY) = validateMove (x,y) (x+deltaX,y+deltaY) borderLines True True

sign n = 
  if n > 0 then 1 else -1

validateMove (oldX,oldY) (newX,newY) lines validX validY = 
    case lines of
        [] -> 
            if validX && validY then
              (newX,newY)
            else if validX then
              (newX,oldY)
            else
              (oldX,oldY)

        ({vertical, slope, point1, point2} :: otherLines) ->
            -- if deltaB changes signs, use (oldX,oldY) otherwise call validateMove on rest of lines 
            let
                x1 = first point1
                y1 = second point1
                x2 = first point2
                y2 = second point2
                oldB = sign ((y1 - oldY) + slope*(oldX-x1))
                newB = sign ((y1 - newY) + slope*(newX-x1))
            in
              if vertical then
                if sign (x1 - oldX) == sign (x1 - newX) || newY > (max y1 y2) || newY < (min y1 y2) then 
                  validateMove (oldX,oldY) (newX,newY) otherLines validX validY
                else
                  init.pos
              else 
                if oldB == newB || newX > (max x1 x2) || newX < (min x1 x2) then 
                  validateMove (oldX,oldY) (newX,newY) otherLines validX validY -- not touching line, check others
                else
                  init.pos



main = gameApp Tick {
    model = init,
    view = view,
    update = update,
    title = "wall test" 
    }

view model = collage 192 128 (myShapes model)
