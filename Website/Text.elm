module Website.Text where

code : String -> Element
code = color (rgb 243 243 243) << leftAligned << monospace << toText

outputText : String -> Text
outputText = monospace << toText

output : Int -> a -> Element
output w = width w << centered << outputText << show
