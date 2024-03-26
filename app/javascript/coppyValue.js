export const coppyValue = () => {
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
};