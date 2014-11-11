import Website.Figure (diagram)
import Website.Text (code, output)
import Website.Template (chapter)
import KaTeX as Math

words w = let md = width w << Math.markdown in flow down [md [markdown|

# Types

A Brief Recap
-------------

So far, we've worked with integers (and lists of them), functions, and signals. We did arithmetic with numbers, failed to do arithmetic with Courier New Text, applied functions, and lifted signals. So what are all these different types of things? As it turns out, we just answered our own question. They're all types!

What is a type?
---------------

A type is a way of describing (rather fittingly) a type of thing. The type Integer (called `Int` in Elm) for example describes any counting number. That's great and all, but there's no way there's an entire section on types if that's all there is to them... There must be more! I wonder what we'll find if we take a closer look at all the types we've seen thus far.

## Integers

In Elm, we use the word `Int` (an abbreviation of Integer) instead of Integer.

Integers represent any counting number.

So what do we know about them so far?

- You can raise them to powers (`^`)
- You can add them (`+`)
- You can subtract them (`-`)
- You can multiply them (`*`)
- You can divide them (`/`)

Hold on... I'm getting a weird feeling about these...

Let's try all these out and see if we can't figure out why I'm uneasy:

    $$$
    1 \hat{} 2 = 1

Looks fine to me.

    $$$
    1 + 2 = 3

Great. No problems here.

    $$$
    1 - 2 = -1

Ok, a little bit weirder. Now we get -1 for our answer, but there's nothing wrong with negative numbers.

    $$$
    1 * 2 = 2

Nothing wrong with that.

    $$$
    1 / 2 = 0.5

This gives us 0.5 which makes sense. Hold on though... Integers can only be counting numbers. What's going on!

0.5 must of some other type! Enter Floats.

### Floating Point Numbers

A floating point number represents *any* number. A Floating point number, or `Float` in Elm, can be as simple as `3` (yes, floats can *also* be whole numbers) or `0.5` or as complicated as `3.1415926536`. You could even write floats in scientific notation like this: `6.02e23` for $`6.02 \times 10^{23}`$ or `6.67e-11` for $`6.67 \times 10^{-11}`$

Ok... so they're just numbers. Why the fancy name? It turns out we call them floating point numbers just because the decimal point can *float* freely; meaning it can be placed anywhere.

You might be thinking: "Why the heck didn't we just start using floats! If they can represent counting numbers as well as decimal numbers, aren't they just better?" Don't be so quick to abandon our friend the Integer though! Floats have their issues. Let's try somthing out.

Go enter this into Elm and take a look at the result:

    main = asText (0.1 * 0.2)

Well that's weird. Not what you expected, huh?

Computers store numbers differently than we do, and there are some numbers that they don't represent exactly. 0.1 and 0.2 happen to be examples of those numbers. Normally, Elm guesses that when a number is *really* close to 0.1 it should probably be 0.1, and displays it as such. When you multiply 0.1 by 0.2 though, it stops being so clever and shows you the product of the actual two values it's storing. This is called *floating point rounding error*

Unlike Floats, integer values can be represented exactly. That's why we keep them separate: by distinguishing between Floats and Ints, we're able to know the correct-ness (or precision) of the numbers we're working with.

For example: let's say we're using Elm to count the amount of people that have entered a building. Things could get extremely messy if, due to rounding error, Elm started thinking there were $`4.999999999999999999`$ people in the building. When we're working with things that come in discrete, countable units, (like people) we tend to use Ints rather than floats. For most other things, floats tend to play nicely.

**Conversions**

Some things work on only Floats or Integers. So is there a way to go back and forth between them? Yup.

To get a `Float` from an `Int`, you can use `toFloat`. `toFloat` takes a `Int` and gives back a `Float` with the same value. Say you want to convert the integer two to a float, you just use `toFloat 2`.


But what about the other way around? How can you get an Integer from a float when not all Floats can be represented as Integers? Surprisingly, you actually have *more* ways to get an `Int` from a `Float`! 

The first option is rounding. This will simply give you the closest counting number to the given float. This follows the same rules for rounding you know from math. For example `round 2` gives `2`, `round 4.12` gives `4`, `round 2.92` gives 3, and `round 6.5` gives 7.

Your next choice is flooring. You might know this as "rounding down." Flooring a number simply gives you the first whole number that's less than or equal to the input. For example `floor 2.9` gives `2`, `floor 5` gives `5`, and `floor 1.2` gives 1.

What if we do the same thing as flooring, but go up? This is called ceiling. I'm sure you can guess why. In technical terms, ceiling a number gives you the first whole number greater than or equal to the input. `ceiling 2.9` gives `3`, `ceiling 5` gives `5`, and `ceiling 1.2` gives `2`.

And now our final method: truncating. Truncating literally just takes everything after the decimal place, and slices it off of the number. For example `truncate 7.124198` gives `7`, as with all our other conversions, `truncate 3` gives `3`, and `truncate 4.9` gives `4`. Truncating is the same as rounding in the direction of 0, meaning that negative numbers will be rounded up, and positive numbers rounded down.

**So What Can We do With Floats?**

Now that we know why we need both Floats and Ints, let's see what we can do with floats?

It turns out, that it's just about the same as what you can do with integers!

- You can raise them to powers (`^`)
- You can add them (`+`)
- You can subtract them (`-`)
- You can multiply them (`*`)
- You can divide them (`/`)

In fact, divide secretly only works on floats! When you do the operation:

    6 / 2  

Behind the scenes, Elm figures out that you probably mean for both six and two to be floats. This is called type inference, and Elm does it quite a bit. We'll talk about that more later.

If you want to explicitely divide two integers, you can use `//` instead of `/`. This divides two integers, and truncates the result. We call this integer division.

### Numbers

What?! Not **another** type of number! Well, I hate to break it to you, but yeah... sort of... We promise, this is the last one! We'll make it quick and painless. 

Numbers are a special type. A number is simply anything that is either a `Float` or an `Int`.

Any `Float` or `Int` is also a `number`. The reverse is also true, any `number` is either a `Float` or `Int`. You can't have something that is just a `number`.

When you type any number into Elm, it actually reads it as what we call a number literal, and then depending on how you use it, decides if it's an `Int` or a `Float`.

At a glance, the whole idea of having a third `number` type might seem completely useless, but there is a reason! Though you can't have something that is just a `number`, you *can* have functions that work on numbers! A function that takes a number as an input will accept either a `Float` or an `Int`.

This is the reason that all of the basic arithmetic operators work with Floats and Integers. They take two numbers and return another number. As was mentioned before, `/` and `//` are exceptions to this.

### Lists

Now we move on to lists. We've seen these before. Remember this?

    main = asText ([1, 2, 3, 4, 5, 6])

Like how when you type a number, it's a number literal, this is an example of a list literal. 

A list is simply a sequence of values which all share the same type. The example above is a list of numbers, which we would write as `[number]`.

Let's say that we want to define some function which works with lists, and not lists of a specific type. (e.g. a function which randomizes the order of elements in a list) Then we would need to have some way of denoting a list which can be of *any* type. We write this as `[a]`. In Elm, lower case letters are type variables, which means they stand in for any type.

|]]

another = chapter "Types.elm" words
main = another.main
port title : String
port title = another.title
