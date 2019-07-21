package magic;

class Promise<T> {
	private var resolvedWith:T;
	private var resolveListeners:Array<(t:T) -> Void>;

	public function new(fn:(resolve:(t:T) -> Void) -> Void) {
		resolveListeners = [];
		fn(t -> {
			resolvedWith = t;
			for (l in resolveListeners)
				l(t);
		});
	}

	public function then(l:(t:T) -> Void) {
		resolveListeners.push(l);
		if (resolvedWith != null) {
			l(resolvedWith);
		}
	}

	public static function all<T>(a:Array<Promise<T>>):Promise<Array<T>> {
    if(a.length==0){
      return Promise.resolve([]);
    }
		return new Promise(resolve -> {
			var resolved:Array<T> = [];
			function f(t:T) {
        trace(t, 'jksdkjdskjdsjkds');
				resolved.push(t);
				if (resolved.length == a.length) {
					resolve(resolved);
				}
			}
			for (p in a) {
				p.then(f);
			}
		});
	}

	public static function resolve<T>(t:T) {
		return new Promise<T>(resolve -> resolve(t));
	}
}
