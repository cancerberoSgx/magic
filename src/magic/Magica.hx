package magic;

typedef MagicaRunOptions = {
	> MagicaBaseOptions,

	/**
	 * An ImageMagick command, for example: `['convert', 'foo/bar.png', '-scale', '50%', 'out.gif']`
	 */
	var script:String;
};

typedef MagicaBaseOptions = {
	/**
	 * The list of input files referenced in given [[command]]. It's important that the name of this files match
	 * the file names given in the command. If string and a file exists (node.js) then that file will be used.
	 * Otherwise it will be considered a url. In later cases, the filename will be the base name of file or url.
	 */
	var inputFiles:Array<MagicaFile>;
  @:optional var debug:Bool;
};

typedef MagicaMainOptions = {
	> MagicaBaseOptions,

	/**
	 * An ImageMagick command, for example: `['convert', 'foo/bar.png', '-scale', '50%', 'out.gif']`
	 */
	var command:Array<String>;
};

typedef MagicaFile = {
	var name:String;
	var content:haxe.io.UInt8Array;
};

typedef MagicaResult = {
	var outputFiles:Array<MagicaFile>;
	var stdout:Array<String>;
	var stderr:Array<String>;
	@:optional var error:Any;
};

/**
 * Represent the result of executing a sequence of commands. In this case outputFiles are the output files of
 * just the last command, while stdout, stderr are the concatenation of all commands output.
 */
typedef MagicaRunResult = {
	> MagicaResult,
	var results:Array<MagicaResult>;
	var commands:Array<Array<String>>;

	/**
	 * Las command output files
	 */
	var outputFiles:Array<MagicaFile>;
};

typedef Magica = {
	/**
	 * Generates a command in the form of `string[][]` that is compatible with {@link call} from given command line string.
	 * This works for strings containing multiple commands in different lines. and also respect `\` character for continue the same
	 * command in a new line. See {@link ExecuteCommand} for more information.
	 */
	function cliToArray(cliCommand:String):Array<Array<String>>;
	function main(o:MagicaMainOptions):Promise<MagicaResult>;
	function run(o:MagicaRunOptions):Promise<MagicaRunResult>;
};
