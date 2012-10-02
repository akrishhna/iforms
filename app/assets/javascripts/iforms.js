$('.adult_iforms_nav_link').live('click',function () {
  console.log($(this).attr('data_tab_index'));
  var tab_index = parseInt($(this).attr('data_tab_index'));
  $("#adult_iforms_tab_links a:eq(" + tab_index + ")").tab('show');
 // return false;
});

$('.chaild_iforms_nav_link').live('click',function () {
  console.log($(this).attr('data_tab_index'));
  var tab_index = parseInt($(this).attr('data_tab_index'));
  $("#chaild_iforms_tab_links a:eq(" + tab_index + ")").tab('show');
  // return false;
});
