module Website.Template (chapter) where

import Window
import Website.Structure as Structure
import Website.CSS (css)

type Chapter =
  { main : Signal Element
  , title : String
  }

chapter : String -> (Int -> Element) -> Chapter
chapter file words =
  let display (w,h) s = case s of
        Init -> css
        Display -> content file words (w,h)
  in  { main =
          lift2 display Window.dimensions
          -- hack: add CSS, then do another update to fix layout
          <| sampleOn (keepWhen (lift (\t -> t < 200) <| foldp (+) 0 <| fps 60) 0 (fps 60))
          <| merge (constant Init)
          <| lift (always Display) (fps 60)
      , title = Structure.title file
      }

data State = Init | Display

--chapter file words = lift (content file words << fst)
--  <| merge Window.dimensions
--  -- hack: add CSS, then do another update to fix layout
--  <| sampleOn (keepWhen (lift (\t -> t < 200) <| foldp (+) 0 <| fps 60) 0 (fps 60)) Window.dimensions

content : String -> (Int -> Element) -> (Int,Int) -> Element
content file words (w,h) =
  let cw = (min 600 (w - 32))
      body = flow down
        [ space
        , nav
        , height wh words'
        , nav
        , space
        ]
      wh = max (h - 2 * (heightOf space + heightOf nav)) (heightOf words')
      words' = words cw
      nav = navigation file cw
      space = spacer 1 8
  in  body `above` css
      |> container w (heightOf body) midTop

navigation : String -> Int -> Element
navigation file w =
  let next = navButton Structure.next (flip (++) " »")
      previous = navButton Structure.previous ((++) "« ")
      navButton adjacent sym = case adjacent file of
        Just (f, title) ->
          sym title
          |> toText
          |> leftAligned
          |> link ("/" ++ f)
        Nothing -> empty
  in  flow right
        [ previous
        , spacer (w - widthOf next - widthOf previous) 1
        , next
        ]
