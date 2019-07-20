import utest.Assert;
import magic.Promise;

class PromiseTest implements utest.ITest {
	public function new() {}

	@:timeout(500)
	public function testResolve(async:utest.Async) {
		inline function f() {
			return new Promise<String>(resolve -> {
				resolve('hello');
			});
		}

		f().then(s -> {
			Assert.same(s, 'hello');
			async.done();
		});
	}
}
