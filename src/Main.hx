package;

import js.Browser.*;
import svg.*;

using StringTools;

class Main {
	var count:Int;
	var hash:String;
	var ccTypeArray:Array<Class<Dynamic>> = [art.CC100];

	public function new() {
		trace('START :: main');
		document.addEventListener("DOMContentLoaded", function(event) {
			console.log('${model.constants.App.NAME} Dom ready :: build: ${model.constants.App.getBuildDate()}');
			// var cc = new art.CC100();
			// var cc = new svg.Calendar();
			setupArt();
			setupNav();
		});
	}

	function setupArt() {
		// get hash from url
		hash = js.Browser.location.hash;
		hash = hash.replace('#', '');

		var clazz = Type.resolveClass('art.${hash}');
		if (clazz == null) {
			// make sure if it's not in the list, show the latest Sketch
			clazz = ccTypeArray[ccTypeArray.length - 1];
		}
		count = ccTypeArray.indexOf(clazz);
		var cc = Type.createInstance(clazz, []);

		changeHash();
	}

	function setupNav() {
		// make sure the browser updates after changing the hash
		window.addEventListener("hashchange", function() {
			location.reload();
		}, false);

		// use cursor key lef and right to switch sketches
		window.addEventListener(KEY_DOWN, function(e:js.html.KeyboardEvent) {
			switch (e.key) {
				case 'ArrowRight':
					count++;
				case 'ArrowLeft':
					count--;
				case 'ArrowUp':
					count = ccTypeArray.length - 1;
				case 'ArrowDown':
					count = 0;
					// default : trace ("case '"+e.key+"': trace ('"+e.key+"');");
			}
			changeHash();
		}, false);
	}

	function changeHash() {
		location.hash = Type.getClassName(ccTypeArray[count]).replace('art.', '');
	}

	static public function main() {
		var app = new Main();
	}
}
