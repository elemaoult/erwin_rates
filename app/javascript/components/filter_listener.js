import Rails from "@rails/ujs"

  const greatListener = () => {

  const ExpertisesForm = document.getElementById("Expertises");
  ExpertisesForm.addEventListener('change', (event) => {
    // event.preventDefault();
    submitAjaxForm();
  });

  const TechnologiesForm = document.getElementById("Technologies");
  TechnologiesForm.addEventListener('change', (event) => {
    // event.preventDefault();
    submitAjaxForm();
  });

  const SeniorityForm = document.getElementById("Seniority");
  SeniorityForm.addEventListener('change', (event) => {
    // event.preventDefault();
    submitAjaxForm();
  });

  const submitAjaxForm = () => {
    const form = document.getElementById("filter-form");

    let formData = new FormData(form)
    // Rails ajax corresponding to fetch
    Rails.ajax({
      url: form.action,
      type: "post",
      data: formData,
      success: function(data) {
        console.log(data)
      },
      error: function(data) {
        console.log(data)
      }
    })
  }

}

export {greatListener}