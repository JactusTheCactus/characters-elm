module Main exposing (main)
import Array exposing (..)
import Html exposing (table, text, th, tr)
import Html.Attributes exposing (id)
import Pre exposing (..)
main : Html.Html msg
main =
    table [ id "characters" ]
        [ tr
            []
            [ th [] [ text "Name" ]
            , th [] [ text "Species" ]
            , th [] [ text "Extra" ]
            ]
        , char
            { names =
                { name = "Hound"
                , pro = "H" ++ group 0 "a" "u" ++ "n" ++ "d"
                }
            , species = "Changeling"
            , sex = "Female"
            , extra = "Shapeshifts into a large, black Wolf"
            }
        , char
            { names =
                { name = "Morrigan"
                , pro = "M" ++ em 1 omega ++ "r" ++ schwa ++ "g" ++ em 2 "y" ++ "n"
                }
            , species = "Reaper"
            , sex = "Female"
            , extra = "Wields a scythe"
            }
        ]
