module Leaf exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.EllieApp exposing (..)

counter = 0

myShapes model =
  [screen] ++
  case model.state of
    Waiting ->
      model.points
        |> List.map 
            ( \ pos -> leaf
                        |> move (5*sin model.time, 5*cos model.time)
                        |> move pos
                        |> notifyMouseDownAt  (MouseDownAt pos)
            )
    Finished ->
        [text "Task Completed!" |> filled black |> move (-10,0)]
    Failed ->
        [text "You have failed!" |> filled black |> move (-10,0)]
    Grabbed delta mouseAt ->
      ( model.points
        |> List.map 
            ( \ pos -> leaf
                        |> move (5*sin model.time, 5*cos model.time)
                        |> move pos
            )
      ) 
      ++
      [ leaf |> addOutline (solid 1) orange
          |> move (add delta mouseAt)
      , rect 190 126 |> filled (rgba 255 255 0 0.01)
          |> notifyMouseUp (Stop (add delta mouseAt))
          |> notifyLeave (Stop (add delta mouseAt))
          |> notifyMouseMoveAt MouseMoveTo
      ]      
      
type Msg 
  = Tick Float GetKeyState
  | MouseDownAt (Float,Float) (Float,Float)
  | MouseMoveTo (Float,Float)
  | Stop (Float, Float)
  
type State 
  = Waiting
  | Grabbed 
      (Float,Float) -- offset from down position to draw position
      (Float,Float) -- current mouse position
  | Finished
  | Failed
      
type alias Model = { time : Float, points : List (Float,Float), state : State, startTime : Int, delay : Int }

update msg model 
  = case msg of
      Tick t _ -> { model | time = t }
      MouseDownAt orig mouseAt ->
        { model | points = List.filter ( \ pos -> pos /= orig ) model.points
                , state = Grabbed (sub orig mouseAt) mouseAt
                }
      MouseMoveTo new ->
        case model.state of 
          Grabbed delta _ ->
            { model | state = Grabbed delta new }
          _ -> 
            model
      Stop (x, y) -> 
        case model.state of 
          Grabbed delta mouseAt ->
            { model | state = if List.length model.points == 0 then Finished else Waiting
                    , points = if (x > -60 && x < -45 && y < 30 && y > -30) then (model.points)
                    else (add delta mouseAt) :: model.points}
          _ -> 
            model
        
sub (x,y) (u,v) = (x-u,y-v)
add (x,y) (u,v) = (x+u,y+v)

init : Model
init = { time = 0, points = pointsFromRandomDotOrg, state = Waiting, startTime = 0, delay = 0 }

main = gameApp Tick { model = init, view = view, update = update, title = "Game Slot" }

view model = collage 192 128 (myShapes model)

-- The initial point location where the leaves are generated
pointsFromRandomDotOrg = 
  [(-5,0)
  ,(25,30)
  ,(15,-45)
  ,(55,-35)
  ,(60,10)
  ]
  

-- Shape code for the leaves and background below
leaf = group [rectangle 2 8
   |> filled (rgb 196 134 86) |> move (0, -5),
   wedge 8 0.5
   |> filled (rgb 91 191 71) |> rotate (degrees 270)|> move (0,7),
   triangle 9.15 
   |> filled (rgb 91 191 71) |> rotate (degrees 90) |> move (0, 11.4),
   rectangle 1 21
   |> filled (rgb 100 166 68) |> move (0, 9.5),
   rectangle 15.25 1
   |> filled (rgb 100 166 68) |> move (0, 7),
   rectangle 13 1
   |> filled (rgb 100 166 68) |> move (0, 3),
   rectangle 10.5 1
   |> filled (rgb 100 166 68) |> move (0, 11)
   ] |> addOutline (solid 0.8) black
   
screen = group [rectangle 40 128
   |> filled (rgb 164 164 164) |> move (-50, 0)
   |> addOutline (solid 0.5) black,
   rectangle 15 60
   |> filled (rgb 34 34 34) |> move (-50, 0)
   |> addOutline (solid 0.5) black, 
   triangle 5
   |> filled (rgb 126 126 126) |> move (-64, 0)
   |> addOutline (solid 0.5) black,
   triangle 5
   |> filled (rgb 126 126 126) |> rotate (degrees 60)|> move (-36, 0)
   |> addOutline (solid 0.5) black,
   rectangle 120 128
   |> filled (rgb 182 200 233) |> move (30, 0)
   |> addOutline (solid 0.5) black
   ]