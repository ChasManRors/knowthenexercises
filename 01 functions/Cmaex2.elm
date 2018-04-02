module Main exposing (..)

import Html
import String

name =
    "charles magid"
    -- "charles"

namesize =
    String.length name

shouldupcase =
    namesize > 10

result =
    if shouldupcase then
        String.toUpper name
    else
        name

appended =
     result
     ++ " - name length: "
     ++ (toString namesize)


main : Html.Html msg
main =
    appended
    |> Html.text
