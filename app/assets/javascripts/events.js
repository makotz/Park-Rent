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
              "<div class='box tile hvr-underline-from-left' style='display: block'><li><h3 style='display: inline-block'><a href=" + "/events/" + data[i].id + " style='color: white; text-decoration: none;'>" + data[i].title + "</a></h3>&nbsp;<h4 style='display: inline-block;'>(" + data[i].address + ")</h4><h5>"+ data[i].starttime +" - "+data[i].endtime +")</h5>"
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
