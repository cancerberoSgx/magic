package app;

import magic.File;
import js.html.AnchorElement;
import js.Browser;
import examples.Example;
import magic.Magic;

using magic.ArrayExtensions;

class Dispatcher {
	public static function executeExample(?ex:Example) {
		var state = Store.getInstance().getState();
		ex = ex == null ? state.example : ex;
		execute(ex.script(state));
	}

	public static function execute(script:String) {
		var state = Store.getInstance().getState();

		Magic.run({
			command: script,
			files: state.inputFiles
		}).then(result -> {
      var  outputFiles = [];
      for(r in result.results) outputFiles = outputFiles.concat(r.files);
			Store.getInstance().setState({
				example: state.example,
				outputFiles: outputFiles.filter2((e,i,a)->a.indexOf(e)==i),
				stdout: result.stdout.join('\n'),
				stderr: result.stderr.join('\n'),
				script: script,
				inputFiles: state.inputFiles
			});
		});
	}

	public static function downloadFile(url:String, filename:String) {
		Browser.window.fetch(url).then(response -> response.blob()).then(blob -> {
			var a = cast(Browser.document.createElement("a"), AnchorElement);
			a.href = js.html.URL.createObjectURL(blob);
			a.setAttribute("download", filename);
			a.click();
		});
	}

	public static function setInputFiles(files:Array<File>) {
		var currentState = Store.getInstance().getState();

		var state = {
			example: currentState.example,
			inputFiles: files,
			stdout: currentState.stdout,
			stderr: currentState.stderr,
			outputFiles: currentState.outputFiles,
			script: ''
		};
		currentState = state;
		currentState.script = currentState.example.script(state);
		Store.getInstance().setState(currentState);
		Dispatcher.executeExample();
	}

	public static function executeExampleNamed(?name:String) {
		name = name == null ? Store.getInstance().getState().example.name : name;
		var ex:Example = Examples.list.find((e,i,a) -> e.name == name);
		executeExample(ex);
	}
}
