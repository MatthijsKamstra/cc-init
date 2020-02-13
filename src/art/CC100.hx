package art;

import js.Browser.*;
import js.html.*;

class CC100 extends SketcherBase {
	var shapeArray:Array<Circle> = [];
	var grid:GridUtil;
	// sizes
	var _radius = 150;
	var _cellsize = 150;
	// colors
	var _color0:RGB = null;
	var _color1:RGB = null;
	var _color2:RGB = null;
	var _color3:RGB = null;
	var _color4:RGB = null;
	// settings
	var panel1:QuickSettings;
	// animate
	var dot:Circle;

	var fontFamly = 'Oswald:200,300,400,500,600,700';

	public function new() {
		// use debug?
		this.isDebug = true;

		super();
		// embed files and then init
		EmbedUtil.embedGoogleFont(fontFamly, init);
		// init
	}

	function init() {
		dot = createShape(100, {x: w2, y: h2});
		createQuickSettings();
		onAnimateHandler(dot);
		drawShape();
	}

	function createQuickSettings() {
		// demo/basic example
		panel1 = QuickSettings.create(10, 10, "Settings")
			.setGlobalChangeHandler(untyped drawShape)

			.addHTML("Reason", "Sometimes I need to find the best settings")

			.addTextArea('Quote', 'text', function(value) trace(value))
			.addBoolean('All Caps', false, function(value) trace(value))

			.setKey('h') // use `h` to toggle menu

			.saveInLocalStorage('store-data-${toString()}');
	}

	function createShape(i:Int, ?point:Point) {
		var shape:Circle = {
			_id: '$i',
			_type: 'circle',
			x: point.x,
			y: point.y,
			radius: _radius,
		}
		// onAnimateHandler(shape);
		return shape;
	}

	function onAnimateHandler(obj:Circle) {
		var padding = 50;
		var time = random(1, 2);
		var xpos = random(padding, w - (2 * padding));
		var ypos = random(padding, h - (2 * padding));
		Go.to(obj, time)
			.x(xpos)
			.y(ypos)
			.ease(Sine.easeInOut)
			.onComplete(onAnimateHandler, [obj]);
	}

	function drawShape() {
		// reset previous sketch
		sketch.clear();

		// background color
		var bg = sketch.makeRectangle(0, 0, w, h, false);
		bg.id = "bg color";

		// group
		var bgGroup = sketch.makeGroup([bg]); // , bg1
		bgGroup.id = "sketch background";
		bgGroup.fill = getColourObj(BLACK); // BLACK

		// quick generate grid
		if (isDebug) {
			sketcher.debug.Grid.gridDots(sketch, grid);
		}

		for (i in 0...shapeArray.length) {
			var sh = shapeArray[i];
		}
		// var rgb = randomColourObject();
		// ctx.strokeColour(rgb.r, rgb.g, rgb.b);
		// ctx.xcross(w/2, h/2, 200);

		var text = sketch.makeText(toString(), w2, h2);
		text.fontFamily = fontFamly;
		text.fillColor = getColourObj(_color4);

		var circle = sketch.makeCircle(dot.x, dot.y, 20);
		circle.strokeWeight = 2;
		circle.strokeColor = getColourObj(_color3);

		// update sketch, to draw svg or canvas
		sketch.update();
	}

	// ____________________________________ override ____________________________________

	override function setup() {
		trace('SETUP :: ${toString()}');

		var colorArray = ColorUtil.niceColor100SortedString[randomInt(ColorUtil.niceColor100SortedString.length - 1)];
		_color0 = hex2RGB(colorArray[0]);
		_color1 = hex2RGB(colorArray[1]);
		_color2 = hex2RGB(colorArray[2]);
		_color3 = hex2RGB(colorArray[3]);
		_color4 = hex2RGB(colorArray[4]);

		isDebug = true;

		// to grid
		grid = new GridUtil(w, h);
		grid.setCellSize(_cellsize);
		// grid.setNumbered(3, 3); // 3 horizontal, 3 vertical
		grid.setIsCenterPoint(true); // default true, but can be set if needed

		shapeArray = [];
		for (i in 0...grid.array.length) {
			shapeArray.push(createShape(i, grid.array[i]));
		}
	}

	override function draw() {
		// trace('DRAW :: ${toString()}');
		drawShape();
		// stop();
	}
}
