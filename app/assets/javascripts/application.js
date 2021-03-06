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



$(function () {
	setTimeout(updateComments, 1000);
});

function updateComments() {
	if ($('#allvenuesdata').length > 0) {
  		$.getScript('/venues.js');
  		setTimeout(updateComments, 2000);
	} else if ($('#singlevenue').length > 0) {
  		$.getScript('/venues/' + $.trim($("#venueID").text()) + '.js');
  		setTimeout(updateComments, 2000);
	} else {
		setTimeout(updateComments, 1000);
	}
	
}
