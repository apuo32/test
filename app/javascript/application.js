
// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import "tom-select"
import jquery from "jquery"
window.$ = jquery

document.addEventListener("turbo:load", function() {
  new TomSelect("#select-kaizen-member", {
    maxItems: 6
  });
});
