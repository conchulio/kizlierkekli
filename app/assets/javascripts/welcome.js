// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require underscore
//= require gmaps/google

currentMarkers = null;

function displayOnMap(position){
  handler.map.centerOn([position.coords.latitude, position.coords.longitude]);
}

function centerMapOnUser() {
  if (navigator.geolocation)
    navigator.geolocation.getCurrentPosition(displayOnMap);
}

function markerify(apartment) {
  return {
      "lat": apartment.latitude,
      "lng": apartment.longitude
      // "picture": {
      //   "url": "https://addons.cdn.mozilla.net/img/uploads/addon_icons/13/13028-64.png",
      //   "width":  36,
      //   "height": 36
      // },
      // "infowindow": apartment.title+"<br>"+apartment.description
    }
}

// Things to be done on startup
$(function() {
  $('#btn-geolocation').click(function() {
    centerMapOnUser();
  });
  $('#btn-search-offers').click(function() {
    lat1 = handler.map.serviceObject.getBounds().getSouthWest().lat();
    lng1 = handler.map.serviceObject.getBounds().getSouthWest().lng();
    lat2 = handler.map.serviceObject.getBounds().getNorthEast().lat();
    lng2 = handler.map.serviceObject.getBounds().getNorthEast().lng();
    $.ajax({
        url: "/apartments/index_within_boundaries",
        type: "get",
        data: {"lat1":lat1,"lng1":lng1,"lat2":lat2,"lng2":lng2}
      }).done(function(result) {
      filtered = result.filter(function(item) {
        return !(item.latitude == null || item.longitude == null)
      });
      if (currentMarkers) {
        handler.removeMarkers(currentMarkers);
      }
      markers = filtered.map(markerify);
      currentMarkers = handler.addMarkers(markers);
    });
  });
});
