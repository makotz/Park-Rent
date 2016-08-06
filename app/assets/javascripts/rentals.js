$(document).ready(function () {

  $('.rentspot').click(function () {
    console.log(this.href)
    URL = this.href
    that = this
    $.ajax({
      url: URL,
      method: "GET",
      success: function(data) {
        console.log(data)
      },
      error: function(data) {
        console.log("Error"+data.json);
      }
    });
  });

});
