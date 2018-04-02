import Html
import String

 -- Create a function that uppercases names **longer than** 10 characters


main =
    Html.text ((check10 name) ++ (suffix name))


name =
    "Charles M Magid"


check10 name =
    if String.length name >= 10 then
        upName name
    else
        name

upName name =
    String.toUpper name


suffix name =
    " - name length: " ++ (toString (String.length name))
