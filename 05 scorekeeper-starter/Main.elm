module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

-- MODEL

type alias Model  =
  { players : List Player
  , name : String
  , playerId : Maybe Int                 -- When it says maybe it is like saying it is a nullable value
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
                { model | name = ""
                , playerId = Nothing }

        Save ->
            -- let -- old thought
            --     players = model.players
            --     newPlayers = players ++ { id = 0 , name = model.name , points = 0 }
            -- in
            --     { model | model.players =  newPlayers }
            --         Debug.log "Save Model " ++ model

            if String.isEmpty model.name then
                model
            else
                save model

        _ ->
            model

save model =
    case model.playerId of
        Just id ->
            edit model id

        Nothing ->
            add model

add : Model -> Model
add model =
    let
        newplayer = Player (List.length model.players) model.name 0
        players = model.players
        newplayers = newplayer :: players
    in
        { model | players = newplayers, name = "" }

-- 1. find player in the models player list and set its name to the newly edited value
-- 2. need to update plays to make sure plays show the updated name
edit : Model -> Int -> Model
edit model id =
    let
        newPlayers = List.map (\player ->
                                   if player.id == id then
                                       { player | name = model.name }
                                   else
                                       player) model.players

        newPlays = List.map (\play ->
                                 if play.playerId == id then
                                     { play | name = model.name }
                                 else
                                     play ) model.plays
    in
        { model | players = newPlayers, plays = newPlays, name = "", playerId = Nothing }


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
              -- <input type="text" placeholder="Add edit" value="{model.name}" onInput="Input" />
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
