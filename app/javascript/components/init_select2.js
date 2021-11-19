import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  $('.Expertises').select2({
    placeholder: "Filtrer par expertise(s)",
    allowClear: true
  });

  $('.Technologies').select2({
    placeholder: "Filtrer par spécialité(s)",
    allowClear: true
  });

  $('.Seniority').select2({
    placeholder: "Filtrer par niveau de séniorité",
    allowClear: true
  });

  $('.Gender').select2({
    placeholder: "Filtrer par genre",
    allowClear: true
  });

  $('.Remote').select2({
    placeholder: "Choisir distanciel ou présentiel",
    allowClear: true
  });

  // $('.select2-location').select2({
  //   placeholder: "Choisir une localisation ou cocher remote"
  // });

  // $(".select2-remote").on("click", function () {
  //   $(".select2-location").prop("disabled", true);
  // });

};

export { initSelect2 };