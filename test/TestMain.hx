package;

import utest.Runner;
import utest.ui.Report;

class TestMain {
	static function main() {
  	var runner = new Runner();
		runner.addCase(new PromiseTest());
    runner.addCase(new ExecTest());
    runner.addCase(new MagicNativeTest());
    runner.addCase(new FileTest());
    #if js
    runner.addCase(new MagicaNodeTest());
    runner.addCase(new MagicRunTest());
    #end
		Report.create(runner);
		runner.run();
	}
}
