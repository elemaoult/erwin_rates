import $ from 'jquery';

$(function () {
  $("body").on("click", ".feedback_active", function (e) {
    $(".feedback .thanks").hide();
    $(".feedback .form").hide();
    $(".feedback a").show();
    $(".feedback_active").hide();
    e.preventDefault();
  });

  $(".feedback a").on("click", function (e) {
    $("body").prepend("<div class='feedback_active'></div>");
    $(".feedback .form").show();
    $(".feedback .form textarea").focus();
    $(".feedback a").hide();
    e.preventDefault();
  });

  $(".form form").on("submit", function (e) {
    $(".feedback .thanks").show();
    $(".feedback .form").hide();
    $('.feedback').removeClass('dN');
    


    setTimeout(function () {
      $('.feedback').slideToggle();
      $(".feedback textarea").val("");
    }, 1500);
    e.preventDefault();
  });
});
