package magic;

class ArrayExtensions {
	public static function find<T>(a:Array<T>, predicate:(t:T, i:Int, a:Array<T>) -> Bool):Null<T> {
		for (i in 0...a.length) {
			if (predicate(a[i], i, a)) {
				return a[i];
			}
		}
		return null;
	}

	public static function filter2<T>(a:Array<T>, predicate:(t:T, i:Int, a:Array<T>) -> Bool):Array<T> {
		var r:Array<T> = [];
		for (i in 0...a.length) {
			if (predicate(a[i], i, a)) {
				r.push(a[i]);
			}
		}
		return r;
	}

	public static function findIndexOf<T>(a:Array<T>, predicate:(t:T, i:Int, a:Array<T>) -> Bool, from = 0):Int {
		for (i in from...a.length) {
			if (predicate(a[i], i, a)) {
				return i;
			}
		}
		return -1;
	}
}
