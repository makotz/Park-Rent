$(document).ready(function () {

  $('#eventsearch').keydown(function () {
    console.log(this.value)
    that = this
    $.ajax({
      url: "/events/search",
      method: "GET",
      data: {
        searchterm: that.value,
      },
      success: function(data) {
        $('#eventlisting').html("")
        console.log(data)
        if (data.length != 0) {
          for (var i = 0; i < data.length; i++) {
            $('#eventlisting').append(
              "<a href=" + "/events/" + data[i].id + "><h2>" + data[i].title + "</a> (" + data[i].address + ")</h2><h5>"+data[i].starttime+" - "+data[i].endtime+"</h5><hr>"
            )
          };
        } else {
          $('#eventlisting').append(
            "<h2>No events found :(<h2>"
          )
        };
      },
      error: function () {
        console.log("Error :(")
      }
    });
  });
});
