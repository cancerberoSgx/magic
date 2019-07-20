package magic;

import magic.*;
import magic.Dispatcher.Dispatch;

typedef MagicCallOptions = {
	var command:Array<String>;
	var files:Array<File>;
};

typedef MagicExecOptions = {
	var command:String;
	@:optional var files:Array<File>;
	@:optional var paths:Array<String>;
};

typedef MagicResults = {
	var files:Array<File>;
	var stdout:String;
	var stderr:String;
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
	public static function exec(o:MagicExecOptions):Promise<MagicResults> {
		return new Promise<MagicResults>(resolve -> {
			execToCallOptions(o).then(callOptions -> {
				return new Promise<MagicResults>(resolve -> Dispatch.get().then(dispatcher -> dispatcher.call(callOptions).then(resolve)));
			});
		});
	}

  private static function execToCallOptions(o:MagicExecOptions):Promise<MagicCallOptions>{
    throw "not Implemented";
  }


  // static var config:Map<String,String> = new Map();
  // TODO: haxe issue I needed to declarea function if not in js i get Error: Cannot read property 'ignoreNativeIM' of undefined
// public static var config:Config = defaultConfig;
public static var config = {
    ignoreNativeIM: false,
    magicaOnlyBrowser:false,
    ignoreMagica:false
  };
  // static var defaultConfig = {
  //   ignoreNativeIM: false,
  //   magicaOnlyBrowser:false,
  //   ignoreMagica:false
  // };
  // public static function setConfig(name:String,value:Any){
  //   this.config[name] = value;
  // } 
  // public static function getConfig(name:String):Any{
  //   return this.config[name];
  // }
}
typedef Config = {
   var ignoreNativeIM: Bool;
   var magicaOnlyBrowser:Bool;
   var ignoreMagica:Bool;
}