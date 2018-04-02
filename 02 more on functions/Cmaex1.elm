module Main exposing (..)

import Html exposing (..)
import String exposing (..)

(~=) str1 str2 =
    left 1 str1 == left 1 str2

results =
    -- "Charles" ~= "Karen"
    "Charles" ~= "Carol"

main : Html.Html msg
main =
    results
    |> toString
    |> Html.text
