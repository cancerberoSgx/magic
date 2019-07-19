package magic;

class Exec {
	private static var _hasNativeIM:Bool;

	public static function hasNativeIM():Bool {
		if (_hasNativeIM == null) {
			_hasNativeIM = !commandThrows('convert', ['-version'], 'Version: ImageMagick');
		}
		return _hasNativeIM;
	}

	public static function commandThrows(cmd:String, args:Array<String>, ?stdoutIncludes:String):Bool {
		// if (_hasNativeIM == null) {
		var process = new sys.io.Process(cmd, args);
		// trace(process.exitCode());
		if (process.exitCode() != 0) {
			return true;
			// var stderr = process.stderr.readAll().toString();
			// trace(stderr);
			// _hasNativeIM = false;
		} else {
			if (stdoutIncludes != null) {
				var stdout = process.stdout.readAll().toString(); // trace(stdout);
				return stdout.indexOf(stdoutIncludes) == -1;
			}
			return false;
			// if(stdout.join(' ').indexOf('Version: ImageMagick')!=-1) {
			// _hasNativeIM = stdout.indexOf('Version: ImageMagick') != -1;
			// }s
			// trace(stdout, stdout.indexOf('Version: ImageMagick'));
		}
		// }
		// return _hasNativeIM;
	}
}
