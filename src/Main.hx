package;

import js.Browser.*;
import js.Browser;
import js.html.*;

import model.constants.App;

// sketch
import Sketch;
import art.*;
// settings
import quicksettings.QuickSettings;

class Main {

	// settings
	var panel1:QuickSettings;

	public function new () {
		trace('START :: main');
		document.addEventListener("DOMContentLoaded", function(event) {
			console.log('${App.NAME} Dom ready :: build: ${App.BUILD} ');
			var cc = new CC100();
		});
	}

	function createQuickSettings() {
		// demo/basic example
		panel1 = QuickSettings.create(10, 10, "Settings")

			// .setGlobalChangeHandler(untyped setValues)
			.addHTML("cc-paper", "different paper sizes and resolution").addDropDown('Mode', ['Portrait', 'Landscape'], function(obj) setMode(obj))

			// .addDropDown('Paper size', Paper.ARR, function(obj) setPaper(obj)).addDropDown('DPI', DPI.ARR, function(obj) setDPI(obj))

			// // .addTextArea('Quote', 'text', function(value) trace(value))
			// .addTextArea('out', '', function(value) trace(value)) // .addBoolean('All Caps', false, function(value) trace(value))

			.setKey('h') // use `h` to toggle menu

			.saveInLocalStorage('cc-paper');
	}


	static public function main () {
		var app = new Main ();
	}
}