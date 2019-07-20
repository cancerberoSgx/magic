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
			Assert.isTrue(true);
			async.done();
		});
	}
}
