module Website.Structure (contents, title, find, previous, next) where

import Maybe

type Chapter = (String, String)

contents : [Chapter]
contents =
  [ ("Introduction.elm", "An Introduction to Elm")
  , ("Types.elm", "Types")
  , ("Test.elm", "Another Chapter")
  ]

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
