module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- model


type alias Model =
    Int


initModel : Model
initModel =
    0


type Msg
    = AddCalorie
    | Clear


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddCalorie ->
            model + 1

        Clear ->
            initModel

view : Model -> Html Msg
view model =
    div []
        [ h3 []
            [ text ("Total Calories: " ++ toString model) ]
        , button
            [ type_ "button"
            , onClick AddCalorie
            ]
            [ text "Add" ]
        , button
            [ type_ "button"
            , onClick Clear
            ]
            [ text "Clear" ]
        ]



-- main : Html.Html msg
-- main =
--     -- AddCalorie initModel
--     |> toString
--     |> Html.text


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initModel
        , update = update
        , view = view
        }
