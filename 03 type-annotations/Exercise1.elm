import Html

-- 1. Create a new file `Exercise1.elm`
-- 2. Add the following list to your file

-- 2.1. Create a type alias for the cart records in `Exercise1.elm`.

type alias Item =
  { name : String
  , qty : Int
  , freeQty : Int
  }

cart : List Item
cart =
    [ { name = "Lemon", qty = 1, freeQty = 0 }
    , { name = "Apple", qty = 5, freeQty = 0 }
    , { name = "Pear", qty = 10, freeQty = 0 }
    ]

-- 3. Write the logic necessary to set the `freeQty` of each record using the following logic:
-- Purchases of 5 or more receive 1 free.  Purchases of 10 or more receive 3 free.

-- free Int -> Int -> Item -> Item
-- vvv GOOD
-- free : Int -> Int -> { name : String  , qty : Int  , freeQty : Int  } ->  { name : String  , qty : Int  , freeQty : Int  }

free : Int -> Int -> Item -> Item
free req extras item =
    if item.qty >= req then
        {item | freeQty = extras}
    else
        item

newcart : List Item
newcart =
    List.map ((free 5 1) >> (free 10 3)) cart

main : Html.Html msg
main =
    newcart
    |> toString
    |> Html.text
