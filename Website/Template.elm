module Website.Template (chapter, bare) where

import Window
import Website.Structure as Structure
import Website.URL as URL

type Page =
  { main : Signal Element
  , title : String
  }

chapter : String -> (Int -> Element) -> Page
chapter file words =
  page (Structure.title file) (chapterContent file words)

bare : String -> (Int -> Element) -> Page
bare title words = page title (bareContent words)

page : String -> ((Int,Int) -> Element) -> Page
page title content =
  { main = lift content Window.dimensions
  , title = title
  }

contentWidth : Int -> Int
contentWidth w = min 600 (w - 32)

chapterContent : String -> (Int -> Element) -> (Int,Int) -> Element
chapterContent file words (w,h) =
  let cw = contentWidth w
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
  in  centeredContent w body

bareContent : (Int -> Element) -> (Int,Int) -> Element
bareContent words (w,h) =
  let cw = contentWidth w
  in  centeredContent w (words cw)

centeredContent w body =
  container w (heightOf body) midTop body

navigation : String -> Int -> Element
navigation file w =
  let next = navButton Structure.next (flip (++) " »")
      previous = navButton Structure.previous ((++) "« ")
      navButton adjacent sym = case adjacent file of
        Just (f, title) ->
          sym title
          |> toText
          |> leftAligned
          |> URL.link f
        Nothing -> empty
      contentsLink =
        toText "Table of Contents"
        |> centered
        |> URL.link "Index.elm"
  in  flow inward
        [ container w (heightOf previous) topLeft previous
        , container w (heightOf contentsLink) midTop contentsLink
        , container w (heightOf next) topRight next
        ]
