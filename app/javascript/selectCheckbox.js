export const selectCheckbox = () => {
  document.getElementById('select-all').addEventListener('click', (e) => {
    e.preventDefault();
    document.querySelectorAll('input[type="checkbox"]').forEach(checkbox => {
      checkbox.checked = true;
    });
  });

  document.getElementById('deselect-all').addEventListener('click', (e) => {
    e.preventDefault();
    document.querySelectorAll('input[type="checkbox"]').forEach(checkbox => {
      checkbox.checked = false;
    });
  });
};
