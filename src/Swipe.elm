module Swipe exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.EllieApp exposing (..)
import Imposter exposing (imposter)
import List exposing (indexedMap)
  
outer = 
    curve (-66.87,-39.59) [
        Pull (-67.82,-32.77) (-68.78,-25.95),
        Pull (-70.69,-15.43) (-72.61,-4.904),
        Pull (-69.62,-3.828) (-66.63,-2.751),
        Pull (-62.56,-1.674) (-58.49,-0.598),
        Pull (-53.47,0.5981) (-48.44,1.7943),
        Pull (-42.22,2.2728) (-36.00,2.7514),
        Pull (-29.30,2.9906) (-22.60,3.2299),
        Pull (-14.47,3.1102) (-6.340,2.9906),
        Pull (2.0336,2.2728) (10.407,1.5551),
        Pull (15.431,1.1962) (20.456,0.8373),
        Pull (27.155,0.8373) (33.854,0.8373),
        Pull (38.639,0.8373) (43.424,0.8373),
        Pull (48.807,1.5551) (54.190,2.2728),
        Pull (57.540,2.7514) (60.889,3.2299),
        Pull (60.530,0.1196) (60.171,-2.990),
        Pull (60.411,-6.938) (60.650,-10.88),
        Pull (60.411,-14.95) (60.171,-19.02),
        Pull (60.291,-23.32) (60.411,-27.63),
        Pull (60.052,-32.05) (59.693,-36.48),
        Pull (59.693,-37.92) (59.693,-39.35),
        Pull (48.209,-39.59) (-66.87,-39.59)]

left = 
    curve (-71.65,-6.818) [
        Pull (-66.39,-5.383) (-61.12,-3.947),
        Pull (-55.38,-2.751) (-49.64,-1.555),
        Pull (-44.50,-1.914) (-39.35,-2.272),
        Pull (-32.77,-3.708) (-26.19,-5.143),
        Pull (-21.05,-6.459) (-15.91,-7.775),
        Pull (-9.809,-10.16) (-3.708,-12.56),
        Pull (-2.631,-19.14) (-1.555,-25.71),
        Pull (-1.315,-32.77) (-1.076,-39.83),
        Pull (-33.49,-39.71) (-65.91,-39.59),
        Pull (-66.87,-33.25) (-67.82,-26.91),
        Pull (-69.02,-22.96) (-70.22,-19.02),
        Pull (-70.81,-12.91) (-71.41,-6.818)]

left1 = 
    curve (-66.15,-39.83) [
        Pull (-66.99,-36.84) (-67.82,-33.85),
        Pull (-67.94,-29.90) (-68.06,-25.95),
        Pull (-68.42,-23.32) (-68.78,-20.69),
        Pull (-70.10,-16.50) (-71.41,-12.32),
        Pull (-65.07,-11.36) (-58.73,-10.40),
        Pull (-51.91,-9.928) (-45.09,-9.450),
        Pull (-37.92,-10.40) (-30.74,-11.36),
        Pull (-25.36,-12.91) (-19.97,-14.47),
        Pull (-11.24,-17.46) (-2.512,-20.45),
        Pull (-2.631,-25.48) (-2.751,-30.50),
        Pull (-1.794,-35.28) (-0.837,-40.07),
        Pull (-33.37,-39.95) (-66.15,-39.83)]

left2 = 
    curve (-66.15,-39.59) [
        Pull (-67.22,-32.89) (-68.30,-26.19),
        Pull (-68.90,-23.32) (-69.50,-20.45),
        Pull (-64.35,-18.78) (-59.21,-17.10),
        Pull (-52.99,-16.74) (-46.77,-16.38),
        Pull (-39.71,-17.22) (-32.65,-18.06),
        Pull (-25.24,-19.73) (-17.82,-21.41),
        Pull (-9.928,-23.20) (-2.033,-25.00),
        Pull (-1.674,-32.29) (-1.315,-39.59),
        Pull (-33.61,-39.83) (-66.15,-39.59)]

left3 = 
    curve (-65.91,-39.59) [
        Pull (-66.99,-36.72) (-68.06,-33.85),
        Pull (-68.42,-29.94) (-68.06,-27.39),
        Pull (-65.19,-26.19) (-62.32,-25.00),
        Pull (-53.83,-24.62) (-45.33,-25.71),
        Pull (-36.72,-25.59) (-28.11,-25.95),
        Pull (-20.93,-26.91) (-13.75,-27.87),
        Pull (-7.297,-29.06) (-0.837,-30.26),
        Pull (-0.717,-35.05) (-0.598,-39.83),
        Pull (-33.25,-39.71) (-65.91,-39.59)]

right = 
    curve (-0.837,-40.07) [
        Pull (-0.957,-34.93) (-1.076,-29.78),
        Pull (-2.033,-22.37) (-2.990,-14.95),
        Pull (1.1962,-14.11) (5.3831,-13.27),
        Pull (32.897,-7.895) (60.411,-2.512),
        Pull (60.291,-21.05) (60.171,-39.59),
        Pull (29.786,-39.83) (-0.837,-40.07)]

right1 = 
    curve (5.1439,-40.07) [
        Pull (4.9631,-30.50) (5.6224,-20.93),
        Pull (5.7828,-15.91) (5.3831,-10.88),
        Pull (21.970,-7.700) (39.357,-1.555),
        Pull (49.602,1.8966) (61.128,3.7084),
        Pull (60.228,-4.446) (61.128,-12.32),
        Pull (60.409,-21.09) (60.650,-29.78),
        Pull (60.171,-34.93) (59.693,-40.07),
        Pull (32.538,-39.95) (5.1439,-40.07)]

picture = 
    curve (12.560,-39.59) [
        Pull (12.321,-27.15) (12.082,-14.71),
        Pull (30.134,-12.92) (42.706,-7.775),
        Pull (48.686,-5.240) (55.386,-4.426),
        Pull (53.409,-18.81) (53.712,-40.07),
        Pull (33.136,-40.07) (12.560,-39.59)]

card = group [
    roundedRect 50 30 3
        |> filled (rgb 221.5 221.5 221.5),
    text "Joe Biden"
        |> customFont "consolas"
        |> filled (rgb 48 48 48)
        |> scale 0.4
        |> move (-22, 10),
    indexedMap (\i j -> text j
            |> customFont "consolas" 
            |> filled (rgb 48 48 48)
            |> scale 0.3
            |> move (0, -(toFloat i) * 4)) ["some words", "more words", "even more words", "when does it stop", "never"]
        |> group
        |> scale 0.75
        |> move (-5, 5),
    let
        s = roundedRect 15 19 1.5
    in 
    group [
        s
            |> outlined (solid 1) black,
        s
            |> filled (rgb 98.8 98.8 98.8),
        imposter 0
            |> scale 0.6
            |> rotate (degrees -2)
            |> mirrorX
            |> move (1, -2)
            |> clip (s |> ghost) 
    ]
        |> move (-14, -2)
    ]

make shape = group [
        shape
            |> outlined (solid 1) black,
        shape
            |> filled (rgb 136.7 68.8 53.4)
    ]

draw = group [
        rect 95 88 
            |> filled (rgb 65 65 65),
        rect 95 45
            |> filled (rgb 53 53 53)
            |> move (0, 21),
        rect 95 30
            |> filled (rgb 146 146 146)
            |> move (0, 29)
            |> subtract (
                triangle 10
                    |> ghost
                    |> move (-50, 13)),
        rect 95 10
            |> filled (rgb 146 146 146)
            |> move (0, 7)
            |> subtract (
                triangle 10
                    |> ghost
                    |> move (-50, 13)),
        rect 70 7
            |> filled (rgb 21 73.8 57.9)
            |> move (-5, 37),

        -- Wallet
        group [
            outer
                |> outlined (solid 1.5) black,
            outer
                |> filled (rgb 93 30 17.5),
            make right
                |> scaleX 1.03
                |> move (-2, 0),
            make right1,
            let
                pic = picture |> filled lightBlue
            in group [
                picture
                    |> outlined (solid 1) black,
                pic,
                circle 25
                    |> filled white
                    |> move (32, -48)
                    |> clip pic,
                imposter (degrees 30)
                    |> scale 0.9
                    |> rotate (degrees 5)
                    |> move (18, -35)
                    |> clip pic,
                imposter (degrees 120)
                    |> rotate (degrees -3)
                    |> scale 0.9
                    |> mirrorX
                    |> move (45, -25)
                    |> clip pic,
                imposter (degrees 180)
                    |> scale 0.6
                    |> rotate (degrees 7)
                    |> mirrorX
                    |> move (40, -40)
                    |> clip pic,
                picture
                    |> filled lightGrey
                    |> makeTransparent 0.7
            ],
            group [
                make left,
                make left1
                    |> scaleX 1.02
                    |> move (1, 0)
            ]
                |> move (-1, 0),
            card
                |> move (-37, -20),
            group [
                make left2, 
                make left3 
            ]
                |> move (-1, 0)
        ]
            |> scale 0.70
            |> move (4, -15.7)
    ]