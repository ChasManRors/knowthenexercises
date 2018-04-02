module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

-- MODEL

type alias Model  =
  { players : List Player
  , name : String
  , playerId : Maybe Int
  , plays : List Play
  }


type alias Player =
  { id : Int
  , name : String
  , points : Int
  }

type alias Play =
  { id : Int
  , playerId : Int
  , name : String
  , points : Int
  }

initModel : Model
initModel =
  { players = []
  , name = ""
  , playerId = Nothing
  , plays = []
  }


-- UPDATE

type Msg
    = Edit Player
    | Score Player Int
    | Input String
    | Save
    | Cancel
    | DeletePlay Play

update : Msg -> Model -> Model
update msg model =
    case msg of
        Input name ->
            Debug.log "Input Updated Model"
                { model | name = name }

        Cancel ->
            Debug.log "Cancel Model"
                { model | name = "" }

        -- Save ->
        --     Debug.log "Save Model"
                -- { model | model.players = { id = 0
                --                           , name = model.name
                --                           , points = 0
                --                           }
                -- }


        _ ->
            model

-- VIEW

view : Model -> Html Msg
view model =
    div [ class "scoreboard"]
        [ h1 [] [ text "Score Keeper CMA" ]
        , playerForm model
        , p [] [ text (toString model)]
        ]

playerForm : Model -> Html Msg
playerForm model =
    Html.form [ onSubmit Save ]
        [ input
              [ type_ "text"
              , placeholder "Add/Edit Player ..."
              , onInput Input
              , value model.name
              ]
              []
        , button [ type_ "submit"
                 , onClick Save
                 ] [ text "Save" ]
        , button [ type_ "button"
                 , onClick Cancel
                 , value  model.name ]  [ text "Cancel" ]
        ]

-- main : Html.Html msg
-- main =
--     text "Score Keeper!"


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initModel
        , update = update
        , view = view
        }
