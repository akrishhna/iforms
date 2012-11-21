$(function () {
  $('.new_user').change(function () {
    if ($('#user_username').val() != "" && $('#user_email').val() != "" && $('#user_password').val() != "" && $('#user_password_confirmation').val() != "") {
      $('.users_submit').attr('disabled', false);
    } else {
      $('.users_submit').attr('disabled', "disabled");
    }
  });
});