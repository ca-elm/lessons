import Website.Figure (diagram, timeline)
import Website.Text (code, output)
import Website.Template (lesson)

words w = flow down [width w [markdown|

An Introduction to Elm
======================

Displaying things
-----------------

Tell Elm to display a number:

    main = asText 12

What does this mean?

|], diagram1 w, width w [markdown|

You can put any number you like there:

    main = asText 777

Math
----

I can never remember what 12 × 13 is, so let's get Elm to do it for me. Elm understands the normal math operators `+`, `-`, `/`, and `*`, as well as `x^y` for x<sup>y</sup>.

    main = asText (12 * 13)

Why do we need parentheses?

    main = asText 12 * 13

This could mean `main = (asText 12) * 13` or `main = asText (12 * 13)`. Elm always chooses the first one, so we have to tell it to use the second one because we want to multiply the numbers *and then* convert the *output* (whatever 12 × 13 is) to an Element. It doesn't make much sense the other way around (what do you get when you multiply 13 by 10-point black Courier New text in the top-left corner of the screen?), which is why Elm will complain — rather noisily — if we do it that way, or leave the parentheses off entirely:

<div class=output>

    Type error on line 1, column 8 to 22:
           (asText 12) * 13

      Expected Type: number
        Actual Type: Graphics.Element.Element

</div>

Makes sense: Elm wants a number to multiply by 13, but we're giving it an Element.

Lists
-----

Speaking of 12 × 13, I kind of like these numbers that you get when you multiply a number by the one after it. I don't know why. They're pretty cool, though. Let's make a list of them:

    main = asText [1 * 2, 2 * 3, 3 * 4, 4 * 5, 5 * 6, 6 * 7]

Square brackets make a list. We put a comma between each item to tell Elm where one ends and the next begins. We don't need parentheses because `[` and `]` already make it clear where the list starts and ends, so there aren't two different ways to interpret it.

Functions
---------

I'm getting pretty tired of typing all these stars. Let's make a function that does that for me:

    f x = x * (x + 1)

What does this mean?

|], diagram2 w, width w [markdown|

    main = asText [f 1, f 2, f 3, f 4, f 5, f 6]

We can use our new `f` function like we used `asText` before — just `f` and then a space and then an input, like `2` or `5`.

Higher-order functions
----------------------

That was a bit less repetitive, but I still had to type `f` a bunch of times. If only we could use the list as our input instead:

    main = asText (f [1, 2, 3, 4, 5, 6])

Elm does not like that:

<div class=output>

    Type error on line 3, column 18 to 36:
           [1,2,3,4,5,6]

      Expected Type: [a]
        Actual Type: number

</div>

It looks like `f` only works on number inputs, but we're giving it a list input. We can make `f` into a function that works on lists, though:

    fList = map f

This is another definition like `main`. We're defining `fList` to be the same thing as `map f`. But what's `map f`? Well, `map` is another built-in function and we're using it on `f`. So instead of taking *numbers* as input, `map` takes *functions* as input and turns them into different functions as output. Map turns our function `f` which operates on numbers into a function that operates on *lists* of numbers, by using `f` on each number in the list. So when we say:

    main = asText (fList [1, 2, 3, 4, 5, 6])

That's the same thing as `main = asText [f 1, f 2, f 3, f 4, f 5, f 6]`.

Now we've seen two different ways to define functions: the `f x = …` way, where we name the input `x` and then give Elm the output in terms of `x`; and the `fList = …` way, where we make a function out of other functions. We don't need to name the input because `map` and `f` together tell Elm what to do with it, so we don't need to say anything more about it.

Challenge Time
--------------

OK, so my sequence is cool, but that x<sup>2</sup> + 1 thing sounds pretty cool too. Why don't you make a function (call it `g`, if you like) which calculates the numbers in this sequence:

- 1 × 1 + 1 = 2
- 2 × 2 + 1 = 5
- 3 × 3 + 1 = 10
- 4 × 4 + 1 = 17
- …

Then make `gList` to save yourself some time and show a list of the first ten or so on the screen. It should look something like this:

|], output w <| map (\x -> x^2 + 1) [1..10], width w [markdown|

Signals
-------

Text that just sits there on the screen and does nothing isn't very interesting. But how do we make it change? Enter signals.

Signals are just things that change over time, like your computer's clock (a number) or the position of your mouse cursor (a point) or the current temperature (another number). We say that a signal that changes from one number to another is a *signal of numbers*.

Up until now, we've been telling Elm that `main` is an Element. Elements don't change, so if you leave your Elm program running for an hour and come back the screen will look exactly the same. But we can also tell Elm that `main` is a signal of Elements: a signal that changes from one Element to another over time.

`(every second)` is a signal of the current time, which updates every second. It looks something like this:

|], timeline1 w, width w [markdown|

That's not the same representation of the time that we usually see — it's just a big number that keeps increasing — but let's use it to try out these signal things.

`(every second)` is a signal of *numbers*, though. We have to convert it to a signal of Elements. We could try using `asText` on it:

    main = asText (every second)

But this gives us:

|], output w <| every second, width w [markdown|

Not very helpful. `asText` takes anything and converts it to an Element — not a *signal of* Elements. Since the values in the signal can change over time, the only thing that stays the same is that it's a signal — so that's what `asText` tells us. What we really want is to use `asText` on each of the *values* of `(every second)` instead the signal itself, like this:

|], timeline2 w, width w [markdown|

Luckily, Elm has a function that does exactly this.

    asTextSignal = lift asText

`lift` is like `map`: it takes a function as input and outputs a different function that operates on signals as input. This new function takes a `Signal` as input and outputs a new `Signal` whose values correspond to the output of the function for each value of the input signal. So now we can use `asTextSignal` to convert our signal of numbers to a signal of Elements.

    main = asTextSignal (every second)
|]]

diagram1 = diagram
  [ ("main ",   [markdown| `main` tells Elm what to show on the screen. |])
  , ("= ",      [markdown| `=` tells Elm that `main` is the same thing as the stuff on the right side. We call this process *defining* `main`, so the stuff after `=` is the *definition* of `main`. |])
  , ("asText ", [markdown| `asText` turns something (like a number) into something else (an Element) that can show up on the screen. It's a function, which means it converts an input to an output. In this case, `100` is the input, and what you see on the screen is the output. Note that what you see on the screen isn't just a number — it's a number in black, 10-point Courier New at the top-left corner of the screen. This is the kind of information that Elements store but numbers do not. <p>When we want to use a function, we write the function and then its input, separated by a space. This is called *applying* the function. |])
  , ("12 ",     [markdown| `100` is just a number. When we write a number the way we normally would, Elm gives us a number. |])
  ]

diagram2 = diagram
  [ ("f ",             [markdown| `f` is the name of the function. We need a name (like `asText`) so that we can use it later. |])
  , ("x ",             [markdown| `x` is the input to `f`. Or, more accurately, it's a name we use for the input to `f`. Whenever we use the function, Elm replaces every `x` in the definition of `f` (remember, that's the stuff after the `=` sign) with the input we give it, like 12 or 5. |])
  , ("= x * (x + 1) ", [markdown| `x * (x + 1)` is more of the stuff we've seen before, except now it has an `x` in it. We need parentheses around `x + 1` because Elm goes by the same order of operations we do — multiplication and division, then addition and subtraction. We don't want x<sup>2</sup> + 1; we want x · (x + 1). |])
  ]

timeline1 = timeline <| map (\t -> (1, centered << toText << show <| 173081 + t * 1001)) [1 .. 4]
timeline2 = timeline
  [ (1, [markdown|`asText 173081`|])
  , (1, [markdown|`asText 174082`|])
  , (1, [markdown|`asText 175083`|])
  , (1, [markdown|`asText 176084`|])
  ]
--timeline2 = timeline <| map (\t -> (1, code <| "asText " ++ show (173081 + t * 1001))) [1 .. 4]

main = lesson words
