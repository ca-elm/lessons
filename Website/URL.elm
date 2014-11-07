module Website.URL where

import Graphics.Element as E

resolve : String -> String
resolve f = "/" ++ f

link : String -> Element -> Element
link = E.link << resolve
