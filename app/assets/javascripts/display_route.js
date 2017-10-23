function displayRoute(origin, destination, service, display) {
  service.route({
    origin: origin,
    destination: destination,
    travelMode: 'DRIVING',
  }, function(response, status) {
    if (status === "OK") {
      display.setDirections(response);
    } else {
      alert("Could not display directions due to: " + status);
    }
  });
}