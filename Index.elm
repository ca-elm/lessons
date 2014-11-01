import Website.Template (bare)
import Website.Structure as Structure

words w = flow down [width w [markdown|

# Game Design

## Table of Contents

|], tableOfContents w]

tableOfContents w =
  let bw = 24
      chapter i (f, title) =
        flow right
          [ toText (show (i + 1) ++ ". ")
            |> leftAligned
            |> width bw
          , toText title
            |> leftAligned
            |> Structure.link "" f
          ]
  in  indexedMap chapter Structure.contents |> flow down |> width w

index = bare "Game Design" words
main = index.main
port title : String
port title = index.title
