module Website.CSS where

css = [markdown|<p style="margin: 0">
<style class="css-markdown">
body {
  font: 16px/1.5 Helvetica Neue, Helvetica, Arial, sans-serif;
}
h1 {
  font-size: 4em;
  font-weight: 200;
  letter-spacing: -1px;
  margin: 1em 0 -0.75em;
}
h2 {
  font-size: 2em;
  font-weight: 200;
  margin: 2em 0 0.5em;
}
pre, code {
  background: #f3f3f3;
  border-radius: 3px;
  padding: 2px 3px;
  font: 13px Menlo, Monaco, Consolas, Courier New, monospace;
}
pre code {
  padding: 0;
  background: 0;
}
pre {
  padding: 8px;
}
.output pre {
  background: 0;
  border-radius: 0;
  padding: 0;
  text-align: center;
}
.output pre code {
  display: inline-block;
  text-align: left;
}
/* Hide the automatic paragraph in CSS markdown */
.css-markdown + p {
  margin: 0;
}
</style>
|]
