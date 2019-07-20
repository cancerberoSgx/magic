import utest.*;
import magic.Dispatcher.Dispatch;
import magic.*;

using StringTools;

class MagicaNodeTest implements utest.ITest {
	public function new() {}

	function teardown(async:Async):Void {
		Magic.config.ignoreNativeIM = false;
    async.done();
	}

	public function testDifferentDispatcher(async:Async) {
		var d1 = Dispatch.get();
		Magic.config.ignoreNativeIM = true;
		var d2 = Dispatch.get();
		Assert.isFalse(d1 == d2);
		async.done();
	}

	@:timeout(5500)
	public function testDifferentIMVersions(async:Async) {
		Magic.config.ignoreNativeIM = false;
		Magic.call({
			command: ['convert', '--version'],
			files: []
		}).then(r1 -> {
			Magic.config.ignoreNativeIM = true;
			Magic.call({
				command: ['convert', '--version'],
				files: []
			}).then(r2 -> {
				// trace(r1.stdout, r2.stdout);
				Assert.isFalse(r1.stdout.trim() == r2.stdout.trim());
				async.done();
			});
		});
	}

	@:timeout(9500)
	public function testMagicaIdentify(async:Async) {
		Magic.config.ignoreNativeIM = true;
		Magic.call({
			command: ['identify', 'rose:'],
			files: []
		}).then(result -> {
			// trace(result);
			Assert.same(result.code, 0);
			Assert.same(result.stdout.trim(), 'rose:=>ROSE PNM 70x46 70x46+0+0 8-bit sRGB 9673B 0.000u 0:00.000');
			async.done();
		});
	}
}
