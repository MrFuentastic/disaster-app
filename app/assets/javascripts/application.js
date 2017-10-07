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
//= require rails-ujs
//= require_tree .
//= require jquery3
//= require popper
//= require bootstrap-sprockets
$(document).ready(function(){ 
    $(function () {
        $('[data-toggle="popover"]').popover()
    })

    var safeLocations = $("#markers").data('safeLocations');
    var events = $("#markers").data('events');
    var position = [41.8922, -87.6349];
    
    function initMap() {

        var latLng = new google.maps.LatLng(position[0], position[1]);

        var mapOptions = {
                        zoom: 12, // initialize zoom level - the max value is 21
                        streetViewControl: false, // hide the yellow Street View pegman
                        scaleControl: true, // allow users to zoom the Google Map
                        mapTypeControl: false,
                        mapTypeId: google.maps.MapTypeId.ROADMAP,
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

        map = new google.maps.Map(document.getElementById('googlemaps'),
            mapOptions);


        function addMarker(coords, infoWinContent, iconImage){

            var marker = new google.maps.Marker({
                position: coords,
                map: map,
                draggable: false,
                animation: google.maps.Animation.DROP
            });

            if (iconImage){
                marker.setIcon(iconImage);
            }

            if (content){
                var infoWindow = new google.maps.InfoWindow({
                    content: infoWinContent
                })

                marker.addListener("click", function(){
                    infoWindow.open(map, marker);
                })
            }    
        }

        for (var i = 0; i < safeLocations.length; i++){
            var coords = {lat: safeLocations[i][2], lng: safeLocations[i][3]};
            var image = "/assets/fallout.png";
            var content = `<h6>${safeLocations[i][0]}</h6>${safeLocations[i][1]}`;
            addMarker(coords, content, image);
        }

        for (var i = 0; i < events.length; i++){
            var coords = {lat: events[i][2], lng: events[i][3]};
            var image = "/assets/staypuft.png";
            var content = `<h6>${events[i][0]}</h6>${events[i][1]}`;
            addMarker(coords, content, image);
        }

        google.maps.event.addListener(map, 'click', function(event){
            var coords = event.latLng;
            document.getElementById( "slFormLat" ).value = event.latLng.lat();
            document.getElementById( "slFormLong" ).value = event.latLng.lng();
            document.getElementById( "evFormLat" ).value = event.latLng.lat();
            document.getElementById( "evFormLong" ).value = event.latLng.lng();
            var content = "<button type='button' class='btn btn-info btn-sm' data-toggle='modal' data-target='#safeLocationForm'>New Safe Location</button><br><button type='button' class='btn btn-danger btn-sm' data-toggle='modal' data-target='#eventForm'>New Event</button>";
            addMarker(coords, content);
        });


    }


    google.maps.event.addDomListener(window, 'load', initMap);

});