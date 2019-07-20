package magic;

import magic.*;
import magic.Dispatcher.Dispatch;

typedef CallOptions = {
	var command:Array<String>;
	var files:Array<File>;
};

typedef CallResult = {
	var files:Array<File>;
	var stdout:String;
	var stderr:String;
	var error:Any;
	var code:Int;
};

class Magic {
	public static function call(o:CallOptions):Promise<CallResult> {
		return new Promise<CallResult>(resolve -> Dispatch.get().then(dispatcher -> dispatcher.call(o).then(resolve)));
		// throw "not impl";
	}
}
