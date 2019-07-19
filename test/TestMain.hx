package;

import utest.Runner;
import utest.ui.Report;
import PromiseTest;

class TestMain {
	static function main() {
  	var runner = new Runner();
		runner.addCase(new PromiseTest());
    runner.addCase(new ExecTest());
		Report.create(runner);
		runner.run();
	}
}
