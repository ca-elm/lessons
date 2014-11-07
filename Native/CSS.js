Elm.Native = Elm.Native || {};
Elm.Native.CSS = Elm.Native.CSS || {};

Elm.Native.CSS.make = function(runtime) {
  'use strict';

  if (Elm.Native.CSS.values) {
    return Elm.Native.CSS.values;
  }

  return Elm.Native.CSS.values = {};
};

(function() {
  'use strict';

  var link = document.createElement('link');
  link.rel = 'stylesheet';
  link.href = 'static/style.css';
  document.head.appendChild(link);
}());
