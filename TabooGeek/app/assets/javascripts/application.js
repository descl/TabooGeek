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

var centi = 0 // initialise les dixtièmes
var secon = 0 //initialise les secondes
var minu = 0 //initialise les minutes

function chrono(){
	centi++; //incrémentation des dixièmes de 1
	
	if (centi>9) { //si les dixièmes > 9, on les réinitialise à 0 et on incrémente les secondes de 1
		centi=0;
		secon++
	}
	
	if (secon>59) { //si les secondes > 59, on les réinitialise à 0 et on incrémente les minutes de 1
		secon=0;
		minu++
	}
	
	document.getElementById('chrono').innerHTML = minu + ":" + secon + ":" + centi //on affiche le résultat
	
	compte = setTimeout('chrono()', 100) //la fonction est relancée tous les 10° de secondes
}