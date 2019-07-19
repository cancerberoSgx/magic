package magic;

typedef CallOptions = {
	var command:Array<String>;
	var files:Array<File>;
};

typedef CallResult = {
  var files:Array<File>;
  var stdout:Array<String>;
  var stderr:Array<String>;
  var error:Any;
};

class Magic {
	public static function call(o:CallOptions):Promise<CallResult> {
    throw "not impl";
  }
}
