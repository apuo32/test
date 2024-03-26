export const limited4Lines = () => {
  const textareas = document.querySelectorAll(".limited-four-lines");
  textareas.forEach((textarea) => {
    textarea.addEventListener("input", function() {
      const MAX_CHARS_PER_LINE = 35;
      const lines = textarea.value.split("\n");
      let adjustedLines = [];

      lines.forEach((line) => {
        while (line.length > MAX_CHARS_PER_LINE) {
          adjustedLines.push(line.substring(0, MAX_CHARS_PER_LINE));
          line = line.substring(MAX_CHARS_PER_LINE);
        }
        adjustedLines.push(line);
      });

      // 超えた行を削除し、最大行数に合わせる
      if (adjustedLines.length > 3) {
        adjustedLines = adjustedLines.slice(0, 3);
      }

      textarea.value = adjustedLines.join("\n");
    });
  });
};