import "bootstrap"
import "tom-select"

export const selectEvaluator = () => {
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
};