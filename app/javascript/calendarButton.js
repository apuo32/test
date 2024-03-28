export const calendarButton = () => {
  document.body.addEventListener("click", (event) => {
    let target = event.target;
    if (target.tagName === "A" && target.closest(".simple-calendar")) {
      event.preventDefault(); // デフォルトのリンク動作を防止
      const url = target.getAttribute('href');

      fetch(url)
      .then(response => response.text())
      .then(html => {
        const parser = new DOMParser();
        const doc = parser.parseFromString(html, "text/html");
        const newCalendar = doc.querySelector(".simple-calendar").innerHTML;
        const oldCalendar = document.querySelector(".simple-calendar");
        if (oldCalendar) {
          oldCalendar.innerHTML = newCalendar;
        }
      })
      .catch(error => console.error('Error:', error));
    }
  });
};