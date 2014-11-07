module Website.URL where

import String as S
import Graphics.Element as E

resolve : String -> String
resolve f =
  if f == "Index.elm" then "/lessons/"
  else "/lessons/" ++ S.dropRight 4 (S.toLower f) ++ ".html"

link : String -> Element -> Element
link = E.link << resolve
