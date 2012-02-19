// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

var centi = 0; // initialise les dixtièmes
var secon = 30; //initialise les secondes
var minu = 1; //initialise les minutes

var counter;

function chrono(){
	var chronoId = document.getElementById('chrono');
	centi--;
	
	if (centi == 0 && secon == 0 && minu == 0) {
		chronoId.style.color = "red";
		chronoId.innerHTML = "0:0:0";
		
		clearTimeout(compte);
		return;
	}
	
	if (centi == 0 && secon == 30 && minu == 0) {
		chronoId.style.color = "orange";
	}
	
	if (centi < 0) {
		centi = 9;
		--secon;
	}
	
	if (secon < 0) {
		secon = 59;
		--minu;
	}
	
	chronoId.innerHTML = minu + ":" + secon + ":" + centi;
	counter = setTimeout('chrono()', 100);
}