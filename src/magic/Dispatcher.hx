package magic;

import magic.*;
import magic.Magic.CallOptions;
import magic.Magic.CallResult;

interface Dispatcher {
	public function call(o:CallOptions):Promise<CallResult>;
}

class Dispatch {
	public static function get():Promise<Dispatcher> {
		if (Exec.hasNativeIM()) {
			return Promise.resolve(nativeIMDispatcher());
		} else {
			throw "dispatcher not supported yet";
		}
	}

	private static var _nativeIMDispatcher:Dispatcher;

	private static function nativeIMDispatcher() {
		if (_nativeIMDispatcher == null) {
			_nativeIMDispatcher = new NativeIMDispatcher();
		}
		return cast(_nativeIMDispatcher, Dispatcher);
	}
}
