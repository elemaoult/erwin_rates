import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  $('.Expertises').select2({
    placeholder: "Choisir une ou plusieurs expertises",
  });

  $('.Technologies').select2({
    placeholder: "Choisir une ou plusieurs spécialités",
  });

  $('.Seniority').select2({
    placeholder: "Choisir un niveau de séniorité"
  });

  $('.Gender').select2({
    placeholder: "Choisir de filtrer par genre"
  });

  $('.Remote').select2({
    placeholder: "Choisir les freelance en distanciel ou en présentiel"
  });

  // $('.select2-location').select2({
  //   placeholder: "Choisir une localisation ou cocher remote"
  // });

  // $(".select2-remote").on("click", function () {
  //   $(".select2-location").prop("disabled", true);
  // });

};

export { initSelect2 };