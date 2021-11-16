import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  $('#Expertises').select2({
    placeholder: "Choisir une ou plusieurs expertises"
  });
  $('#Technologies').select2({
    placeholder: "Choisir une ou plusieurs spécialités"
  });
  $('#Seniority').select2({
    placeholder: "Choisir un niveau de séniorité"
  });
  $('.select2-location').select2({
    placeholder: "Choisir une localisation ou cocher remote"
  });
  $('.select2-remote').select2({
    placeholder: "Choisir une localisation ou cocher remote"
  });

  $(".select2-remote").on("click", function () {
    $(".select2-location").prop("disabled", true);
  });

  // $('.js-example-basic-multiple').select2();
};

// $(".js-example-disabled").select2();
// $(".js-example-disabled-multi").select2();

// $(".js-programmatic-enable").on("click", function () {
//   $(".js-example-disabled").prop("disabled", false);
//   $(".js-example-disabled-multi").prop("disabled", false);
// });

// $(".js-programmatic-disable").on("click", function () {
//   $(".js-example-disabled").prop("disabled", true);
//   $(".js-example-disabled-multi").prop("disabled", true);
export { initSelect2 };