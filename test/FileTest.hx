import utest.Async;
import utest.Assert;
import magic.*;

class FileTest implements utest.ITest {
	public function new() {}

	public function testFileTestFromFile() {
		var f = File.fromFile('test/assets/expects/convertNoInput.gif');
		Assert.same('convertNoInput.gif', f.name);
	}

	public function testFileExists() {
		Assert.isTrue(IOUtil.fileExists('test/assets/expects/convertNoInput.gif'));
		Assert.isFalse(IOUtil.fileExists('test/assets/expects/convertNoIsasdasdasdasdnput.gif'));
	}

	public function testImageUtilidentical(async:Async) {
		ImageUtil.identical(File.fromFile('test/assets/bluebells.png', true), File.fromFile('test/assets/expects/convertNoInput.gif', true)).then(result -> {
			Assert.isFalse(result);
			async.done();
		});
	}

	// @:timeout(5500)
	public function testImageUtilidentical3(async:Async) {
		ImageUtil.identical(File.fromFile('test/assets/expects/convertNoInput.gif', true), File.fromFile('test/assets/expects/convertNoInput.gif', true))
			.then(result -> {
			Assert.isTrue(result);
			async.done();
		});
	}

	@:timeout(5500)
	public function testFileFromUrl(async:Async) {
		var url = 'https://cancerberosgx.github.io/demos/magica/images/parrots_orig.png';
		File.fromUrl(url).then(file -> {
      // trace(file);
			Assert.same(file.name, 'parrots_orig.png');
			async.done();
		});
	}
}
