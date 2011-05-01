function load_google_maps() {
	console.log('loading google maps')
	var latlng = new google.maps.LatLng(40.4, -3.6833333);
	var myOptions = {
		zoom: 12,
		center: latlng,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	};
	var map = new google.maps.Map(document.getElementById("map"), myOptions);
}