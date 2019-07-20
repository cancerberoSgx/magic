package;

import utest.Runner;
import utest.ui.Report;

class TestMain {
	static function main() {
  	var runner = new Runner();
		runner.addCase(new PromiseTest());
    runner.addCase(new ExecTest());
    runner.addCase(new MagicTest());
    runner.addCase(new FileTest());
		Report.create(runner);
		runner.run();
	}
}
