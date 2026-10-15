(function () {
  var media = window.matchMedia("(prefers-color-scheme: dark)");
  var apply = function () {
    document.documentElement.setAttribute("data-bs-theme", media.matches ? "dark" : "light");
  };
  apply();
  media.addEventListener("change", apply);
})();
