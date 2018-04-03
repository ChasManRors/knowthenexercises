module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- MODEL


type alias Model =
    { players : List Player
    , name : String
    , playerId : Maybe Int -- When it says maybe it is like saying it is a nullable value
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
                { model
                    | name = ""
                    , playerId = Nothing
                }

        Save ->
            if String.isEmpty model.name then
                model
            else
                save model

        Score player points ->
            score model player points

        Edit player ->
            { model | name = player.name, playerId = Just player.id }

        DeletePlay play ->
            deletePlay model play

        -- _ ->
        --     model


deletePlay model deletable =
    let
        newPlays =
            List.filter
                (\play ->
                     if play.id /= deletable.id then
                         True
                     else
                         False)
                 model.plays
    in
        { model | plays = newPlays }


-- when a score happens a new play must be added to the plays


score
    : { b | players : List { a | id : Int, points : Int }, plays : List Play }
    -> { c | name : String, id : Int }
    -> Int
    -> { b | players : List { a | id : Int, points : Int }, plays : List Play }
score model scorer points =
    let
        newPlayers =
            List.map
                (\player ->
                    if player.id == scorer.id then
                        { player | points = player.points + points }
                    else
                        player
                )
                model.players

        play =
            Play (List.length model.plays) scorer.id scorer.name points
    in
    { model | players = newPlayers, plays = play :: model.plays }



-- let
--     newPoints = player.points + points
--     newPlay = Play <id> player.id <name> points
--     newPlayer = Player player.id player.name newPoints
--     players_sans_player = xxxx
--     newPlayers = newPlayer :: players_sans_player
save
    : { name : String
    , playerId : Maybe Int
    , players : List { name : String, id : Int, points : Int }
    , plays : List Play
    }
    -> Model
-- in
--     { model | plays = model.plays :: newPlay, players = newPlayers}


save model =
    case model.playerId of
        Just id ->
            edit model id

        Nothing ->
            add model


add : Model -> Model
add model =
    let
        newplayer =
            Player (List.length model.players) model.name 0

        players =
            model.players

        newplayers =
            newplayer :: players
    in
    { model | players = newplayers, name = "" }



-- 1. find player in the models player list and set its name to the newly edited value
-- 2. need to update plays to make sure plays show the updated name


edit : Model -> Int -> Model
edit model id =
    let
        newPlayers =
            List.map
                (\player ->
                    if player.id == id then
                        { player | name = model.name }
                    else
                        player
                )
                model.players

        newPlays =
            List.map
                (\play ->
                    if play.playerId == id then
                        { play | name = model.name }
                    else
                        play
                )
                model.plays
    in
    { model | players = newPlayers, plays = newPlays, name = "", playerId = Nothing }



-- VIEW

view : Model -> Html Msg
view model =
    div [ class "scoreboard" ]
        [ h1 [] [ text "Score Keeper CMA" ]
        , playerSection model
        , playerForm model
        , playSection model
        , p [] [ text (toString model) ]
        ]


playSection model =
    div []
        [ playListHeader
        , playList model
        ]


playList model =
    model.plays
        |> List.map play
        |> ul []

play : Play -> Html Msg
play play =
    li []
        [ i [ class "remove"
            , onClick (DeletePlay play)] []
        , div [] [ text play.name ]
        , div [] [ text (toString play.points) ]
        ]

playListHeader : Html Msg
playListHeader =
    header []
        [ div [] [ text "Plays"]
        , div [] [ text "Points"]
        ]


-- playerSection
--   player list heading
--   player list
--     player
--   total points


playerSection : Model -> Html Msg
playerSection model =
    div []
        [ playerListHeader
        , playerList model
        , pointTotal model
-- playerList : { a | players : List Player } -> Html Msg
        ]


playerListHeader =
    header []
        [ div [] [ text "Name" ]
        , div [] [ text "Points" ]
        ]



playerList model =
    -- ul []
    --     (List.map player (List.sortBy .name model.players))
    model.players
        |> List.sortBy .name
        |> List.map player
        |> ul []


-- pointTotal : { b | plays : List { a | points : number } } -> Html msg
pointTotal model =
    let
        all_points =
            List.map .points model.plays

        total =
            List.sum all_points
    in
    footer []
        [ div [] [ text "Total:" ]
        , div [] [ text (toString total) ]
        ]


player : Player -> Html Msg
player player =
    li []
        [ i
            [ class "edit"
            , onClick (Edit player)
            ]
            []
        , div []
            [ text player.name ]
        , button
            [ type_ "button"
            , onClick (Score player 2)
            ]
            [ text "2pt" ]
        , button
            [ type_ "button"
            , onClick (Score player 3)
            ]
            [ text "3pt" ]
        , div []
            [ text (toString player.points) ]
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
        , button
            [ type_ "submit"
            , onClick Save
            ]
            [ text "Save" ]
        , button
            [ type_ "button"
            , onClick Cancel
            , value model.name
            ]
            [ text "Cancel" ]
        ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initModel
        , update = update
        , view = view
        }
