// AJAX for the INDEX page
var url = "parkingspots/"


$(document).ready(function () {

  $('#starttime').datetimepicker();

  $('#endtime').datetimepicker({
    useCurrent: false
  });

  // On change for starttime
  $("#starttime").on("dp.change", function (e) {
    $('#endtime').data("DateTimePicker").minDate(e.date);
    var starttime = e.date._d
    var endtime = $('#endtime input').val();
    $.ajax({
      url: url,
      method: "GET",
      data: {
        starttime: starttime,
        endtime: endtime,
        origin: "starttime"
      },
      success: function(data) {
        $('#available_parkingspots').html("")
        for (var i = 0; i < data.length; i++) {
          $('#available_parkingspots').append(
            "<a href=" + url + data[i].id + ">" + data[i].title + "</a> (" + data[i].address + ")<hr>"
          )};
      },
      error: function () {
        console.log("Error :(")
      }
    });
  });

  //On change for endtime
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
        $('#available_parkingspots').html("")
        for (var i = 0; i < data.length; i++) {
          $('#available_parkingspots').append(
            "<a href=" + url + data[i].id + ">" + data[i].title + "</a> (" + data[i].address + ")<hr>"
          )};
      },
      error: function () {
        console.log("Error :(")
      }
    });
  });
});
