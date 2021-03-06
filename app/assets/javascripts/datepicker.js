$(document).ready(function() {

  $(".check-slot").children().hide();
  $('body').on('change', '#appointment_doctor_id', function() {
    $("#appointment_date").val(tomorrowDate());
    $(".check-slot").children().hide();
    $(".available-slots").text("");
  });

  $('body').on('click', '#appointment_date', function() {
    var link = $("#get_timeslots").prop("href");
    var doctor = $("#appointment_doctor_id").val();
    var date = $("#appointment_date").val();
    $("#get_timeslots").prop("href", link.split('?')[0] + "?date=" + date + "&doctor=" + doctor);
    $("#get_timeslots").trigger("click");
  });

  function tomorrowDate() {
    var date = new Date();
    date.setDate(date.getDate() + 1);
    var mm = (date.getMonth() < 12 ? date.getMonth() + 1 : 1);
    mm = mm.toString().length > 1 ? mm : (0 + mm.toString());
    var dd = date.getDate();
    var yyyy = date.getFullYear();
    return yyyy + "-" + mm + "-" + dd;
  }
});
