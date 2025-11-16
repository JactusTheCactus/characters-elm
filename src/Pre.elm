module Pre exposing (Character, char, em, group, omega, schwa)
import Char exposing (fromCode)
import Html exposing (Html, br, span, td, text, tr)
import Html.Attributes exposing (attribute, class, id)
import List exposing (map, singleton)
import String exposing (dropLeft, fromChar, join, left, toLower, toUpper, words)
uni : Int -> String
uni n =
    n
        |> fromCode
        |> fromChar
acute : String
acute =
    uni 0x301
grave : String
grave =
    uni 0x300
hacek : String
hacek =
    uni 0x30C
omega : String
omega =
    uni 0x3C9
schwa : String
schwa =
    uni 0x259
em : Int -> String -> String
em n c =
    c
        ++ (case n of
                1 ->
                    acute
                2 ->
                    grave
                3 ->
                    hacek
                _ ->
                    ""
           )
group : Int -> List String -> String
group n list =
    "["
        ++ (list
                |> join
                    (if n > 0 then
                        "-"
                            |> em n
                     else
                        "-"
                    )
           )
        ++ "]"
capitalize : String -> String
capitalize str =
    str
        |> words
        |> map
            (\s ->
                [ s
                    |> left 1
                    |> toUpper
                , s
                    |> dropLeft 1
                    |> toLower
                ]
                    |> join ""
            )
        |> join " "
type alias Character =
    { names :
        { name : String
        , pronunciation : String
        }
    , species : String
    , sex : String
    , extra : String
    }
char : Character -> Html msg
char character =
    tr
        [ "character"
            |> class
        , character.sex
            |> toLower
            |> attribute "data-sex"
        , character.names.name
            |> words
            |> join "-"
            |> toLower
            |> id
        ]
        [ td
            ("names"
                |> class
                |> singleton
            )
            [ (character.names.name
                |> capitalize
                |> text
                |> singleton
              )
                |> span
                    ("name"
                        |> class
                        |> singleton
                    )
            , []
                |> br []
            , (character.names.pronunciation
                |> capitalize
                |> text
                |> singleton
              )
                |> span
                    ("pronunciation"
                        |> class
                        |> singleton
                    )
            ]
        , (character.species
            |> capitalize
            |> text
            |> singleton
          )
            |> td
                ("species"
                    |> class
                    |> singleton
                )
        , (character.extra
            |> text
            |> singleton
          )
            |> td
                ("extra"
                    |> class
                    |> singleton
                )
        ]
