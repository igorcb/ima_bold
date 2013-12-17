// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
$(function() {
    return $(".checkbox").click(function() {
      var $checkbox = $(this)[0];
      if ($checkbox.checked === true) {
        return $($checkbox).attr("checked", "checked");
      } else {
        return $($checkbox).removeAttr("checked");
      }
    });
  });

  //this method will toggle ALL checkboxes 
  //from checked to unchecked
  $(function() {
    return $("#check-all").click(function() {
      if ($(this).attr("checked") != null) {
        var $all = $(':checkbox');
        return $.each($($all), function(index, box) {
          var $box=$(box);
          return $box.attr("checked", "checked");
        });
      } else {
          var $all = $(':checkbox');
          return $.each($($all), function(index, box) {
          var $input;
            var $box=$(box);
          return $box.removeAttr('checked');
        });
      }
    });
  });