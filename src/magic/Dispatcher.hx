package magic;

import magic.*;
import magic.Magic.MagicCallOptions;
import magic.Magic.MagicResults;

interface Dispatcher {
	public function call(o:MagicCallOptions):Promise<MagicResults>;
}

class Dispatch {
	public static function get():Promise<Dispatcher> {
		return new Promise<Dispatcher>(resolve -> {
			if (!Magic.config.ignoreNativeIM && Exec.hasNativeIM()) {
				resolve(nativeIMDispatcher());
			} else if(!Magic.config.ignoreMagica) {
				MagicaDispatcher.isMagicaApiAvailable().then(magicaApiAvailable -> {
					if (magicaApiAvailable) {
						resolve(magicaDispatcher());
					} else {
						throw "Magica API not available and not dispatcher found for this scenario;";
					}
				});
			}else {
        throw "not implemented dispatch for this situation";
      }
		});
	}

private static var _nativeIMDispatcher:Dispatcher;

private static function nativeIMDispatcher():Dispatcher {
	if (_nativeIMDispatcher == null) {
		_nativeIMDispatcher = new NativeIMDispatcher();
	}
	return cast(_nativeIMDispatcher, Dispatcher);
}

private static var _magicaDispatcher:Dispatcher;

private static function magicaDispatcher():Dispatcher {
	if (_magicaDispatcher == null) {
		_magicaDispatcher = new MagicaDispatcher();
	}
	return cast(_magicaDispatcher, Dispatcher);
}
}
