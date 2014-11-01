module Website.URL where

import String as S
import Graphics.Element as E

link : String -> String -> Element -> Element
link prefix f = E.link <|
  if f == "Index.elm" then prefix
  else prefix ++ S.dropRight 4 (S.toLower f) ++ "/"
