import $ from 'jquery';
import Rails from "@rails/ujs"

const greatListener = (chart) => {
  const form = document.getElementById("filter-form");
  const expertisesForm = document.getElementById("Expertises");
  const technologiesForm = document.getElementById("Technologies");
  const seniorityForm = document.getElementById("Seniority");

  // console.log(form)

  if (form) {
    // console.log(expertisesForm)

    $("#Expertises").on('change', (event) => {
      // event.preventDefault();

      submitAjaxForm();
    });

    // expertisesForm.addEventListener

    $("#Technologies").on('change', (event) => {
      // event.preventDefault();
      submitAjaxForm();
    });

    $("#Seniority").on('change', (event) => {
      // event.preventDefault();
      submitAjaxForm();
    });

    const submitAjaxForm = () => {
      console.log("coucou", expertisesForm)
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
          const resultArray = Array.from(data["result"])
          chart.data = resultArray;
        },
        error: function(data) {
          console.log(data)
        }
      })
    }

  }
}

export { greatListener }
