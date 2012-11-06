$(function () {

  $('.clear_users_search').click(function () {
     window.location.href = '/admin/users';
  });

  $('.add_service_btn').fancybox();

  $('.extend_service').fancybox();

  $('.expiry_date_selector').datepicker().datepicker("option", "dateFormat", "yy-mm-dd");

  $('.new_service_expiry_date_selector').datepicker().datepicker("option", "dateFormat", "yy-mm-dd");

});
