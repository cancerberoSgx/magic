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

	public function	fail (l:(t:Any) -> Void) {
			rejectListeners.push(l);
			if (rejectedWith != null) {
				l(rejectedWith);
			}
	}
	// this.resolve = resolve;
	// this.resolve.onResolve = t -> {
	// 	resolvedWith = t;
	// 	for (l in resolveListeners)
	// 		l(t);
	// private var resolve(default, null):Resolve<T>;
	// public static function Resolve<T>(fn: (resolve: (t:T) -> Void)->Void){
	//   return new Resolve<T>(fn);
	// }
} // {resolve:(t:T)->Void, ?reject:(t:Any)->Void}
// class Resolve<T> {
// 	public function new(fn: (resolve: (t:T) -> Void)->Void) {
// 		resolveFn = fn;
//     resolveFn();
// 	}
// 	private var resolveFn:(resolve: (t:T) -> Void)->Void;
// 	public var onResolve:(t : T)->Void;
// 	@:final function resolve(t:T):Void {
// 		// resolveFn(t);
// 		onResolve(t);
// 	}
// }
// typedef CatchListener = (t:Any) -> Void;
