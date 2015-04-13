// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require underscore
//= require gmaps/google

currentMarkers = null;
currentApartments = null;

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
      "lng": apartment.longitude,
    }
}

function handlerForSearch(event) {
  event.preventDefault();
  text = $('#input-search').val();
  lat1 = handler.map.serviceObject.getBounds().getSouthWest().lat();
  lng1 = handler.map.serviceObject.getBounds().getSouthWest().lng();
  lat2 = handler.map.serviceObject.getBounds().getNorthEast().lat();
  lng2 = handler.map.serviceObject.getBounds().getNorthEast().lng();
  $.ajax({
      url: "/apartments/index_within_boundaries",
      type: "get",
      data: {"lat1":lat1,"lng1":lng1,"lat2":lat2,"lng2":lng2,"text":text}
    }).done(function(result) {
    if (currentMarkers) {
      handler.removeMarkers(currentMarkers);
    }
    markers = result.map(markerify);
    currentMarkers = handler.addMarkers(markers);
    for (var i=0; i < currentMarkers.length; i++) {
      var callback = (function(marker,apartment) {
        return (function() {
          $.ajax({url: "/apartments/infowindow/"+apartment.id}).done(function(infowindowContent) {
            if (window.infowindow !== null)
              window.infowindow.close();
            window.infowindow = new google.maps.InfoWindow({
              content: infowindowContent
            });
            window.infowindow.open(handler.map.serviceObject,marker.serviceObject);
          });
        });
      })(currentMarkers[i], result[i]);
      google.maps.event.addListener(currentMarkers[i].serviceObject, 'click', callback);
    }
  });
};

// Things to be done on startup
$(function() {
  $('.search-icon').hide();
  $('.search-refresh').hide();

  window.infowindow = null;

  // In order that there's no error if it's the wrong page
  try {
    google.maps.event.addListener(handler.map.serviceObject, 'bounds_changed', function() {
      if (currentMarkers !== null) {
        $('.search-refresh').show();
        $('.search-all').hide()
        $('.search-icon').hide();
      }
    });
  } catch (err) {}
  $('#input-search').on('input propertychange paste', function() {
    if ($('#input-search').val().length === 0) {
      $('.search-all').show()
      $('.search-refresh').hide();
      $('.search-icon').hide()
    } else {
      $('.search-icon').show()
      $('.search-refresh').hide();
      $('.search-all').hide()
    }
  });
  $('#btn-geolocation').click(function() {
    centerMapOnUser();
  });
  $('#search-form').submit(handlerForSearch);
  $('#btn-search-offers').click(handlerForSearch);
});
