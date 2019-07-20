import utest.Assert;
import magic.*;

using StringTools;

class MagicTest implements utest.ITest {
	public function new() {}

	@:timeout(1500)
	public function testMagickCallNative(async:utest.Async) {
		var c:Magic.CallOptions = {
			command: ['identify', 'rose:'],
			files: []
		}
		Magic.call(c).then(result -> {
			Assert.same(result.code, 0);
			Assert.same(result.stdout.trim(), 'rose:=>ROSE PNM 70x46 70x46+0+0 8-bit sRGB 9673B 0.000u 0:00.000');
			async.done();
		});
	}
}