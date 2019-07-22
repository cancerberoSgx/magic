package app;

import magic.File;
import examples.Example.Examples;
import examples.SampleImages;
import app.*;


class Layout extends Component<Component.Props> {
	override public function render() {
		return '
<h1>Magic playground</h1>

<p>Welcome to <a href="https://github.com/cancerberoSgx/magic">magic</a> playground, a <a href="https://haxe.org" rel="nofollow">Haxe</a> API for running <a href="https://github.com/ImageMagick/ImageMagick">ImageMagick</a> commands like <code>convert</code>, <code>identify</code>, supporting all haxe targets, <strong>even the browser</strong> (!) thanks to <a href="https://cancerberosgx.github.io/magica/" rel="nofollow">magica</a>, an <a href="https://emscripten.org/" rel="nofollow">emscripten</a> port of <a href="https://github.com/ImageMagick/ImageMagick">ImageMagick</a> that allows to programmatically call its <code>convert</code>, <code>identify</code>, etc. commands in a programmatic way.</p>

<p>Load images from your system or urls. <strong>A lot of formats are supported!</strong> like png, jpg, gif, tiff, bmp, tga, psd, ps, pdf, svg, heic, dpx, etc. Click on output images to download them. Edit the commands and run them again. Check for logs and errors. Checkout the example list to search for something similar you want to accomplish.</p>

<br />

<h3 class="inline">Examples</h3>
<select class="examples">
  ${Examples.list.map(e->
  '<option ${this.props.state.example.name == e.name ? 'selected' : ''} value="${e.name}">${e.name}</option>'
  ).join(' ')}
</select>
Description: ${this.props.state.example.description}

<br />


<h3 class="inline">Load Images</h3>
<label>From file: 
  <input type="file"  class="loadFile"/></label>
<label>Sample Image: 
  <select class="sample-images">
  ${SampleImages.list.map(e->
    '<option value="${e}">${e}</option>'
  ).join(' ')}
  </select>
</label>
<br />


<h3>Commands</h3>

<textarea class="command">${this.props.state.script}</textarea>
<br />

<button class="execute">Execute</button>
<br />

<h3>Input files</h3>

${this.props.state.inputFiles.map(function(f){
  return '
<div class="image">
<img data-name="${f.name}" class="input" src="${f.asDataUrl('image/png')}"/> 
<br/>
<span><a href="#" class="input"> ${f.name}</a> (${Math.round(f.content.length / 1000)} KB)</span>
</div>';}).join(" ")}

<h3>Output files</h3>
${this.props.state.outputFiles.map(function(f){return '
<div class="image">
<img data-name="${f.name}"  class="output" src="${f.asDataUrl("image/png")}" />
<br/>
<span><a href="#" class="input"> ${f.name}</a> (${Math.round(f.content.length / 1000)} KB)</span>
</div>';}).join(" ")}
<br/>

<table>
  <tr>
    <td><h3>stdout</h3></td><td><h3>stderr</h3></td>
  </tr>
  <tr>
    <td><textarea class="stdout">${this.props.state.stdout}</textarea></td>
    <td><textarea class="stderr">${this.props.state.stderr}</textarea></td>
  </tr>
</table>

<style>
${Styles.css}
</style>

<a href="https://github.com/cancerberoSgx/magic" style="opacity:0.6;position:fixed;padding:5px 45px;width:auto;top:30px;right:-60px; -webkit-transform:rotate(45deg);-moz-transform:rotate(45deg);-ms-transform:rotate(45deg);transform:rotate(45deg);box-shadow:0 0 0 3px #f6c304, 0 0 20px -3px rgba(0, 0, 0, 0.5);text-shadow:0 0 0 #555555, 0 0 5px rgba(0, 0, 0, 0.3);background-color:#f6c304;color:#555555;font-size:13px;font-family:sans-serif;text-decoration:none;font-weight:bold;border:2px dotted #555555;-webkit-backface-visibility:hidden;letter-spacing:.5px;">Fork me on GitHub</a>
';

	}

	override function afterRender() {
		queryOne('.execute').addEventListener('click', Dispatcher.executeExampleNamed);

		queryOne('.sample-images').addEventListener('change', e -> File.fromUrl(e.currentTarget.value).then(file -> Dispatcher.setInputFiles([file])));

		queryOne('.examples').addEventListener('change', e -> Dispatcher.executeExampleNamed(e.currentTarget.value));

		queryOne('.examples').addEventListener('change', e -> Dispatcher.executeExampleNamed(e.currentTarget.value));

		queryOne('.loadFile').addEventListener('change', e -> File.fromHtmlFileInputElement(e.currentTarget).then(Dispatcher.setInputFiles));

		for (output in query('.output, .input'))
			output.addEventListener('click', e -> Dispatcher.downloadFile(e.currentTarget.src, e.currentTarget.getAttribute('data-name')));
	}
}
