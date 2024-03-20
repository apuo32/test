
// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import "tom-select"
import jquery from "jquery"
window.$ = jquery

document.addEventListener("turbo:load", function() {
  const beforeInput = document.getElementById('before-images-upload');
  const beforeCarouselInner = document.querySelector('#kaizenBeforeImagesCarousel .carousel-inner');

  beforeInput.addEventListener('change', function(event) {
    updateCarousel(event, beforeCarouselInner);
  });

  const afterInput = document.getElementById('after-images-upload');
  const afterCarouselInner = document.querySelector('#kaizenAfterImagesCarousel .carousel-inner');

  afterInput.addEventListener('change', function(event) {
    updateCarousel(event, afterCarouselInner);
  });
});

function updateCarousel(event, carouselInner) {
  carouselInner.innerHTML = ''; // 既存のコンテンツをクリア
  const files = event.target.files;
  Array.from(files).forEach((file, index) => {
    const reader = new FileReader();
    reader.onload = function(e) {
      const carouselItem = document.createElement('div');
      carouselItem.className = `carousel-item ${index === 0 ? 'active' : ''}`;

      const img = document.createElement('img');
      img.src = e.target.result;
      img.className = 'd-block carousel-img'; // カードいっぱいに表示

      carouselItem.appendChild(img);
      carouselInner.appendChild(carouselItem);
    };
    reader.readAsDataURL(file);
  });
};

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

document.addEventListener("turbo:load", function() {
  const selectAllButton = document.getElementById('select-all');
  const deselectAllButton = document.getElementById('deselect-all');

  selectAllButton.addEventListener('click', (e) => {
    e.preventDefault();
    document.querySelectorAll('input[type="checkbox"]').forEach(checkbox => {
      checkbox.checked = true;
    });
  });

  deselectAllButton.addEventListener('click', (e) => {
    e.preventDefault();
    document.querySelectorAll('input[type="checkbox"]').forEach(checkbox => {
      checkbox.checked = false;
    });
  });
});

document.addEventListener("turbo:load", function() {
  // フォームフィールドの参照を取得します
  // 仮にlgサイズ以上用のフィールドIDが`submission_date_lg`、lgサイズ以下用が`submission_date_sm`とします
  const submissionDateLg = document.getElementById('submission_date_lg');
  const submissionDateSm = document.getElementById('submission_date_sm');

  // lgサイズ以上用のフィールドの値が変更された場合、その値をlgサイズ以下用のフィールドにコピーします
  if (submissionDateLg) {
      submissionDateLg.addEventListener('change', function() {
          submissionDateSm.value = this.value;
      });
  }

  // lgサイズ以下用のフィールドの値が変更された場合、その値をlgサイズ以上用のフィールドにコピーします
  if (submissionDateSm) {
      submissionDateSm.addEventListener('change', function() {
          submissionDateLg.value = this.value;
      });
  }

  document.addEventListener("turbo:render", function() {
    const submissionDateLg = document.getElementById('submission_date_lg');
    const submissionDateSm = document.getElementById('submission_date_sm');
    if (submissionDateLg) {
        submissionDateLg.addEventListener('change', function() {
            submissionDateSm.value = this.value;
        });
    }
    if (submissionDateSm) {
        submissionDateSm.addEventListener('change', function() {
            submissionDateLg.value = this.value;
        });
    }
  });
});

document.addEventListener("turbo:load", function() {
  // subjectフィールドの参照を取得します
  const subjectLg = document.getElementById('subject_lg');
  const subjectSm = document.getElementById('subject_sm');

  // lgサイズ以上用のフィールドの値が変更された場合、その値をlgサイズ以下用のフィールドにコピーします
  if (subjectLg) {
    subjectLg.addEventListener('input', function() {
      subjectSm.value = this.value;
    });
  }

  // lgサイズ以下用のフィールドの値が変更された場合、その値をlgサイズ以上用のフィールドにコピーします
  if (subjectSm) {
    subjectSm.addEventListener('input', function() {
      subjectLg.value = this.value;
    });
  }

  document.addEventListener("turbo:render", function() {
    const subjectLg = document.getElementById('subject_lg');
    const subjectSm = document.getElementById('subject_sm');
    if (subjectLg) {
      subjectLg.addEventListener('input', function() {
        subjectSm.value = this.value;
      });
    }
    if (subjectSm) {
      subjectSm.addEventListener('input', function() {
        subjectLg.value = this.value;
      });
    }
  });
});

document.getElementById("before-images-clear").addEventListener("click", function(){

  const obj = document.getElementById('before-images-upload');

  if(obj !== null){
    obj.value = '';
  }

  const carouselItems = document.querySelectorAll('#kaizenBeforeImagesCarousel .carousel-item');
  carouselItems.forEach(function(item) {
    item.innerHTML = '';
  });

})

document.getElementById("after-images-clear").addEventListener("click", function(){

  const obj = document.getElementById('after-images-upload');

  if(obj !== null){
    obj.value = '';
  }

  const carouselItems = document.querySelectorAll('#kaizenAfterImagesCarousel .carousel-item');
  carouselItems.forEach(function(item) {
    item.innerHTML = '';
  });

})

// document.querySelector('.submit-form').addEventListener('click', function(e) {
//   e.preventDefault(); // フォームのデフォルト送信を防止
//   const form = this.closest('form'); // ボタンが属するフォームを取得

//   // KAIZEN前のcarousel-itemの存在をチェック
//   const hasBeforeCarouselItems = document.querySelector('#kaizenBeforeImagesCarousel .carousel-inner').children.length > 0;

//   // KAIZEN後のcarousel-itemの存在をチェック
//   const hasAfterCarouselItems = document.querySelector('#kaizenAfterImagesCarousel .carousel-inner').children.length > 0;

//   // 新しい画像がアップロードされているかを確認
//   const newBeforeImagesUploaded = document.getElementById('before-images-upload').files.length > 0;
//   const newAfterImagesUploaded = document.getElementById('after-images-upload').files.length > 0;

//   // フォームデータに情報を追加
//   const formData = new FormData(form);
//   formData.append('has_before_carousel_items', hasBeforeCarouselItems);
//   formData.append('has_after_carousel_items', hasAfterCarouselItems);
//   formData.append('new_before_images_uploaded', newBeforeImagesUploaded);
//   formData.append('new_after_images_uploaded', newAfterImagesUploaded);

//   // フォームデータを使用して非同期リクエストを送信
//   fetch(form.action, {
//       method: 'POST',
//       body: formData,
//       headers: {
//           'X-Requested-With': 'XMLHttpRequest', // Railsの非同期リクエストを示す
//       },
//   }).then(response => {
//       // 必要に応じて処理
//   }).catch(error => console.error('Error:', error));
// });
