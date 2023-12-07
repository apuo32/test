
// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import jquery from "jquery"
window.$ = jquery


document.addEventListener("turbo:load", function() {

  // KAIZENメンバーIDを自動で入力
  $(document).on("input", ".kaizen_member_username", function() {
    var username = $(this).val();
    var userId = $("#users option").filter(function() {
      return $(this).val() === username;
    }).data("id");

    $(this).next(".kaizen_member_id").val(userId); // 隣接するhiddenフィールドにuserIdを設定
  });

  // フォームを追加
  document.querySelector(".add_member_button").addEventListener("click", function() {
    var newFieldPlaces = document.querySelector('.member-form-container');
    var newField = document.createElement('p');
    newField.classList.add('added-member-form-container');

    newField.innerHTML = `
      <label for="kaizen_member_username">KAIZENメンバー:</label>
      <input type="text" class="kaizen_member_username" autocomplete="on" list="users">
      <input type="text" class="kaizen_member_id">
    `;

    newFieldPlaces.insertAdjacentElement('afterend', newField);
  });

  // フォームを削除
  document.querySelector(".remove_member_button").addEventListener("click", function() {
    var addedFormElements = document.querySelectorAll('.added-member-form-container');
    if (addedFormElements.length > 0) {
      addedFormElements[addedFormElements.length - 1].remove();
    }
  });

  // フォーム送信前に全てのkaizen_member_idの値を結合
  $('form').on('submit', function(e) {
    var allIds = $('.kaizen_member_id').map(function() {
      return $(this).val();
    }).get().join(',');

    // 結合した値を既存の隠しフィールドに設定
    $('.combined_kaizen_member_ids').val(allIds);
  });
  
});
