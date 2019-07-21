import haxe.io.BytesInput;
import haxe.io.Input;
import utest.*;
import magic.Dispatcher.Dispatch;
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
		Magic.run( cast {
       debug:true,
			command: '
convert rose: -scale 44% out1.png
convert out1.png -rotate 44 out2.gif
      '.trim(),
			files: []
		}).then(result -> {
			// trace(result);
      // trace('0seba');
			// Assert.same(result.code, 0);
			// Assert.same(result.files.length, 2);
      IOUtil.writeFile('tmp2.gif', new BytesInput(result.files[1].content));
      ImageUtil.identical(result.files[1], File.fromFile('test/assets/expects/convertNoInput.gif')).then(r->{
        Assert.isTrue( r);
        	async.done();
      });
      // ;
      // IOUtil.writeFile('tmp1.png', new BytesInput(result.files[0].content));
		
		});
	}
}
