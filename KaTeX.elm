module KaTeX where

import Native.KaTeX

block : Int -> String -> Element
block w formula = width w <| Native.KaTeX.math ("\\displaystyle {" ++ formula ++ "}")

inline : String -> Element
inline = Native.KaTeX.math

markdown : Element -> Element
markdown = Native.KaTeX.markdown
