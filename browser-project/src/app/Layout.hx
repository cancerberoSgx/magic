package app;

import magic.*;
import examples.Example;
import js.html.*;
import js.lib.*;
import js.Browser;
import app.*;
using StringTools;
using magic.ArrayExtensions;

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
).join('\n')}
<br />

<img class="input" src="${this.props.state.inputFiles[0].asDataUrl('image/png')}"/>

<table>
<tr><td><h3>stdout</h3></td><td><h3>stderr</h3></td></tr>
<tr>
<td><textarea class="stdout">${this.props.state.stdout}</textarea></td>
<td><textarea class="stderr">${this.props.state.stderr}</textarea></td>
</tr>
</table>


${this.props.state.outputFiles.map(f->
  '<img class="output" src="${output.asDataUrl('image/png')}" />').join('\n')}

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
		queryOne('.identify').addEventListener('click', e -> exampleSelected('identify'));
		queryOne('.getSource').addEventListener('click', e -> (cast queryOne('.exampleCode')).scrollIntoViewIfNeeded());
		queryOne('.loadFile').addEventListener('change', e -> {
			magic.File.fromHtmlFileInputElement(e.currentTarget).then(files -> Store.getInstance().setState({
					example: this.props.state.example,
          inputFiles:files, 
          stdout: this.props.state.stdout,
          stderr: this.props.state.stderr,
          outputFiles: this.props.state.outputFiles
				}));
		});
		var i = 0;
		for (output in query('.output')) {
			untyped output.addEventListener('click', e -> applicationDownload(e.currentTarget.src, 'output-' + i++ + '.png'));
		}
	}

	function exampleSelected(name:String) {
		var ex:Example = Examples.list.find(e->e.name==name);
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
	}
}