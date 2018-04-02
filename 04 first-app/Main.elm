module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- model


type alias Model =
    { total : Int
    , val : String
    }


initModel : Model
initModel =
    Model 0 ""


-- update


type Msg
    = AddCalorie
    | Val String
    | Clear




update : Msg -> Model -> Model
update msg model =
    case msg of
        AddCalorie ->
            -- { model | total = model.total + 1} -- temporary
            { model | total = model.total + Result.withDefault 0 (String.toInt model.val) }

        Clear ->
            { model | total = 0, val = ""}

        Val val ->
            { model | val = val }


-- view


view : Model -> Html Msg
view model =
    div []
        [ h3 []
            [ text ("Total Calories: " ++ (toString model.total)) ]
                        -- input : List (Attribute msg) -> List (Html msg) -> Html msg
        , input [ type_ "text"
                , onInput Val
                -- , value
                --       (if model.total == 0 then
                --            ""
                --        else
                --            toString model.total)
                ] []
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


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initModel
        , update = update
        , view = view
        }




-- onInput : Signal.Address a -> (String -> a) -> Attribute
-- onInput address contentToValue =
--     on "input" targetValue (\str -> Signal.message addr (contentToValue str))
