import Website.Template (chapter)

words w = width w [markdown|

# Another Chapter

## Test

This is another chapter.

|]

another = chapter "Test.elm" words
main = another.main
port title : String
port title = another.title
