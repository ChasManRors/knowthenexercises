import Html
import String

-- (~+) a b =
--     a + b + 0.1


-- oldresult =
--     1 ~+ 2

-- result =
--     (~+) 2 3


-- result s1 s2 =
--     s1 ~= s2 |> toString

-- headOfString s =
--     List.head (String.split "" s)

-- main =
--     Html.text (result "foo" "bar")

-- Call your new function `~=` as a prefix function.


-- Write an infix function named `~=` that takes two Strings and returns True when the first letter of each string is the same.

-- 1. Call your new function `~=` as a prefix function.
-- 2. Display the result on the page

-- (~=) s1 s2 =
--     (String.left 1 s1) == (String.left 1 s2)

-- main =
--     (~=) "foo" "farmer"
--      |> toString
--      |> Html.text

-- ### Exercise 3
-- 1. Using function composition, create a function named `wordCount` that returns the number of words in a sentence.

-- wordCount sentence =
--     String.split " " >> List.length

getlist str =
    String.split " " str

listcount lst =
    List.length lst

wordCount = getlist >> listcount

-- 2. Call the `wordCount` function with any sentence and display the result on the page.

-- main =
--     Html.text (toString (wordCount "function with any sentence and display the result on the page."))

main =
    "function with any sentence and display the result on the page."
    |> wordCount
    |> toString
    |> Html.text
