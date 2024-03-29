package magic;

import magic.Magica;
import magic.*;
import magic.Dispatcher.Dispatch;

using StringTools;

typedef MagicCallOptions = {
	> MagicBaseOptions,
	var command:Array<String>;
};

typedef MagicBaseOptions = {
	@:optional var debug:Bool;
	@:optional var files:Array<File>;
};

typedef MagicRunOptions = {
	> MagicBaseOptions,
	var command:String;

	/**
	 * P ses or URLs f ot shtawhich will be loaded from filesystem or if not found (or in the browser) as URLs.
	 */
	@:optional var filePaths:Array<String>;
};

typedef MagicResults = {
	var files:Array<File>;
	var stdout:String;
	var stderr:String;
	var error:Any;
	var code:Int;
};

typedef MagicRunResults = {
	var files:Array<File>;
	var stdout:Array<String>;
	var stderr:Array<String>;
	var results:Array<MagicResults>;
	var error:Any;
	var code:Int;
};

class Magic {
	/**
	 * Low level call. Files must be passed as {name, content:Byte} and command must be a array of string
	 */
	public static function call(o:MagicCallOptions):Promise<MagicResults> {
		return new Promise<MagicResults>(resolve -> Dispatch.get().then(dispatcher -> dispatcher.call(o).then(resolve)));
	}

	/**
	 * High level call. Files can be passed both as File objects or as strings. In later case, depending on the environment,
	 * it will try to be read from filesystem or loaded from URLs  and their names will be inferred automatically from those paths.
	 *
	 * Also, the command can be a single string which will be automatically split.
	 */
	public static function run(o:MagicRunOptions):Promise<MagicRunResults> {
		return new Promise<MagicRunResults>(resolve -> {
			MagicaDispatcher.isMagicaApiAvailable()
				.then(magicaAvailable -> {
					if (!magicaAvailable) {
						throw "Magic.run() is currently only available in JS targets using magica API. Use Magic.call() instead.";
					}
					MagicaDispatcher.getMagicaEntryPoint()
						.then(magica -> {
							if (magica == null) {
								throw "Magica API not available";
							}
							var inputFiles = o.files == null ? [] : o.files;
							Promise.all((o.filePaths == null ? [] : o.filePaths)
								.map(File.resolve))
								.then(files -> {
									inputFiles = inputFiles.concat(files.filter(f -> f != null));
									var options:MagicaRunOptions = {
										debug: o.debug,
										script: o.command.trim(),
										inputFiles: inputFiles.map(f -> f.toMagicaFile())
									};
									magica.run(options)
										.then(r -> {
											var result:MagicRunResults = {
												results: r.results.map(magicaToMagicResult),
												stdout: r.stdout,
												stderr: r.stderr,
												files: r.outputFiles.map(File.fromMagicaFile),
												code: r.error == null ? 0 : 1,
												error: r.error
											};
											resolve(result);
										});
								});
						});
				});
		});
	}

	static function magicaToMagicResult(r:MagicaResult):MagicResults {
		return {
			error: r.error,
			code: r.error == null ? 0 : 1,
			stdout: r.stdout.join('\n'),
			stderr: r.stderr.join('\n'),
			files: r.outputFiles.map(File.fromMagicaFile)
		}
	}

	// static var config:Map<String,String> = new Map();
	// TODO: haxe issue I needed to declared function if not in js i get Error: Cannot read property 'ignoreNativeIM' of undefined
	// public static var config:Config = defaultConfig;
	public static var config:Config = {
		ignoreNativeIM: false,
		magicaOnlyBrowser: false,
		debug: false,
		ignoreMagica: false
	};
}

typedef Config = {
	var ignoreNativeIM:Bool;
	var magicaOnlyBrowser:Bool;
	var ignoreMagica:Bool;
	var debug:Bool;
};
