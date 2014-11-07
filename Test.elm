import Website.Template (chapter)
import KaTeX as Math

words w = flow down [width w <| Math.markdown [markdown|

# Another Chapter

## Test

This is another chapter. Here's some math:

$$`f(x) = \int_{-\infty}^\infty \hat f(\xi)\,e^{2 \pi i \xi x}\,d\xi`$$

Cool. But not as cool as $`x^2 + 1`$.

|]]

another = chapter "Test.elm" words
main = another.main
port title : String
port title = another.title
