
import utest.Assert;
import magic.*;

class ExecTest implements utest.ITest {
	public function new() {}
  
  public function testcommandThrows( ) {
    Assert.isTrue(Exec.commandThrows('ls', ['lkajslkdajsldkajsldk']));
    Assert.isFalse(Exec.commandThrows('haxe', ['--help'], 'Haxe Compiler'));
    Assert.isTrue(Exec.commandThrows('haxe', ['--version'], 'Haxe Compiler'));
	}

	public function testhasNativeIM( ) {
    Assert.isTrue(Exec.hasNativeIM());
	}
}
