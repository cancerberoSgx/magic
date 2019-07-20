package;

import js.Browser.*;
import app.*;
import examples.Example.Examples;
import magic.*;

class Main {
	public static function main() {
		File.fromUrl('bluebells.png').then(file -> {
			if (file == null) {
				throw "An error occurs loading default initial image";
			}
			var ex = Examples.list[0];
			var initialState:State = {
				example: ex,
				inputFiles: [file],
				outputFiles: [],
				stdout: '',
				stderr: '',
				command: []
			};
			initialState.command = ex.command(initialState);
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
