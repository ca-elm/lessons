module Website.Template (lesson) where

import Window
import Website.CSS (css)

lesson words =
  let display (w,_) s = case s of
        Init -> css
        Display -> content words w
  in  lift2 display Window.dimensions
      -- hack: add CSS, then do another update to fix layout
      <| sampleOn (keepWhen (lift (\t -> t < 200) <| foldp (+) 0 <| fps 60) 0 (fps 60)) <| merge (constant Init) (lift (always Display) (fps 60))

data State = Init | Display

--lesson words = lift (content words << fst)
--  <| merge Window.dimensions
--  -- hack: add CSS, then do another update to fix layout
--  <| sampleOn (keepWhen (lift (\t -> t < 200) <| foldp (+) 0 <| fps 60) 0 (fps 60)) Window.dimensions

content words w =
  let ws = words (min 600 (w - 32))
  in ws `above` css
    |> container w (heightOf ws) midTop
