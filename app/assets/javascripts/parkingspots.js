// AJAX for the INDEX page
var url = "parkingspots/"

$(document).ready(function () {

  $('#starttime').datetimepicker();
  $('#endtime').datetimepicker({
    useCurrent: false
  });

  $("#parkingspotsearchbutton").click(function() {

    var endtime = $('#endtime input').val();
    var starttime = $('#starttime input').val();
    var location = $('#parkingspotsearch').val();

    $.ajax({
      url: url,
      method: "GET",
      data: {
        starttime: starttime,
        endtime: endtime,
        location: location,
        origin: "search"
      },
      success: function(data) {
        var parkingspots = data.parkingspots
        var markers_hash = data.markers_hash

        $('#available_parkingspots').html("")
        for (var i = 0; i < parkingspots.length; i++) {
          $('#available_parkingspots').append(
            "<div class='box tile hvr-bob' style='display: block'><li><h3 style='display:inline-block'><a href=" + url + parkingspots[i].id + ">" + parkingspots[i].title + "</a></h3>&nbsp;($"+ parkingspots[i].default_price+ "/hour)<h4>(" + parkingspots[i].address + ")</h4></li></div>"
          )};

        $('#map').html("")
        handler = Gmaps.build('Google');
        handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
          markers = handler.addMarkers(markers_hash);
          handler.bounds.extendWith(markers);
          handler.fitMapToBounds();

        });
      },
      error: function () {
        console.log("Bruh no go")
      }
    });
  });

  $("#endtime").on("dp.change", function (g) {

    $('#starttime').data("DateTimePicker").maxDate(g.date);

    var endtime = g.date._d
    var starttime = $('#starttime input').val();
    var location = $('#parkingspotsearch').val();

    $.ajax({
      url: url,
      method: "GET",
      data: {
        starttime: starttime,
        endtime: endtime,
        location: location,
        origin: "endtime"
      },
      success: function(data) {
        var parkingspots = data.parkingspots
        var markers_hash = data.markers_hash

        $('#available_parkingspots').html("")
        for (var i = 0; i < parkingspots.length; i++) {
          $('#available_parkingspots').append(
            "<div class='box tile hvr-bob' style='display: block'><li><h3 style='display:inline-block'><a href=" + url + parkingspots[i].id + ">" + parkingspots[i].title + "</a></h3>&nbsp;($"+ parkingspots[i].default_price+ "/hour)<h4>(" + parkingspots[i].address + ")</h4></li></div>"
          )};

        $('#map').html("")
        handler = Gmaps.build('Google');
        handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
          markers = handler.addMarkers(markers_hash);
          handler.bounds.extendWith(markers);
          handler.fitMapToBounds();
        });
      },
      error: function () {
        console.log("Error :(")
      }
    });
  });

  $("#starttime").on("dp.change", function (e) {
    $('#endtime').data("DateTimePicker").minDate(e.date);

    var starttime = e.date._d
    var endtime = $('#endtime input').val();
    var location = $('#parkingspotsearch').val();

    $.ajax({
      url: url,
      method: "GET",
      data: {
        starttime: starttime,
        endtime: endtime,
        location: location,
        origin: "starttime"
      },
      success: function(data) {
        var parkingspots = data.parkingspots
        var markers_hash = data.markers_hash

        $('#available_parkingspots').html("")
        for (var i = 0; i < parkingspots.length; i++) {
          $('#available_parkingspots').append(
            "<div class='box tile hvr-bob' style='display: block'><li><h3 style='display:inline-block'><a href=" + url + parkingspots[i].id + ">" + parkingspots[i].title + "</a></h3>&nbsp;($"+ parkingspots[i].default_price+ "/hour)<h4>(" + parkingspots[i].address + ")</h4></li></div>"
          )};

        $('#map').html("")
        handler = Gmaps.build('Google');
        handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
          markers = handler.addMarkers(markers_hash);
          handler.bounds.extendWith(markers);
          handler.fitMapToBounds();
        });
      },
      error: function () {
        console.log("Error :(")
      }
    });
  });

  $("#endtime").on("dp.change", function (g) {
    $('#starttime').data("DateTimePicker").maxDate(g.date);
    var endtime = g.date._d
    var starttime = $('#starttime input').val();
    $.ajax({
      url: url,
      method: "GET",
      data: {
        starttime: starttime,
        endtime: endtime,
        origin: "endtime"
      },
      success: function(data) {
        var parkingspots = data.parkingspots
        var markers_hash = data.markers_hash

        $('#available_parkingspots').html("")
        for (var i = 0; i < parkingspots.length; i++) {
          $('#available_parkingspots').append(
            "<a href=" + url + parkingspots[i].id + ">" + parkingspots[i].title + "</a> (" + parkingspots[i].address + ")<hr>"
          )};

        $('#map').html("")
        handler = Gmaps.build('Google');
        handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
          markers = handler.addMarkers(markers_hash);
          handler.bounds.extendWith(markers);
          handler.fitMapToBounds();
        });
      },
      error: function () {
        console.log("Error :(")
      }
    });
  });
});
