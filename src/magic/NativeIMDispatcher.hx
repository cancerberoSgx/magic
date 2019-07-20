package magic;

import magic.*;
import magic.Magic.MagicCallOptions;
import magic.Magic.MagicResults;

class NativeIMDispatcher implements Dispatcher {
	public function new() {}

	public function call(o:MagicCallOptions):Promise<MagicResults> {
		var p = IOUtil.execFileSync(o.command[0], [for (i in 1...o.command.length) o.command[i]]);
		return Promise.resolve({
			code: p.code,
			stdout: p.stdout,
			stderr: p.stderr,
			files: [],
			error: null
		});
	}
}
