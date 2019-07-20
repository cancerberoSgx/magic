package magic;

import magic.*;
import magic.Magic.MagicCallOptions;
import magic.Magic.MagicResults;

class MagicaDispatcher implements Dispatcher {
	public function new() {}

	public function call(o:MagicCallOptions):Promise<MagicResults> {
		return new Promise(resolve -> {
			// TODO: platform paths: do we really need to support backslashes for windows?
			untyped require(magicaFolder() + '/node_modules/magica').main({
				command: o.command,
				inputFiles: o.files
			}).then(magicaResults -> {
				var r:MagicResults = {
					files: magicaResults.outputFiles,
					stdout: magicaResults.stdout.join('\n'),
					stderr: magicaResults.stderr.join('\n'),
					error: magicaResults.error,
          code: magicaResults.error==null?0:1
				};
				resolve(r);
			});
			// TODO: catch
		});
	}

	private static var _isMagicaApiAvailable:Null<Bool>;

	public static function isMagicaApiAvailable():Promise<Bool> {
		#if js
		return new Promise(resolve -> {
			if (_isMagicaApiAvailable != null) {
				resolve(_isMagicaApiAvailable);
				return;
			}
			// ensureMagicaInstall().then(installed->{
			if (ensureMagicaInstall()) {
				if (checkMagicaInstall()) {
					_isMagicaApiAvailable = true;
					resolve(true);
				} else {
					trace('There where problems installing npm package magica. 22222');
					resolve(false);
				}
				// checkMagicaInstall().then(magicaApiAvailable->{
				//   _isMagicaApiAvailable=magicaApiAvailable;
				//   resolve(magicaApiAvailable);
				// });
			} else {
				trace('There where problems installing npm package magica.');
				resolve(false);
			}
			// });
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
			return
				untyped typeof(require(magicaFolder() + '/node_modules/magica')) != 'undefined' && typeof(require(magicaFolder() + '/node_modules/magica').main) == 'function';
		} catch (ex:Any) {
      trace('error while requiring magica: ', ex);
			return false;
		}
		// TODO: try{return typeof require('magica').main!=null}catch(e){return false}
		// return Promise.resolve(true);
	}

	// require('/Users/sebastiangurin/git/geometrizejs/geometrizejs-extra/node_modules/mujer')
	static function magicaFolder():String {
 untyped    var ss:String = process.env.HOME + '';
    ss= ~/\\/g.replace(ss, '/');
		return  ss + '/.magic/magic-npm-project';

		// return untyped .replace(/\\/g, '/')
	}

	//  = '';//$HOME/.magic/node-modules/
	static function ensureMagicaInstall() {
		// checkMagicaInstall().then(installed->{
		if (!checkMagicaInstall()) {
			// TODO: platform paths: do we really need to support backslashes for windows?
			if (!IOUtil.fileExists(magicaFolder()) ) {
				untyped require('fs').mkdirSync(magicaFolder(), {recursive: true});
			}
			// TODO: platform paths: do we really need to support backslashes for windows?
			if (!IOUtil.fileExists(magicaFolder() + '/package.json')) {
				// trace('npm', ['init', '-y'], magicaFolder());
				var r = IOUtil.execFileSync('npm', ['init', '-y'], magicaFolder());
				//  npm install --prefix /my/project/root
				if (r.code != 0) {
					// trace('There where problems installing npm package magica. - when executing npm init -y ', ['init', '-y'], magicaFolder());
					throw 'There where problems installing npm package magica. - when executing npm init -y ' + ['init', '-y', magicaFolder()].join(' ');
					// return false;
				}
			}
			//  }
			// trace('npm', ['install', '--save', 'magica'], magicaFolder());
			var r = IOUtil.execFileSync('npm', ['install', '--save', 'magica'], magicaFolder());
			//  npm install --prefix /my/project/root
			if (r.code != 0) {
        	trace('There where problems installing npm package magica. - when executing npm install ' + ['install', '--save', 'magica', magicaFolder()]
					.join(' '), r);
				throw 'There where problems installing npm package magica. - when executing npm install ' + ['install', '--save', 'magica', magicaFolder()]
					.join(' ');

				// return false;
			}
			return checkMagicaInstall();
			//  if $HOME/.magic/node-modules/magica doesnt exists: {
			// TODO: mkdir -p $HOME/.magic/          //TODO: cd  $HOME/.magic/          //TODO: npm inin -y
			// TODO: npm i magica
			// magicaNodeModules = $HOME/.magic/node-modules/

			// }
			// else { if it exists but it it didn't work
		}
		return true;
		// }
		// })
		// TODO: try{return typeof require('magica').main!=null}catch(e){return false}
		// return Promise.resolve(true);
	}
}
