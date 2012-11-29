$(function () {

  $(".medical_Patient_form_date_selector").datepicker().datepicker("option", "dateFormat", "yy-mm-dd");

  $('.medical_patient_form_nav_link').live('click', function () {
    // console.log($(this).attr('data_tab_index'));
    var tab_index = parseInt($(this).attr('data_tab_index'));
    $("#medical_patient_form_tab_links a:eq(" + tab_index + ")").tab('show');
    // return false;
  });

});