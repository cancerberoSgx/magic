package;

import js.Browser.*;
import app.*;
import examples.Example.Examples;
import magic.*;

class Main {
	public static function main() {
		IOUtil.fetchResource('bluebells.png', (error:Dynamic, data:haxe.io.BytesData) -> {
			var bytes = haxe.io.Bytes.ofData(data);
      var inputFile = new File('input.png', bytes);
			// var input = new haxe.io.BytesInput(bytes);
			// var bitmap = new PNGBitmap();
			// bitmap.load(input);
			var initialState:State = {
				example: Examples.list[0],
        inputFiles: [inputFile],
        outputFiles: [],
        stdout: '',
        stderr: ''
        // examples: Examples.list
        // command: ['convert' , 'rose:',  '-scale',  '120%']
			};
			Store.init(initialState);
			Store.getInstance().addStateChangeListener({
				onStateChange: (old:State, newState:State) -> {
					Component.renderDom(document.querySelector('#main'), new Layout({state: newState}));
				}
			});
			Store.getInstance().setState(initialState);
		});
	}
}
