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
    $('.council_type_status.ok').hide();
    $('.council_type_status.default').show();
    $('#user_girl_scout_troop_leader_profile_attributes_council_type.default').val('');
    if(value == "boy_scouts") {
      $('#user_girl_scout_troop_leader_profile_attributes_council_type').html(boy_scouts_council_options);
    } else if (value == "girl_scouts") {
      $('#user_girl_scout_troop_leader_profile_attributes_council_type').html(girl_scouts_council_options);
    }
  });

  /* end Sign up page */
});