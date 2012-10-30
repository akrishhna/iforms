
//= require jquery.format.1.05
//= require jquery.currency


$(function () {

// activity tabs

  $(".girl_scout_diamonds_activity_date_selector").datepicker().datepicker("option", "dateFormat", "yy-mm-dd");
  $('#girl_scout_diamondactivity_activity_date_begin').datepicker("setDate", $('#girl_scout_diamondactivity_activity_date_begin').attr('data-value'));
  $('#girl_scout_diamondactivity_activity_date_end').datepicker("setDate", $('#girl_scout_diamondactivity_activity_date_end').attr('data-value'));
  $('#girl_scout_diamondactivity_activity_signed_permission_due_date').datepicker("setDate", $('#girl_scout_diamondactivity_activity_signed_permission_due_date').attr('data-value'));

  $('.activity_nav_link').click(function () {
    var tab_index = parseInt($(this).attr('data_tab_index'));
    $("#activity_tab_links a:eq(" + tab_index + ")").tab('show');
    return false;
  });

  $('select#girl_scout_diamonds_activities').change(function () {
    if ($(this).val() == 0) {
      //window.location.reload();
      // window.location = '/girl_scouts_troop_leaders/activities?id=' + 'new';
    } else {
      window.location = '/girl_scout_diamonds/activities?id=' + $(this).val();
    }
  });

  $('.create_new_activity').click(function(){
    window.location = '/girl_scout_diamonds/activities?id=' + 'new';
  });


  $('.girl_scout_diamonds_activity_form input,.girl_scout_diamonds_activity_form select').change(function () {
    $('input[name=_method]').val('post');
    var params = $('.girl_scout_diamonds_activity_form').serializeArray();
    $.post('/girl_scout_diamonds/create_activity', params).success(function () {
      $('#activity_cost_dollars').currency({
        decimals:0,
        hidePrefix:true
      });
    });
    return false;
  });


  $('#notification_email_to_parent').click(function () {
    if ($(this).attr('disabled') == "disabled") {
      return false;
    }
    $(this).attr('disabled', "disabled");
    $(this).text('Sending Email...');
    var id = $('.girl_scout_diamonds_activity_form #girl_scout_diamondactivity_id').val();
    $.post('/girl_scout_diamonds/send_notification_email', {id:id});
    return false;
  });

  $('.delete_activity').click(function () {
    var id = $('.girl_scout_diamonds_activity_form #girl_scout_diamondactivity_id').val();
    if (id != '') {
      $.fancybox({
        href:'#delete_activity_alert_box',
        closeBtn:false
      });
    }
    return false;
  });

  $('#delete_activity_yes').click(function () {
    var id = $('.girl_scout_diamonds_activity_form #girl_scout_diamondactivity_id').val();
    $.post('/girl_scout_diamonds/delete_activity', {id:id});
    return false;
  });

  $('#activity_cost_dollars').format({type:'decimal', precision:0, allow_negative:false, autofix:true});
  var activity_cost_dollars
  $('#activity_cost_dollars').keyup(function (e) {
    $('#hidden_activity_cost_dollars').val($(this).val());
    if ($(this).val().length <= 5 && $(this).val() <= 99999) {
      activity_cost_dollars = $(this).val();
    } else {
      if (e.keyCode == 8 || e.keyCode == 9 || e.keyCode == 13 || e.keyCode == 37 || e.keyCode == 39 || e.keyCode == 46) {
        return true;
      } else {
        $(this).val(activity_cost_dollars);
      }
    }
  });

  $('#activity_cost_dollars').currency({
    decimals:0,
    hidePrefix:true
  });
  var activity_cost_cents;
  $('#activity_cost_cents').keyup(function (e) {

    if ($(this).val().length <= 2 && $(this).val() <= 99) {
      if (e.keyCode >= 48 && e.keyCode <= 57) {
        activity_cost_cents = $(this).val();
      }
    } else {
      if (e.keyCode == 8 || e.keyCode == 9 || e.keyCode == 13 || e.keyCode == 37 || e.keyCode == 39 || e.keyCode == 46) {
        return true;
      } else {
        $(this).val(activity_cost_cents)
      }
    }
  });

  $('#activity_cost_cents').blur(function () {
    if ($(this).val().length < 2) {
      var hh = $(this).val();
      $(this).val('0' + hh);
    }
  });

  $('#girl_scout_diamonds_activities option:first').hide();

// end activity tabs


});
