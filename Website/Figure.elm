module Website.Figure where

import Website.Text (code)

diagram : Int -> [(String, Element)] -> Element
diagram tw parts =
  let headers = map (code << fst) parts
      space = code " "
      spaceW = widthOf space
      header = foldr1 beside headers
      offsets = scanl (+) 0 <| map widthOf headers
      w = last offsets

      descs = map (width (tw - w - spaceW) << snd) parts
      vOffsets = scanl (+) 0 <| map heightOf descs

      h = last vOffsets
      basis = move (0.5 - toFloat w / 2, 0.5 + toFloat h / 2)
      lines = zipWith3 (\off v head -> path
        [ (off, -1)
        , (off + toFloat (head - 11), -1)
        , (off + toFloat ((head - 11)//2), 0)
        , (off + toFloat ((head - 11)//2), -30 - v)
        , (0, -30 - v)
        ] |> traced (solid black) |> basis)
        (map toFloat offsets)
        (map toFloat vOffsets)
        (map widthOf headers)
      comments = flow right
        [ foldr1 above descs
        , spacer spaceW 1
        , collage w h lines
        ]
  in  spacer (tw - w - spaceW) 1 `beside` space `beside` header `above` comments

timeline : Int -> [(Float, Element)] -> Element
timeline tw parts =
  let offsets = scanl (+) 0 <| map fst parts
      total = last offsets
      time (f,_) o =
        toText (if o == 0 then "start" else "after " ++ show o ++ " s")
          |> centered
          |> width (floor (f * toFloat tw / total))
      tick o (f,_) =
        map (\(x,y) -> ((o + x) / total * toFloat tw, y))
        [ (0, 0)
        , (f/2, 0)
        , (f/2, 5)
        , (f/2, -5)
        , (f/2, 0)
        , (f, 0)
        ]
  in  flow down
    [ foldr1 beside <| zipWith time parts offsets
    , collage tw 10
      [ zipWith tick offsets parts
        |> foldr (++) []
        |> path
        |> traced (solid black)
        |> move (0.5 - toFloat tw/2, 0.5)
      ]
    , map (\(f,e) -> width (floor (f * toFloat tw / total)) e) parts
      |> foldr1 beside
    ]
