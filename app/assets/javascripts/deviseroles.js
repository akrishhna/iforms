$(function () {

  $('.contact_us').change(function () {
    if ($('#name').val() != "" && $('#email').val() != "" && $('#subject').val() != "" && $('#message').val() != "") {
      $('.contact_us_submit').attr('disabled', false);
    } else {
      $('.contact_us_submit').attr('disabled', "disabled");
    }
  });

  /* Sign up page */

  $('.select_council_type_for_sign_up').change(function() {
    var value = $('.select_council_type_for_sign_up:checked').val();
    if(value == "boy_scouts") {
      $('.council_type').hide();
      $('.council_type_status.ok').hide();
      $('.council_type_status.default').hide();
      // $('#user_girl_scout_troop_leader_profile_attributes_council_type').html(boy_scouts_council_options);
    } else if (value == "girl_scouts") {
      $('.council_type').show();
      $('.council_type_status.ok').hide();
      $('.council_type_status.default').show();
      $('#user_girl_scout_troop_leader_profile_attributes_council_type').val('');
     // $('#user_girl_scout_troop_leader_profile_attributes_council_type').html(girl_scouts_council_options);
    }
  });

  $('#user_username, #user_email , #user_password, #user_password_confirmation').keyup(function(){
    var params = $('#new_user').serializeArray();
    $.post('/deviseroles/validate_girl_scout_sign_up_page',params );
    return false;
  });

  $('select#user_girl_scout_troop_leader_profile_attributes_council_type').change(function(){
    var params = $('#new_user').serializeArray();
    $.post('/deviseroles/validate_girl_scout_sign_up_page',params );
    return false;
  });
  /* end Sign up page */
});