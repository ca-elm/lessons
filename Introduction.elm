import Website.Figure (diagram, timeline)
import Website.Text (code, output)
import Website.Template (chapter)
import KaTeX as Math

words w = let md = width w << Math.markdown in flow down [md [markdown|

An Introduction to Elm
======================

Displaying things
-----------------

Tell Elm to display a number:

    main = asText 12

What does this mean?

|], diagram w

  [ ("main ",   [markdown| `main` tells Elm what to show on the screen. |])
  , ("= ",      [markdown| `=` tells Elm that `main` is the same thing as the stuff on the right side. We call this process *defining* `main`, so the stuff after `=` is the *definition* of `main`. |])
  , ("asText ", [markdown| `asText` turns something (like a number) into something else (an Element) that can show up on the screen. It's a function, which means it converts an input to an output. In this case, `100` is the input, and what you see on the screen is the output. Note that what you see on the screen isn't just a number—it's a number in black, 10-point Courier New at the top-left corner of the screen. This is the kind of information that Elements store but numbers do not. <p>When we want to use a function, we write the function and then its input, separated by a space. This is called *applying* the function. |])
  , ("12 ",     [markdown| `100` is just a number. When we write a number the way we normally would, Elm gives us a number. |])

  ], md [markdown|

You can put any number you like there:

    main = asText 777

Math
----

I can never remember what $`12 \times 13`$ is, so let's get Elm to do it for me. Elm understands the normal math operators `+`, `-`, `/`, and `*`, as well as `x^y` for $`x^y`$.

    main = asText (12 * 13)

Why do we need parentheses?

    main = asText 12 * 13

This could mean `main = (asText 12) * 13` or `main = asText (12 * 13)`. Elm always chooses the first one, so we have to tell it to use the second one because we want to multiply the numbers *and then* convert the *output* (whatever $`12 \times 13`$ is) to an Element. It doesn't make much sense the other way around (what do you get when you multiply $`13`$ by 10-point black Courier New text in the top-left corner of the screen?), which is why Elm will complain—rather noisily—if we do it that way or leave the parentheses off entirely:

<div class=output>

    Type error on line 1, column 8 to 22:
           (asText 12) * 13

      Expected Type: number
        Actual Type: Graphics.Element.Element

</div>

Makes sense: Elm wants a number to multiply by $`13`$, but we're giving it an Element.

Lists
-----

Speaking of $`12 \times 13`$, I kind of like these numbers that you get when you multiply a number by the one after it. I don't know why. They're pretty cool, though. Let's make a list of them:

    main = asText [1 * 2, 2 * 3, 3 * 4, 4 * 5, 5 * 6, 6 * 7]

Square brackets make a list. We put a comma between each item to tell Elm where one ends and the next begins. We don't need parentheses because `[` and `]` already make it clear where the list starts and ends, so there aren't two different ways to interpret it.

Functions
---------

I'm getting pretty tired of typing all these stars. Let's make a function that does that for me:

    f x = x * (x + 1)

What does this mean?

|], diagram w

  [ ("f ", [markdown| `f` is the name of the function. We need a name (like `asText`) so that we can use it later. |])
  , ("x ", [markdown| `x` is the input to `f`. Or, more accurately, it's a name we use for the input to `f`. Whenever we use the function, Elm replaces every `x` in the definition of `f` (remember, that's the stuff after the `=` sign) with the input we give it, like `12` or `5`. |])
  , ("= x * (x + 1) ", Math.markdown [markdown| `x * (x + 1)` is more of the stuff we've seen before, except now it has an `x` in it. We need parentheses around `x + 1` because Elm goes by the same order of operations we do—multiplication and division, then addition and subtraction. We don't want $`x^2 + 1`$; we want $`x \times (x + 1)`$. |])

  ], md [markdown|

    main = asText [f 1, f 2, f 3, f 4, f 5, f 6]

We can use our new `f` function like we used `asText` before—just `f` and then a space and then an input, like `2` or `5`.

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

Challenge time
--------------

OK, so my sequence is cool, but that $`x^2 + 1`$ thing sounds pretty cool too. Why don't you make a function (call it `g`, if you like) which calculates the numbers in this sequence:

    $$$
    1 \times 1 + 1 = 2
    2 \times 2 + 1 = 5
    3 \times 3 + 1 = 10
    4 \times 4 + 1 = 17
    \ldots

Then make `gList` to save yourself some time and show a list of the first ten or so on the screen. It should look something like this:

|], output w <| map (\x -> x^2 + 1) [1..10], md [markdown|

Signals
-------

Text that just sits there on the screen and does nothing isn't very interesting. But how do we make it change? Enter signals.

Signals are just things that change over time, like your computer's clock (a number) or the position of your mouse cursor (a point) or the current temperature (another number). We say that a signal that changes from one number to another is a *signal of numbers*.

Up until now, we've been telling Elm that `main` is an Element. Elements don't change, so if you leave your Elm program running for an hour and come back the screen will look exactly the same. But we can also tell Elm that `main` is a signal of Elements: a signal that changes from one Element to another over time.

`(every second)` is a signal of the current time, which updates every second. It looks something like this:

|], timeline w <| map (\t -> (1, Math.block w << show <| 173081 + t * 1001)) [1 .. 4], md [markdown|

That's not the same representation of the time that we usually see—it's just a big number that keeps increasing—but let's use it to try out these signal things.

`(every second)` is a signal of *numbers*, though. We have to convert it to a signal of Elements. We could try using `asText` on it:

    main = asText (every second)

But this gives us:

|], output w <| every second, md [markdown|

Not very helpful. `asText` takes anything and converts it to an Element—not a *signal of* Elements. Since the values in the signal can change over time, the only thing that stays the same is that it's a signal—so that's what `asText` tells us. What we really want is to use `asText` on each of the *values* of `(every second)` instead the signal itself, like this:

|], timeline w
  [ (1, [markdown|<div style="text-align:center"><code>asText 173081</code></div>|])
  , (1, [markdown|<div style="text-align:center"><code>asText 174082</code></div>|])
  , (1, [markdown|<div style="text-align:center"><code>asText 175083</code></div>|])
  , (1, [markdown|<div style="text-align:center"><code>asText 176084</code></div>|])
-- timeline w <| map (\t -> (1, code <| "asText " ++ show (173081 + t * 1001))) [1 .. 4]

  ], md [markdown|

Luckily, Elm has a function that does exactly this.

    asTextSignal = lift asText

`lift` is like `map`: it takes a function as input and outputs a different function that operates on signals. This new function takes a `Signal` as input and outputs a new `Signal` whose values correspond to the output of the function for each value of the input signal. So now we can use `asTextSignal` to convert our signal of numbers to a signal of Elements.

    main = asTextSignal (every second)

Those numbers are still too big, though. Let's use the `count` function to turn `(every second)` into something more manageable. `count` takes a signal as input and outputs a signal of the number of times that signal has changed, so `(count (every second))` starts at zero and increases by $`1`$ each second:

|], timeline w <| map (\t -> (1, Math.block w <| show t)) [0 .. 3], md [markdown|

`lift` works on functions we define, too:

    main = asTextSignal (fSignal (count (every second)))
    fSignal = lift f

|], timeline w <| map (\t -> (1, output w <| t * (t + 1))) [0 .. 3], md [markdown|

Challenge time
--------------

I like cubes. Do you like cubes? Make a signal of successive cubes and then display it. You should get something like this:

|], timeline w <| map (\t -> (1, output w <| t * t * t)) [0 .. 3], md [markdown|

Currying
--------

Hold on. I'm done typing `fSignal = lift f` and `gSignal = lift g` and `asTextSignal = lift asText` and all those other function definitions just to use them once in my code. Since we're telling Elm that the stuff on the left side is the same as the stuff on the right side, why don't we just use the stuff on the right side without giving it a new name?

    main = (lift asText) (count (every second))

Cool. `(lift asText)` gives us a function as output, and we use that function right away on `(count (every second))`. This works for `map` too:

    main = asText ((map f) [1, 2, 3, 4, 5, 6])

In fact, this is so common that Elm lets us get rid of the parentheses:

    main = asText (map f [1, 2, 3, 4, 5, 6])

And now it looks like we're using `map` on `f` *and* the list instead of just on `f`—like `map` takes *two* things as input and then outputs a new list. The thing is, those two ways of looking at `map` are the same in Elm: A function that takes two inputs really just takes the first one and outputs a function; this new function takes the second one and outputs the final result of the function. This is called *currying* after Haskell Curry.

We've actually seen a lot of these pretend-two-input-functions before. They just didn't look like functions at the time, because they have weird names like `+` and `-` and `*`. When a function has a name like that, Elm treats it as an *infix operator*: it goes between its two inputs instead of before them. If you want to use an infix operator like a normal function, you can type parentheses around the operator name:

    main = asText ((+) 3 4)

Remember that this is the same thing as:

    main = asText (((+) 3) 4)

In other words, `(+)` takes a number and returns a *function* that adds that number to its input. We can use these "adding functions" like we would any other kind of function, for example:

    main = asText (map ((+) 3) [1, 2, 3, 4, 5])

or:

    main = lift asText (lift ((*) 3) (count (every second)))

We can define our own curried functions by adding more input names to their definitions:

    average x y = (x + y) / 2
    main = asText (average 4 10)

Currying in Mathematics
-----------------------

This is well and good, but it doesn't seem to fit nicely with what I've learned in math class! In math, we often see functions as in out machines. They take one input, and return one output. Now that we have more inputs everything is all messed up! As it turns out, currying is actually a mathematical idea! In math, we'd think of it like this.

Say we have the elm function:

    divide x y = y / x

in math notation, we would write this as:

    $$$
    divide(x, y) = \frac{y}{x}

Normally, you would just plug numbers into the equation, but we we want to explore currying. Let's try splitting up this function into two different functions. Let's say we want to find $`divide(2, 3)`$:

First, we can take our function and treat it as if it's a function with only x (we'll call it $`h(x)`$), and plug in two, our value for x:

    $$$
    h(x) = \frac{y}{x}

    h(2) = \frac{y}{2}

But wait! The result contains another variable! That can't be right. Well, what if we use this new expression like *another function*? Let's call this one $`g(y)`$:

    $$$
    g(y) = \frac{y}{2}

    g(3) = \frac{3}{2}

Hey look! $`g(3)`$ gives us $`3 / 2`$ which is exactly what we were looking for.

Let's recap. When elm is given:

|], diagram w

  [ ("divide ",   [markdown| `divide` Elm starts with the function divide, creating what we called h(x) |])
  , ("2 ", [markdown| `2` It then plugs two into h(x), resulting in *another* function which we called g(y) |])
  , ("3 ",      [markdown| `3` Finally, it will take g(y), and plug in three. |])

  ], md [markdown|

|]]

intro = chapter "Introduction.elm" words
main = intro.main
port title : String
port title = intro.title
