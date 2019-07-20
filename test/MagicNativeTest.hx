import utest.Async;
import utest.Assert;
import magic.*;

using StringTools;

class MagicNativeTest implements utest.ITest {
	public function new() {}

	function setup() {
		Magic.config.ignoreNativeIM = false;
		IOUtil.execFileSync('rm', ['-rf', 'tmp']);
		IOUtil.execFileSync('mkdir', ['tmp']);
	}

	public function testMagickCallNativeIdentify(async:Async) {
		var c:Magic.MagicCallOptions = {
			command: ['identify', 'rose:'],
			files: []
		}
		Magic.call(c).then(result -> {
			Assert.same(result.code, 0);
			Assert.isTrue(result.stdout.trim().indexOf('rose:=>ROSE PNM 70x46 70x46+0+0 8-bit sRGB 9673B 0.000u')!=-1);
			async.done();
		});
	}

	public function testMagickCallNativeConvertNoInput(async:Async) {
		var c:Magic.MagicCallOptions = {
			command: ['convert','rose:','-scale','50%','-rotate','33','tmp/tmpconvertNoInput.gif'],
			files: []
		};
		Assert.isFalse(IOUtil.fileExists('tmp/tmpconvertNoInput.gif'));
		Magic.call(c).then(result -> {
			Assert.same(result.code, 0);
			Assert.same(result.stdout.trim(), '');
			Assert.isTrue(IOUtil.fileExists('tmp/tmpconvertNoInput.gif'));
      ImageUtil.identical(File.fromFile('tmp/tmpconvertNoInput.gif', true), File.fromFile('test/assets/expects/convertNoInput.gif', true)).then(result->{
		Assert.isTrue(true);

			async.done();
      });
		});
	}
}
