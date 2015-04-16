// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {
  $(".form-favorite").bind('ajax:complete', function(event) {
    if ($(this).hasClass('form-add-favorite')) {
      $('.form-add-favorite').addClass('hidden');
      $('.form-remove-favorite').removeClass('hidden');
    } else {
      $('.form-add-favorite').removeClass('hidden');
      $('.form-remove-favorite').addClass('hidden');
    }
  });
});