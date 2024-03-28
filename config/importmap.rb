pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.3.2/dist/js/bootstrap.esm.js"
pin "@popperjs/core", to: "https://ga.jspm.io/npm:@popperjs/core@2.11.8/lib/index.js"
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.7.1/dist/jquery.js"
pin "tom-select", to: "https://cdn.jsdelivr.net/npm/tom-select@2.2.2/dist/js/tom-select.complete.min.js"
pin "selectCheckbox", to: "selectCheckbox.js"
pin "coppyValue", to: "coppyValue.js"
pin "imagesClear", to: "imagesClear.js"
pin "imagesUpload", to: "imagesUpload.js"
pin "selectMember", to: "selectMember.js"
pin "limited10Lines", to: "limited10Lines.js"
pin "limited4Lines", to: "limited4Lines.js"
pin "limited1Line", to: "limited1Line.js"
pin "calendarButton", to: "calendarButton.js"