import utest.*;
import magic.*;

using StringTools;

class MagicRunTest implements utest.ITest {
	public function new() {}

	function teardown(async:Async):Void {
		Magic.config.ignoreNativeIM = false;
		async.done();
	}

	@:timeout(9500)
	public function testMagicRun1(async:Async) {
		Magic.config.ignoreNativeIM = true;
		Magic.run(cast {
			command: '
convert rose: -scale 50% out1.gif
convert out1.gif -rotate 33 out2.gif
      '.trim(),
			files: []
		}).then(result -> {
			Assert.same(0, result.code);
			Assert.same(['out2.gif'], result.files.map(f -> f.name));
			Assert.same(2, result.results.length);
			ImageUtil
				.identical(result.files[0], File.fromFile('test/assets/expects/run1.gif')) // ImageUtil.identical(result.files[0], File.fromFile('test/assets/expects/run1.gif', true))// TODO: this fails
				.then(result -> {
					Assert.isTrue(result);
					async.done();
				});
		});
	}
}
