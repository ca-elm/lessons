module Website.Structure (contents, link, title, find, previous, next) where

import String as S
import Graphics.Element as E
import Maybe

type Chapter = (String, String)

contents : [Chapter]
contents =
  [ ("Introduction.elm", "An Introduction to Elm")
  , ("Test.elm", "Another Chapter")
  ]

link : String -> String -> Element -> Element
link prefix f = E.link <|
  if f == "Index.elm" then prefix
  else prefix ++ S.dropRight 4 (S.toLower f) ++ "/"

title : String -> String
title file = case findFile file of
  Just (_, title) -> title
  Nothing -> file

previous : String -> Maybe Chapter
previous file =
  zip (tail contents) contents
  |> find ((==) file << fst << fst)
  |> Maybe.map snd

next : String -> Maybe Chapter
next file =
  zip contents (tail contents)
  |> find ((==) file << fst << fst)
  |> Maybe.map snd

find : (a -> Bool) -> [a] -> Maybe a
find p xs = case xs of
  [] -> Nothing
  x::xs -> if p x then Just x else find p xs

findFile file = find ((==) file << fst) contents
