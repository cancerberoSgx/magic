package magic;

import magic.*;
import haxe.io.*;

class File {
	public var name:String; //TODO: getter
	public var content:Bytes;//TODO: getter

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

	/** Creates a DataUrl like `data:image/png;name=f.png;base64,` using given base64 content, mimeType and fileName. **/
	public static function toDataUrl(file:File, ?mime:String = 'image/png', ?name:String) {
		var b64 = toBase64(file);
		return 'data:' + mime + ';'+(name == null ? '' : (name + ';')) + 'base64,' + b64;
	}

  /** Returns base64 representation of this image in an ecoded format like PNG  **/
	public static function toBase64(file:File) {
		// var ii = new BytesOutput();
	// file.save(ii);
		// var bytes = ii.getBytes();
		return haxe.crypto.Base64.encode(file.content);
	}

  /** Loads file from given base64 string. **/
	public static function fromBase64(base64:String, name:String) {
    // file = file==null?new PNGfile():File;
		var bytes = haxe.crypto.Base64.decode(base64);
		// var ii = new BytesInput(bytes);
		// file.load(ii);
    // var o = file ==null?: file
    return new File(name, bytes) ;
	}

  /** Loads file from given data url string. **/
	public static function fromDataUrl(dataurl:String, name:String) {
    var base64 = urlToBase64(dataurl);
    return fromBase64(base64, name);
	}

	public static function urlToBase64(s:String) {
		return s.substring(s.indexOf(';base64,') + ';base64,'.length);
	}

	#if js
  	/**
	 * Loads files from files in html input element of type "file"
	 */
	public static function fromHtmlFileInputElement(el:js.html.InputElement):js.lib.Promise<Array<magic.File>> {
		return js.lib.Promise.all([for (file in el.files) file].map(file -> (new js.lib.Promise((resolve, reject) -> {
				var reader = new js.html.FileReader();
				reader.addEventListener('loadend', e -> resolve({name:file+'', content:new js.lib.Uint8Array(reader.result) }));
				reader.readAsArrayBuffer(file);
			})))).then(files -> files.map(f -> {
				var bytes = Bytes.ofData(f.content);
        var file = new File(f.name+'', bytes);
        return file;
				// var input = new BytesInput(bytes);
				// var file = new PNGfile();
				// file.load(input);
				// return cast(file, file);
			}));
      // #else 
      // throw "Method not available in non js targets";
	}
	#end

}
