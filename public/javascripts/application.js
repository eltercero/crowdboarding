$(document).ready(function() {
	mouseOverHelmet();
});

mouseOverHelmet = function(){
	$("div#helmet").mouseover(function() {
		$(this).css('background-position', '0 -123px');
	}).mouseout(function() {
		$(this).css('background-position', '0 0');
	});
}