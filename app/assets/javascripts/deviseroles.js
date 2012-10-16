$(function () {
  $('.contact_us').change(function () {
    if ($('#name').val() != "" && $('#email').val() != "" && $('#subject').val() != "" && $('#message').val() != "") {
      $('.contact_us_submit').attr('disabled',false);
    }else{
      $('.contact_us_submit').attr('disabled',"disabled");
    }

  });
});