module Website.Figure where

import Website.Text (code)

diagram : [(String, Element)] -> Int -> Element
diagram parts tw =
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

timeline : [(Float, Element)] -> Int -> Element
timeline parts tw =
  let offsets = scanl (+) 0 <| map fst parts
      total = last offsets
  in  flow down
    [ foldr1 beside <| zipWith (\(f,_) o -> toText (if o == 0 then "start" else "after " ++ show o ++ " s") |> centered |> width (floor (f * toFloat tw / total))) parts offsets
    , collage tw 10 [path (foldr (++) [] <| zipWith (\o (f,_) ->
        [ (o / total * toFloat tw, 0)
        , ((o + f/2) / total * toFloat tw, 0)
        , ((o + f/2) / total * toFloat tw, 5)
        , ((o + f/2) / total * toFloat tw, -5)
        , ((o + f/2) / total * toFloat tw, 0)
        , ((o + f) / total * toFloat tw, 0)
        ]) offsets parts) |> traced (solid black) |> move (0.5 - toFloat tw/2, 0.5)]
    , foldr1 beside <| map (\(f,e) -> width (floor (f * toFloat tw / total)) e) parts
    ]
