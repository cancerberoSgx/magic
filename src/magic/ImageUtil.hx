package magic;
using StringTools;

class ImageUtil {
	public static function identical(i1:File, i2:File):Promise<Bool> {
		return new Promise(resolve -> {
			var c:Magic.CallOptions = {
				command: ['compare', '-metric', 'MAE', i1.name, i2.name, 'null:'],
				files: [i1, i2]
			};
			Magic.call(c).then(result -> {
				resolve(result.code == 0 && result.stdout.trim() == '0 (0)');
			});
		});
	}
}
