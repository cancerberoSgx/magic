package magic;

class Promise<T> {
	private var resolvedWith:T;
	private var rejectedWith:Any;
	private var resolveListeners:Array<(t:T) -> Void>;
	private var rejectListeners:Array<(t:Any) -> Void>;

	public function new(fn:(resolve:(t:T) -> Void) -> Void, ?rfn:(reject:(t:Any) -> Void) -> Void) {
		resolveListeners = [];
		rejectListeners = [];
		fn(t -> {
			resolvedWith = t;
			for (l in resolveListeners)
				l(t);
		});
		if (rfn != null) {
			rfn(t -> {
				rejectedWith = t;
				for (l in rejectListeners)
					l(t);
			});
		}
	}

	public function then(l:(t:T) -> Void) {
		resolveListeners.push(l);
		if (resolvedWith != null) {
			l(resolvedWith);
		}
	}

	public function fail(l:(t:Any) -> Void) {
		rejectListeners.push(l);
		if (rejectedWith != null) {
			l(rejectedWith);
		}
	}

	public static function resolve<T>(t:T) {
		return new Promise<T>(resolve -> resolve(t));
	}
}
