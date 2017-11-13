// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require display_route
//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require_tree .

var map;

function initMap() {
  var userLoc = $("#markers").data("userLocation");
  var safeLocations = $("#markers").data('safeLocations');
  var events = $("#markers").data('events');
  var position = [41.8922, -87.6349];

  for (let i = 0; i < events.length; i++) {
    console.log(events[i][7]);
  }

    
  if (userLoc === "") {
    var latLng = new google.maps.LatLng(position[0], position[1]);
  } else {
    var latLng = new google.maps.LatLng(userLoc[0], userLoc[1]);
  }

  var mapOptions = {
    zoom: 12, // initialize zoom level - the max value is 21
    streetViewControl: false, // hide the yellow Street View pegman
    scaleControl: true, // allow users to zoom the Google Map
    mapTypeControl: false,
    center: latLng,
    styles: [
      {
        "featureType": "water",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#193341"
          }
        ]
      },
      {
        "featureType": "landscape",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#2c5a71"
          }
        ]
      },
      {
        "featureType": "road",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#29768a"
          },
          {
            "lightness": -37
          }
        ]
      },
      {
        "featureType": "poi",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#406d80"
          }
        ]
      },
      {
        "featureType": "transit",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#406d80"
          }
        ]
      },
      {
        "elementType": "labels.text.stroke",
        "stylers": [
          {
            "visibility": "on"
          },
          {
            "color": "#3e606f"
          },
          {
            "weight": 2
          },
          {
            "gamma": 0.84
          }
        ]
      },
      {
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#ffffff"
          }
        ]
      },
      {
        "featureType": "administrative",
        "elementType": "geometry",
        "stylers": [
          {
            "weight": 0.6
          },
          {
            "color": "#1a3541"
          }
        ]
      },
      {
        "elementType": "labels.icon",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "poi.park",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#2c5a71"
          }
        ]
      }
    ]
  };

  map = new google.maps.Map(document.getElementById('googlemaps'), mapOptions);

  directionsService = new google.maps.DirectionsService;
  directionsDisplay = new google.maps.DirectionsRenderer({
    draggable: true,
    map: map,
    polylineOptions: {
      strokeColor: 'purple',
      strokeOpacity: 0.5,
      strokeWeight: 10
    },
    markerOptions: {
      visible: false
    }
  });

  function addMarker(coords, infoWinContent, iconImage, editUrl, locName, locStatus, locId) {
    var marker = new google.maps.Marker({
      position: coords,
      map: map,
      icon: iconImage,
      draggable: false,
    });

    if (iconImage) {
      marker.setIcon(iconImage);
    }

    if (infoWinContent) {
      var infoWindow = new google.maps.InfoWindow({
        content: infoWinContent,
      });
    }

    marker.addListener("click", function() {
      infoWindow.open(map, marker);
      var form = document.getElementById("editform");
      form.action = editUrl;   
      document.getElementById( "edFormName" ).value = locName;
      document.getElementById( "edFormStatus" ).value = locStatus;
      document.getElementById( "edFormId" ).value = locId;
      document.getElementById( "edFormLat" ).value = marker.position.lat();
      document.getElementById( "edFormLong" ).value = marker.position.lng();
    });
  }

  if (userLoc !== "") {
    addMarker({lat: userLoc[0], lng: userLoc[1]}, null, "/assets/user");
  }
          
  for (let i = 0; i < safeLocations.length; i++) {
    let sl = safeLocations[i];
    let coords = {lat: sl[2], lng: sl[3]};
    let image = "/assets/fallout.png";
    let content = `<h6>${sl[0]}</h6>${sl[1]}<br>
    <button type='button' class='btn btn-info btn-sm' data-toggle='modal' data-target='#editForm'>Edit</button>`;
    if (userLoc !== "") {
      content += `<br>
      <button onclick="displayRoute({lat: ${userLoc[0]},lng: ${userLoc[1]}}, 
        {lat: ${sl[2]}, lng: ${sl[3]}}, directionsService, directionsDisplay)">Show me the way!</button>`;
    }
    addMarker(coords, content, image, sl[4], sl[0], sl[1], sl[5]);
  }

  for (let i = 0; i < events.length; i++) {
    let event = events[i];
    let coords = {lat: event[2], lng: event[3]};
    let image = `/assets/${event[6]}.png`;
    let content = `<h6>${event[0]}</h6>${event[1]}<br>`
    if (event[7]) {
      content += `<IMG BORDER="0" ALIGN="Left" SRC="${event[7]}">`;
    }
    content += `<button type='button' class='btn btn-info btn-sm' data-toggle='modal' data-target='#editForm'>Edit</button>`;
    addMarker(coords, content, image, event[4], event[0], event[1], event[5]);
  }
      
  google.maps.event.addListener(map, 'mousedown', function(event) {
    var interval = setInterval(function() {
      var coords = event.latLng;
      document.getElementById( "slFormLat" ).value = event.latLng.lat();
      document.getElementById( "slFormLong" ).value = event.latLng.lng();
      document.getElementById( "evFormLat" ).value = event.latLng.lat();
      document.getElementById( "evFormLong" ).value = event.latLng.lng();
      var content = `<button type='button' class='btn btn-info btn-sm' data-toggle='modal' data-target='#safeLocationForm'>New Safe Location</button>
        <br><button type='button' class='btn btn-danger btn-sm' data-toggle='modal' data-target='#eventForm'>New Event</button>`;
      addMarker(coords, content);
    }, 700);
        
    google.maps.event.addListener(map, 'mouseup', function(event) {
      clearInterval(interval);
    });
  });
    
  var kmlLayer = new google.maps.KmlLayer({
    url: "http://gdacs.org/xml/gdacs.kml",
    map: map,
    preserveViewport: true
  });

  function callback(results, status) {
    if (status === google.maps.places.PlacesServiceStatus.OK) {
      for (var i = 0; i < results.length; i++) {
        var place = results[i];
        searchMarker(results[i]);
      }
    }
  }
  
  var placeService = new google.maps.places.PlacesService(map);
  
  
  var searchQueries = {
    "Zombies": ['armory', 'police department'],
    "Kaiju": [''],
    "Hurricane": ['c'],
    "Slight Breeze": ['d'],
    "Earthquake": ['e'],
    "Fire": ['f'],
    "Tornado": ['g'],
    "Flood": ['h'],    
  }
  
  // console.log(searchQueries[events[0][6]]);
  
  placeService.textSearch({location: { lat: position[0], lng: position[1] }, radius: '0', query: "armory"}, callback);
  
  function searchMarker(placeObject) {
    
    if (placeObject.place_id) {

      var marker = new google.maps.Marker({
        map: map,
        icon: placeObject.icon,
        place: {
          placeId: placeObject.place_id,
          location: placeObject.geometry.location
        }
      });

      placeDetails(placeObject, marker);
    }

  }

  function placeDetails(placeObject, marker) {
    if (placeObject.place_id) {
      let infoWindow = new google.maps.InfoWindow();

      placeService.getDetails({
    
        placeId: placeObject.place_id
      }, function(place, status) {
        let lat = placeObject.geometry.location.lat();
        let lng = placeObject.geometry.location.lng();
        google.maps.event.addListener(marker, 'click', function() {
          infoWindow.setContent(`<div><strong> ${place.name} </strong><br> 
              ${place.formatted_address}<br>
              <button onclick="displayRoute({lat: ${userLoc[0]},lng: ${userLoc[1]}}, 
                {lat:${lat}, lng:${lng}}, directionsService, directionsDisplay)">Show me the way!</button> </div>`);
          infoWindow.open(map, this);
        });
      });
    }
  }
  

  google.maps.event.addDomListener(window, 'resize', initMap);   
}