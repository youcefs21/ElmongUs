module Imposter exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.EllieApp exposing (..)

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


