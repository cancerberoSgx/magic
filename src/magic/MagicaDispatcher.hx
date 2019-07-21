package magic;

import magic.*;
import magic.Magic.MagicCallOptions;
import magic.Magic.MagicResults;

class MagicaDispatcher implements Dispatcher {
	public function new() {}

	public static function getMagicaEntryPoint():Promise<Magica> {
		untyped if (typeof(window) != 'undefined'
			&& typeof(window.Magica) != 'undefined'
			&& typeof(window.Magica.main) == 'function') {
			untyped return Promise.resolve(window.Magica);
		} else if (typeof(window) == 'undefined' && typeof(process) != 'undefined') {
			// TODO: platform paths: do we really need to support backslashes for windows?
			return Promise.resolve(untyped require(magicaFolder() + '/node_modules/magica'));
		} else {
			throw "Library magica is not available";
		}
	}

	public function call(o:MagicCallOptions):Promise<MagicResults> {
		return new Promise(resolve -> {
			getMagicaEntryPoint().then(magica -> {
				magica.main({
					command: o.command,
					inputFiles: o.files.map(f -> f.toMagicaFile())
				}).then(magicaResults -> {
					var r:MagicResults = {
						files: magicaResults.outputFiles.map(File.fromMagicaFile),
						stdout: magicaResults.stdout.join('\n'),
						stderr: magicaResults.stderr.join('\n'),
						error: magicaResults.error,
						code: magicaResults.error == null ? 0 : 1
					};
					resolve(r);
				});
			}); // TODO: catch
		});
	}

	private static var _isMagicaApiAvailable:Null<Bool>;

	public static function isMagicaApiAvailable():Promise<Bool> {
		#if js
		return new Promise(resolve -> {
			untyped if ((typeof(window) == 'undefined' || typeof(window.fetch) == 'undefined') && typeof(process) != 'undefined') {
				// node.js
				if (_isMagicaApiAvailable != null) {
					resolve(_isMagicaApiAvailable);
					return;
				}
				if (ensureMagicaInstall()) {
					if (checkMagicaInstall()) {
						_isMagicaApiAvailable = true;
						resolve(true);
					} else {
						trace('There where problems installing npm package magica. 22222');
						resolve(false);
					}
				} else {
					trace('There where problems installing npm package magica.');
					resolve(false);
				}
			} else {
				// The browser
				untyped if (typeof(window) != 'undefined'
					&& typeof(window.Magica) != 'undefined'
					&& typeof(window.Magica.main) == 'function') {
					_isMagicaApiAvailable = true;
					resolve(true);
				} else {
					resolve(false);
				}
			}
		});
		#else
		return Promise.resolve(false);
		#end
	}

	static function checkMagicaInstall() {
		// TODO: platform paths: do we really need to support backslashes for windows?
		if (!IOUtil.fileExists(magicaFolder()) || !IOUtil.fileExists(magicaFolder() + '/node_modules/magica')) {
			return false;
		}
		try {
			// TODO: platform paths: do we really need to support backslashes for windows?
			return untyped typeof(require(magicaFolder() + '/node_modules/magica')) != 'undefined' && typeof(require(magicaFolder() + '/node_modules/magica')
				.main) == 'function';
		} catch (ex:Any) {
			trace('error while requiring magica: ', ex);
			return false;
		}
	}

	static function magicaFolder():String {
		untyped var ss:String = process.env.HOME + '';
		ss = ~/\\/g.replace(ss, '/');
		return ss + '/.magic/magic-npm-project';
	}

	static function ensureMagicaInstall() {
		if (!checkMagicaInstall()) {
			// TODO: platform paths: do we really need to support backslashes for windows?
			if (!IOUtil.fileExists(magicaFolder())) {
				untyped require('fs').mkdirSync(magicaFolder(), {recursive: true});
			}
			// TODO: platform paths: do we really need to support backslashes for windows?
			if (!IOUtil.fileExists(magicaFolder() + '/package.json')) {
				var r = IOUtil.execFileSync('npm', ['init', '-y'], magicaFolder());
				if (r.code != 0) {
					// trace('There where problems installing npm package magica. - when executing npm init -y ', ['init', '-y'], magicaFolder());
					throw 'There where problems installing npm package magica. - when executing npm init -y ' + ['init', '-y', magicaFolder()].join(' ');
				}
			}
			var r = IOUtil.execFileSync('npm', ['install', '--save', 'magica'], magicaFolder());
			//  npm install --prefix /my/project/root
			if (r.code != 0) {
				trace('There where problems installing npm package magica. - when executing npm install ' + ['install', '--save', 'magica', magicaFolder()]
					.join(' '),
					r);
				throw 'There where problems installing npm package magica. - when executing npm install ' + ['install', '--save', 'magica', magicaFolder()]
					.join(' ');
			}
			return checkMagicaInstall();
		}
		return true;
	}
}
