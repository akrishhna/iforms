// Place all the behaviors and hooks related to the matching controller here.
//All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
//= require consumer

$(function () {

  if ($('.page').attr('data-page') == "consumer_index") {
    $(window).load(function () {
      if (consumer_tab_index != '' && consumer_tab_index != "1") {
        var tab_index = parseInt(consumer_tab_index);
        $("#consumer_tab_links a:eq(" + tab_index + ")").tab('show');
      } else {
         $("#boy_scouts").attr('data-is_loaded', 'true');
        //$("#boy_scouts").load('/consumer/boy_scouts_list');
        $("#boy_scouts").load('/consumer/boy_scouts');
      //  $("#dental").attr('data-is_loaded', 'true');
       // $("#dental").load('/consumer/dental');
      }
    });

    $('#consumer_tab_links li a').on('shown', function (e) {
      if ($($(this).attr('href')).attr('data-is_loaded') == 'false') {
        $($(this).attr('href')).attr('data-is_loaded', 'true');
        $($(this).attr('href')).load('/consumer/' + $(this).attr('data-action'));
      }
      return false;
    });
  }

  /* Boys Scout Tab */
  $('.boy_scout_attending').live('change', function () {
    var selected_val = $(this).attr('data-value');
    var id = $(this).attr('data-id');
    $.post("/consumer/boy_scouts/boy_scout_attending_val_change", {id:id,selected_val:selected_val})
  });

  /* end Girl Scout Tab */
  /* Girl Scout Tab */

  $('.girl_scout_attending').live('change', function () {
    var selected_val = $(this).attr('data-value');
    var id = $(this).attr('data-id');
    $.post("/consumer/girl_scouts/girl_scout_attending_val_change", {id:id,selected_val:selected_val})
  });

  /* end Girl Scout Tab */

  /* Dental */

  $(".show_all").live('change', function () {
    window.location = '/consumer';
  });

  $('.pagination a').live("click", function () {
   if ($(this).attr('href') == '#'){
     return false
   }
    $('.pagination').html('Page is loading...');
    $.get(this.href, null, null, 'script');
    return false;
  });
  /* end  Dental Tab */

});
