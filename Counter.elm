import Html exposing (Html, button, div, text, li, ul)
import Html.App as App
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)
import Debug exposing (log)

main =
  App.beginnerProgram { model = { entries = [], n = 0, rep = "0" }, view = view, update = update }


{--------------------------------------}

type alias Entry =
        {
          n: Int
          , rep: String
        }

type alias Model =
        {
          entries: List Entry
          , n: Int
          , rep: String
        }

type Msg = Increment | Decrement | AddEntry

{----------------------------------------}

update msg model =
  case msg of
    AddEntry -> addEntry model
    Increment ->
        { model | n = model.n + 1, rep = model.rep ++ toString (model.n + 1) }
    Decrement ->
        { model | n = model.n - 1, rep = model.rep ++ toString (model.n - 1) }

view model = showCounter model

addEntry: Model -> Model
addEntry model = { model | n = 0, rep = "0", entries = { n = model.n, rep = model.rep } :: model.entries }

showEntries: Model -> Html Msg
showEntries model =
        ul [] (List.map showEntry model.entries)

showEntry: Entry -> Html Msg
showEntry model =
        li [] [text model.rep]

showCounter: Model -> Html Msg
showCounter model =
  div [ style containerStyle ]
    [ button [ style btnStyle, onClick AddEntry ] [ text "Add Entry" ]
      ,div [] [
         button [ style btnStyle, onClick Decrement ] [ text "-" ]
        , div [style countedStyle] [ text model.rep ]
        , button [ style btnStyle, onClick Increment ] [ text "+" ]
      ]
    , showEntries model
    ]

btnStyle: List (String, String)
btnStyle = [("width", "100%")]

countedStyle: List (String, String)
countedStyle = [("text-align", "center")]

containerStyle: List (String, String)
containerStyle = [("width", "500px"), ("margin", "auto")]
