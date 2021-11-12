import Rails from "@rails/ujs"

const greatListener = () => {
  const expertisesForm = document.getElementById("Expertises");
  const technologiesForm = document.getElementById("Technologies");
  const seniorityForm = document.getElementById("Seniority");
  const form = document.getElementById("filter-form");

  if (expertisesForm) {

    expertisesForm.addEventListener('change', (event) => {
      // event.preventDefault();
      submitAjaxForm();
    });

    technologiesForm.addEventListener('change', (event) => {
      // event.preventDefault();
      submitAjaxForm();
    });

    seniorityForm.addEventListener('change', (event) => {
      // event.preventDefault();
      submitAjaxForm();
    });

    const submitAjaxForm = () => {
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
}

export { greatListener }
