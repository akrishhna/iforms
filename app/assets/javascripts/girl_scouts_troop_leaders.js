// Place all the behaviors and hooks related to the matching controller here.
//All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(function () {
  $('#add_girl_scout').click(function () {
    var row_count = $('#girl_scouts_table tr.girl_scout_row').size();
    $.get("/girl_scouts_troop_leaders/get_girl_scouts_row",
      {row_count:row_count},
      function (data) {
      });
    return false;
  });

  $('.girl_scout_name, .girl_scout_parent_name, .girl_scout_email').live('blur', function () {
    var row_index = $(this).parents('tr').attr('data_row_number');
    var id = $('#id_' + row_index).val();
    var girl_scout_name = $('#name_' + row_index).val();
    var girl_scout_parent_name = $('#parent_name_' + row_index).val();
    var girl_scout_email = $('#email_' + row_index).val();
    $.post("/girl_scouts_troop_leaders/girl_scouts_roster",
      {row_index:row_index, id:id, name:girl_scout_name, parent_name:girl_scout_parent_name, email:girl_scout_email});
  });

  $('#select_all_check_box').click(function () {
    if ($(this).is(':checked')) {
      $("#girl_scouts_table  input[name=check_box_row]").attr('checked', true);
    }
    else {
      $("#girl_scouts_table  input[name=check_box_row]").attr('checked', false);
    }
  });

  $('#delete_girl_scouts').click(function () {
    var checked_vals = $('#girl_scouts_table input[name=check_box_row]:checked').map(function () {
      return $(this).val();
    }).get();

    if (checked_vals.length != 0) {
      $.post("/girl_scouts_troop_leaders/delete_girl_scouts",{checked_vals:checked_vals.join()});
    }
    return false;
  });

});
