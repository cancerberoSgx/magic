package magic;

class Exec {
	private static var _hasNativeIM:Null<Bool>;

	public static function hasNativeIM():Bool {
		if (_hasNativeIM == null) {
			_hasNativeIM = !commandThrows('convert', ['-version'], 'Version: ImageMagick');
		}
		return _hasNativeIM;
	}

	public static function commandThrows(cmd:String, args:Array<String>, ?stdoutIncludes:String):Bool {
    var p = IOUtil.execFileSync(cmd, args);
		if (p.code != 0) {
			return true;
		} else {
			if (stdoutIncludes != null) { 
				return p.stdout.indexOf(stdoutIncludes) == -1;
			}else {
			return false;
      }
		}
	}
}
