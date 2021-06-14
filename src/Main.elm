module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    }


init : Model
init =
    Model "" "" ""



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ viewInput "text" "Name" model.name Name
        , viewInput "password" "Password" model.password Password
        , viewInput "password" "Re-enter password" model.passwordAgain PasswordAgain
        , viewValidation model
        ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    input [ type_ t, placeholder p, value v, onInput toMsg ] []


viewValidation : Model -> Html msg
viewValidation model =
    if String.isEmpty model.password then
        div [] []

    else if String.length model.password < 8 then
        passwordError "password is too short"

    else if not (String.any Char.isDigit model.password) then
        passwordError "password must contain digit"

    else if model.password /= model.passwordAgain then
        passwordError "password do not match!"

    else
        passwordInfo "OK"


passwordInfo : String -> Html msg
passwordInfo msg =
    div [ style "color" "green" ] [ text msg ]


passwordError : String -> Html msg
passwordError msg =
    div [ style "color" "red" ] [ text msg ]
