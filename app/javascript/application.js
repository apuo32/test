
// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import "tom-select"
import jquery from "jquery"
window.$ = jquery

document.addEventListener("turbo:load", function() {

  const input = document.getElementById('before-images-upload');
  const previewContainer = document.getElementById('images-preview');

  input.addEventListener('change', (event) => {
    previewContainer.innerHTML = '';
    const files = event.target.files;

    Array.from(files).forEach(file => {
      const reader = new FileReader();
      reader.onload = (e) => {
        const img = document.createElement('img');
        img.src = e.target.result;
        img.style.maxWidth = '300px'; // 画像の最大幅を設定
        img.style.maxHeight = '300px'; // 画像の最大高さを設定
        previewContainer.appendChild(img);
      };
      reader.readAsDataURL(file);
    });
  });

  const afterInput = document.getElementById('after-images-upload');
  const afterPreviewContainer = document.getElementById('after-images-preview');

  afterInput.addEventListener('change', (event) => {
    afterPreviewContainer.innerHTML = '';
    const files = event.target.files;

    Array.from(files).forEach(file => {
      const reader = new FileReader();
      reader.onload = (e) => {
        const img = document.createElement('img');
        img.src = e.target.result;
        img.style.maxWidth = '300px'; // 画像の最大幅を設定
        img.style.maxHeight = '300px'; // 画像の最大高さを設定
        afterPreviewContainer.appendChild(img);
      };
      reader.readAsDataURL(file);
    });
  });

  // document.addEventListener("turbo:render", function() {
  //   const input = document.getElementById('before-images-upload');
  //   const previewContainer = document.getElementById('images-preview');
  
  //   input.addEventListener('change', (event) => {
  //     // 既存のプレビューをクリア
  //     previewContainer.innerHTML = '';
  //     const files = event.target.files;
  
  //     Array.from(files).forEach(file => {
  //       const reader = new FileReader();
  //       reader.onload = (e) => {
  //         const img = document.createElement('img');
  //         img.src = e.target.result;
  //         img.style.maxWidth = '300px';
  //         img.style.maxHeight = '300px';
  //         // ここでappendChildではなくinnerHTMLを使ってもよい
  //         previewContainer.innerHTML += `<img src="${e.target.result}" style="max-width: 300px; max-height: 300px;">`;
  //       };
  //       reader.readAsDataURL(file);
  //     });
  //   });
  
  //   const afterInput = document.getElementById('after-images-upload');
  //   const afterPreviewContainer = document.getElementById('after-images-preview');
  
  //   afterInput.addEventListener('change', (event) => {
  //     // 既存のプレビューをクリア
  //     afterPreviewContainer.innerHTML = '';
  //     const files = event.target.files;
  
  //     Array.from(files).forEach(file => {
  //       const reader = new FileReader();
  //       reader.onload = (e) => {
  //         const img = document.createElement('img');
  //         img.src = e.target.result;
  //         img.style.maxWidth = '300px';
  //         img.style.maxHeight = '300px';
  //         // ここでappendChildではなくinnerHTMLを使ってもよい
  //         afterPreviewContainer.innerHTML += `<img src="${e.target.result}" style="max-width: 300px; max-height: 300px;">`;
  //       };
  //       reader.readAsDataURL(file);
  //     });
  //   });
  // });
});

document.addEventListener("turbo:load", function() {
  new TomSelect("#select-kaizen-member", {
  });

  document.addEventListener("turbo:render", function() {
    new TomSelect("#select-kaizen-member", {
    });
  });
});

document.addEventListener("turbo:load", function() {
  new TomSelect("#select-first-evaluator",{
    create: true,
    sortField: {
      field: "text",
      direction: "asc"
    }
  });

  document.addEventListener("turbo:render", function() {
    new TomSelect("#select-first-evaluator",{
      create: true,
      sortField: {
        field: "text",
        direction: "asc"
      }
    });
  });
});

document.addEventListener("turbo:load", function() {
  new TomSelect("#select-second-evaluator",{
    create: true,
    sortField: {
      field: "text",
      direction: "asc"
    }
  });

  document.addEventListener("turbo:render", function() {
    new TomSelect("#select-second-evaluator",{
      create: true,
      sortField: {
        field: "text",
        direction: "asc"
      }
    });
  });
});