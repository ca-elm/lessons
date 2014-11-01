module Website.URL where

import Graphics.Element as E

link : String -> String -> Element -> Element
link prefix f = E.link f
