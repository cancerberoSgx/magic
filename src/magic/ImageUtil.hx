package magic;

import haxe.Json;
import haxe.io.Bytes;
import magic.*;
import magic.ImageInfo.ImageInfo;

using StringTools;

class ImageUtil {
	public static function identical(i1:File, i2:File):Promise<Bool> {
		return new Promise(resolve -> {
			var c:Magic.MagicCallOptions = {
        debug: Magic.config.debug,
				command: [
					'compare', '-metric', 'MAE', i1.name, i2.name, '-metric', 'RMSE', '-format', '%[distortion]', 'info:'
				],
				files: [i1, i2]
			};
      // trace(c);
			Magic.call(c).then(result -> {
				// trace(result.code, result.stdout.trim(), result.stderr, '*');
				resolve(result.code == 0);// && (result.stdout.trim() == '0' || result.stdout.trim() == '00'));
			});
		});
	}

	/**
	 * Execute `convert $IMG info.json` to extract image metadata. Returns the parsed info.json file contents
	 * @param img could be a string in case you want to extract information of built in images like `rose:`
	 */
	public static function imageInfo(img:File):Promise<Null<ImageInfo>> {
		return new Promise(resolve -> {
			Magic.call({
				files: [img],
				command: ['convert', img.name, 'imgInfo.json']
			}).then(r -> {
				if (r.files.length == 1) {
					var info:ImageInfo = cast Json.parse(r.files[0].content.toString());
					resolve(info);
				} else {
					resolve(null);
				}
			});
		});
	}
}
