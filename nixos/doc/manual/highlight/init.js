document.onreadystatechange = function () {
  var listings = document.querySelectorAll('.programlisting, .screen');

  for (i = 0; i < listings.length; ++i) {
    hljs.highlightBlock(listings[i]);
  }
}
