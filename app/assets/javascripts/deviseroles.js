$(function () {

  $('.contact_us').change(function () {
    if ($('#name').val() != "" && $('#email').val() != "" && $('#subject').val() != "" && $('#message').val() != "") {
      $('.contact_us_submit').attr('disabled',false);
    }else{
      $('.contact_us_submit').attr('disabled',"disabled");
    }

  });

  $('.girl_scout_sign_up_form').change(function () {
    if ($('#user_username').val() != "" && $('#user_email').val() != "" && $('#user_password').val() != "" && $('#user_password_confirmation').val() != "") {
      $('.girl_scout_sign_up_form_submit').attr('disabled',false);
    }else{
      $('.girl_scout_sign_up_form_submit').attr('disabled',"disabled");
    }
  });
});