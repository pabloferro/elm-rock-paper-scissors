module Main exposing (..)

import Html exposing (Html, text, div, h1, img, button)
import Html.Attributes exposing (src, class, classList, type_)
import Html.Events exposing (onClick)

---- MODEL ----


type Element = Rock | Paper | Scissors

type alias Model = Maybe Element

init : ( Model, Cmd Msg )
init =
    ( Nothing, Cmd.none )



---- UPDATE ----


type Msg
    = SelectElement Element


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        SelectElement element ->
            (Just element, Cmd.none)



---- VIEW ----

isElementSelected : Model -> Element -> Bool
isElementSelected model element =
    case model of
        Nothing ->
            False
        Just selectedElement ->
            element == selectedElement

choice : Model -> Element -> String -> (Html Msg)
choice model element content =
    button [ classList [ ("choice", True)
                       , ("choice-selected", isElementSelected model element)
                       ]
           , type_ "button"
           , onClick (SelectElement element)
           ] [ text content ]

elementToString : Element -> String
elementToString element =
    case element of
        Rock ->
            "Piedra"
        Paper ->
            "Papel"
        Scissors ->
            "Tijera"

selectionToString : Model -> String
selectionToString model =
    case model of
        Nothing ->
            "Elige un elemento"
        Just element ->
            elementToString element

view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Piedra Papel o Tijera" ]
        , div [] [ text (selectionToString model) ]
        , div [ class "choices" ]
            [ choice model Rock "✊"
            , choice model Paper "🖐"
            , choice model Scissors "✌️"
            ]
        ]

---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
