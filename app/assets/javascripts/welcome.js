// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require underscore
//= require gmaps/google

function displayOnMap(position){
  handler.map.centerOn([position.coords.latitude, position.coords.longitude]);
}

function centerMapOnUser() {
  if (navigator.geolocation)
    navigator.geolocation.getCurrentPosition(displayOnMap);
}

$(function() {
  $('#btn-geolocation').click(function() {
    centerMapOnUser();
  });
});
