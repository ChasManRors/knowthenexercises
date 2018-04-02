module Main exposing (..)

import Html

-- 2.1. Create a type alias for the cart records in `Exercise1.elm`.
type alias Item = { name : String
                  , qty : Int
                  , freeQty : Int }

-- 2.2. Add the appropriate type annotations to all values and functions used in Exercise1.
cart : List Item
cart =
    [ { name = "Lemon", qty = 1, freeQty = 0 }
    , { name = "Apple", qty = 5, freeQty = 0 }
    , { name = "Pear", qty = 10, freeQty = 0 }
    ]

 -- 1.3. Write the logic necessary to set the `freeQty` of each record using the following logic:
-- Purchases of 5 or more receive 1 free.  Purchases of 10 or more receive 3 free.

numberFree : Int -> Int -> Item -> Item
numberFree minNumForDiscount numberUGetFree item =
    if item.qty >= minNumForDiscount then
        { item | freeQty = numberUGetFree }
    else
        item

main : Html.Html msg
main =
    -- (List.map (numberFree 10 3) (List.map (numberFree 5 1) cart))
    List.map ((numberFree 5 1) >> (numberFree 10 3)) cart
    |> toString
    |> Html.text
