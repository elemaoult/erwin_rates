import Rails from "@rails/ujs"

const greatListener = () => {
  const form = document.getElementById("filter-form");
  const expertisesForm = document.getElementById("Expertises");
  const technologiesForm = document.getElementById("Technologies");
  const seniorityForm = document.getElementById("Seniority");

  if (form) {

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
        dataType:"json",
        data: formData,
        success: function(data) {
          // TODO ??? => document.querySelector('.chartdiv').data = Array.from(data["result"])
          console.log(`data from ${form.action}`, data)
        },
        error: function(data) {
          console.log(data)
        }
      })
    }

  }
}

export { greatListener }
