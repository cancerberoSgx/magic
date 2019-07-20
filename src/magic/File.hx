package magic;

import magic.*;
import haxe.io.*;

class File {
	public var name:String; // TODO: getter
	// /**
	//  * User can provide mime type which is neded in some situations, like generating a dataUrl. Nevertheless if not provided it will be obtained using ImageMagick `identify` and stored here for future use.
	//  */
	// @:optional public var mimeType:String; //TODO: getter
	public var content:Bytes; // TODO: getter

	public function new(_name:String, _content:Bytes) {
		name = _name;
		content = _content;
	}

	public static function fromFile(path:String, ?preserveDir:Bool):File {
		var name = preserveDir == null ? Path.withoutDirectory(path) : path;
		var content = IOUtil.readFile(path).readAll();
		return new File(name, content);
	}

	public static function fromUrl(url:String):Promise<Null<File>> {
		return new Promise(resolve -> {
			IOUtil.fetchResource(url, (err, data) -> {
				if (err) {
					resolve(null);
					return;
				}
				var name = Util.getFileNameFromUrl(url);
				var content = Bytes.ofData(data);
				resolve(new File(name, content));
			});
		});
	}

	/** Creates a DataUrl like `data:image/png;name=f.png;base64,` using given base64 content, mimeType and fileName. 
	 * TODO: - [ ] asDataUrl / base64 - obtain mimetype with IM if user don't give.
				- [ ] store file mimetype in property for future use.**/
	public function asDataUrl(mime:String) {
		return File.toDataUrl(this, mime);
	}

	/** Returns base64 representation of this image in an ecoded format like PNG  **/
	public function asBase64(file:File) {
		return File.toBase64(file);
	}

	/** Creates a DataUrl like `data:image/png;name=f.png;base64,` using given base64 content, mimeType and fileName.   * TODO: - [ ] asDataUrl / base64 - obtain mimetype with IM if user don't give.
		- [ ] store file mimetype in property for future use.**/
	public static function toDataUrl(file:File, mime:String) {
		return 'data:' + mime + ';' + file.name + ';base64,' + toBase64(file);
	}

	/** Returns base64 representation of this image in an ecoded format like PNG  **/
	public static function toBase64(file:File) {
		return haxe.crypto.Base64.encode(file.content);
	}

	/** Loads file from given base64 string. **/
	public static function fromBase64(base64:String, name:String) {
		return new File(name, haxe.crypto.Base64.decode(base64));
	}

	/** Loads file from given data url string. **/
	public static function fromDataUrl(dataUrl:String, name:String) {
		return fromBase64(Util.urlToBase64(dataUrl), name);
	}

	#if js
	/**
	 * Loads files from files in html input element of type "file"
	 */
	public static function fromHtmlFileInputElement(el:js.html.InputElement):js.lib.Promise<Array<magic.File>> {
		return js.lib.Promise.all([for (file in el.files) file].map(file -> (new js.lib.Promise((resolve, reject) -> {
				var reader = new js.html.FileReader();
				reader.addEventListener('loadend', e -> resolve({name: file.name, content: new js.lib.Uint8Array(reader.result)}));
				reader.readAsArrayBuffer(file);
			})))).then(files -> files.map(f -> {
				var bytes = Bytes.ofData(f.content);
				var file = new File(f.name + '', bytes);
				return file;
			}));
	}
	// public function asGlob() {
	// 	jsBrowser.window.fetch(url).then(response -> response.blob()).then(blob -> {
	// }
	// 		var a = cast(Browser.document.createElement("a"), AnchorElement);
	// 		a.href = js.html.URL.createObjectURL(blob);
	// 		a.setAttribute("download", filename);
	// 		a.click();
	// 	});
	#end
}
