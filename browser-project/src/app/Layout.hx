package app;

import magic.*;
import examples.Example;
import js.html.*;
import js.lib.*;
import js.Browser;
import app.*;
using StringTools;
using magic.ArrayExtensions;

// <h3>Example code</h3>
// <textarea class="exampleCode">${this.props.state.example.getSource()}</textarea>
// <!--
// <button class="shapes ${this.props.state.example.getName() == 'shapes' ? 'selected' : ''}">Shapes</button>
// <button class="convolutions ${this.props.state.example.getName() == 'convolutions' ? 'selected' : ''}">Convolutions</button>
// <button class="affine ${this.props.state.example.getName() == 'affine' ? 'selected' : ''}">Affine</button>
// <button class="pixelize ${this.props.state.example.getName() == 'pixelize' ? 'selected' : ''}">Pixelize</button>
// <button class="text ${this.props.state.example.getName() == 'text' ? 'selected' : ''}">Text</button>
// -->
class Layout extends Component<Component.Props> {
	override public function render() {
		return '
<h1>Magic playground</h1>
<p>Welcome to Magic library playground! An image should be shown below (loaded as Magic bitmap). Play with the controls to see it in action. Click on output images to download them.</p>
<br />
<label>Load File <input type="file"  class="loadFile"></label> <br />
<button class="getSource">See Example Sources</button>

${Examples.list.map(e->
'<button class="${e.name} ${this.props.state.example.name == e.name ? 'selected' : ''}">${e.name}</button>'
)}
<br />

<img class="input" src="${magic.File.toDataUrl(this.props.state.inputFiles[0])}"/>

<table><tr><h3>stdout</h3><td><h3>stderr</h3></td></tr>
<tr>
<textarea class="stdout">${this.props.state.stdout}</textarea><td>
<textarea class="stderr">${this.props.state.stderr}</textarea></td></tr>
</table>


${[for(output in this.props.state.outputFiles)'<img class="output" src="${magic.File.toDataUrl(output)}" />'].join('\n')}

<br />

<style>
${Styles.css}
</style>
  ';
	}

	function applicationDownload(url:String, filename:String) {
		Browser.window.fetch(url).then(response -> response.blob()).then(blob -> {
			var a = cast(Browser.document.createElement("a"), AnchorElement);
			a.href = js.html.URL.createObjectURL(blob);
			a.setAttribute("download", filename);
			a.click();
		});
	}

	override function afterRender() {
		// queryOne('.shapes').addEventListener('click', e -> exampleSelected('shapes'));
		// queryOne('.convolutions').addEventListener('click', e -> exampleSelected('convolutions'));
		// queryOne('.affine').addEventListener('click', e -> exampleSelected('affine'));
		// queryOne('.pixelize').addEventListener('click', e -> exampleSelected('pixelize'));
		queryOne('.identify').addEventListener('click', e -> exampleSelected('identify'));
		// queryOne('.text').addEventListener('click', e -> exampleSelected('text'));
		queryOne('.getSource').addEventListener('click', e -> (cast queryOne('.exampleCode')).scrollIntoViewIfNeeded());
		queryOne('.loadFile').addEventListener('change', e -> {
			magic.File.fromHtmlFileInputElement(e.currentTarget).then(files -> Store.getInstance().setState({
					example: this.props.state.example,
          inputFiles:files, 
          stdout: this.props.state.stdout,
          stderr: this.props.state.stderr,
          outputFiles: this.props.state.outputFiles
					// output: [for (i in 0...5) bitmaps[0].clone()],
					// bitmap: bitmaps[0]
				}));
		});
		var i = 0;
		for (output in query('.output')) {
			untyped output.addEventListener('click', e -> applicationDownload(e.currentTarget.src, 'output-' + i++ + '.png'));
		}
	}

	function exampleSelected(name:String) {
		var ex:Example = Examples.list.find(e->e.name==name);
    untyped debugger;
    Magic.call({
      command: ex.command,
      files: this.props.state.inputFiles
    }).then(result->{
      Store.getInstance().setState({
						example: ex,
						outputFiles: result.files,
						stdout: result.stdout,
						stderr: result.stderr,
						inputFiles: this.props.state.inputFiles
					});
    });
  // if (name == 'shapes') {
	// 		ex = new Shapes();
	// 	}  
    // else {
		// 	throw "example not recognized";
		// }
		// if (ex != null) {
			// ex.run({
			// 	bitmap: this.props.state.bitmap,
			// 	done: result -> {
			// 		Store.getInstance().setState({
			// 			example: ex,
			// 			output: result.output,
			// 			bitmap: this.props.state.bitmap
			// 		});
			// 	}
			// });
		// }
	}
}