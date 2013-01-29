$(function () {

  $('.clear_users_search').click(function () {
     window.location.href = '/admin/users';
  });

  $('.add_service_btn').fancybox();

  $('.extend_service').fancybox();

  $('.new_service_expiry_date_selector').datepicker({
    changeMonth: true,
    changeYear: true,
    dateFormat: 'mm-dd-yy',
    yearRange:'1940:' + new Date().getFullYear()
  });

});
