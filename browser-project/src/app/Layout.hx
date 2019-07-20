package app;

import magic.*;
import examples.*;
import examples.Example.Examples;
import examples.Example.Example;
import examples.SampleImages;
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
<p>Welcome to <a href="https://github.com/cancerberoSgx/magic">magic</a> playground, a <a href="https://haxe.org" rel="nofollow">Haxe</a> API for running <a href="https://github.com/ImageMagick/ImageMagick">ImageMagick</a> commands like <code>convert</code>, <code>identify</code>, supporting all haxe targets, <strong>even the browser</strong> (!) thanks to <a href="https://cancerberosgx.github.io/magica/" rel="nofollow">magica</a>, an <a href="https://emscripten.org/" rel="nofollow">emscripten</a> port of <a href="https://github.com/ImageMagick/ImageMagick">ImageMagick</a> that allows to programmatically call its <code>convert</code>, <code>identify</code>, etc. commands in a programmatic way.</p>

<p>Load images from your system or urls. <strong>A lot of formats are supported!</strong> like png, jpg, gif, tiff, bmp, tga, psd, ps, pdf, svg, heic, dpx, etc. Click on output images to download them. Edit the commands and run them again. Check for logs and errors. Checkout the example list to search for something similar you want to accomplish.</p>
<br />

<label>Load File <input type="file"  class="loadFile"></label> <br />


<h3>Examples</h3>
<select class="examples">
${Examples.list.map(e->
'<option ${this.props.state.example.name == e.name ? 'selected' : ''} value="${e.name}">${e.name}</option>'
).join(' ')}
</select>

<br />


<h3>Sample Images</h3>
<select class="sample-images">
${SampleImages.list.map(e->
'<option value="${e}">${e}</option>'
).join(' ')}
</select>
<br />


<textarea class="command">${haxe.Json.stringify(this.props.state.command)}</textarea>
<br />

<button class="execute">Execute</button>
<br />
<h3>Input files</h3>
${this.props.state.inputFiles.map(function(f){return '<img data-name="${f.name}" class="input" src="${f.asDataUrl('image/png')}"/> ';}).join(" ")}



<h3>Output files</h3>

${this.props.state.outputFiles.map(function(f){return '<img data-name="${f.name}"  class="output" src="${f.asDataUrl("image/png")}" />';}).join(" ")}
<br/>

<table>
<tr><td><h3>stdout</h3></td><td><h3>stderr</h3></td></tr>
<tr>
<td><textarea class="stdout">${this.props.state.stdout}</textarea></td>
<td><textarea class="stderr">${this.props.state.stderr}</textarea></td>
</tr>
</table>

<style>
${Styles.css}
</style>

<a href="https://github.com/cancerberoSgx/magic" style="opacity:0.6;position:fixed;padding:5px 45px;width:auto;bottom:20px;left:-60px; -webkit-transform:rotate(45deg);-moz-transform:rotate(45deg);-ms-transform:rotate(45deg);transform:rotate(45deg);box-shadow:0 0 0 3px #f6c304, 0 0 20px -3px rgba(0, 0, 0, 0.5);text-shadow:0 0 0 #555555, 0 0 5px rgba(0, 0, 0, 0.3);background-color:#f6c304;color:#555555;font-size:13px;font-family:sans-serif;text-decoration:none;font-weight:bold;border:2px dotted #555555;-webkit-backface-visibility:hidden;letter-spacing:.5px;">Fork me on GitHub</a>

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
		queryOne('.execute').addEventListener('click', e -> exampleSelected(this.props.state.example.name));

		queryOne('.sample-images').addEventListener('change', e -> {
			magic.File.fromUrl(e.currentTarget.value).then(file -> {
				setInputFiles([file]);
			});
		});

		queryOne('.examples').addEventListener('change', e -> {
			var name = e.currentTarget.value;
			var ex:Example = Examples.list.find(e -> e.name == name);
			executeExample(ex);
		});

		queryOne('.loadFile').addEventListener('change', e -> {
			magic.File.fromHtmlFileInputElement(e.currentTarget).then(files -> {
				setInputFiles(files);
			});
		});

		for (output in query('.output, .input')) {
			untyped output.addEventListener('click', e -> applicationDownload(e.currentTarget.src, e.currentTarget.getAttribute('data-name')));
		}
	}

	function setInputFiles(files:Array<magic.File>) {
		var state = {
			example: this.props.state.example,
			inputFiles: files,
			stdout: this.props.state.stdout,
			stderr: this.props.state.stderr,
			outputFiles: this.props.state.outputFiles,
			command: []
		};
    this.props.state=state;
		this.props.state.command = this.props.state.example.command(state);
		Store.getInstance().setState(this.props.state);
    executeExample(this.props.state.example);
    // js.Browser.window.setTimeout(()->executeExample(this.props.state.example), 1000);
		// executeExample(state.example);
	}

	function exampleSelected(name:String) {
		var ex:Example = Examples.list.find(e -> e.name == name);
		executeExample(ex);
	}

	function executeExample(ex:Example) {
		var command = ex.command(this.props.state);
		Magic.call({
			command: command,
			files: this.props.state.inputFiles
		}).then(result -> {
			Store.getInstance().setState({
				example: ex,
				outputFiles: result.files,
				stdout: result.stdout,
				stderr: result.stderr,
				command: command,
				inputFiles: this.props.state.inputFiles
			});
		});
	}
}
