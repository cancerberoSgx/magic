package magic;

class Util {
	public static function getFileNameFromUrl(url:String) {
		var hashIndex = url.indexOf('#');
		url = hashIndex != -1 ? url.substring(0, hashIndex) : url;
		var s = url.split('/').pop();
		s = s == null ? '' : s;
		return ~/[\?].*$/g.replace(s, '');
	}

	public inline static function urlToBase64(s:String) {
		return s.substring(s.indexOf(';base64,') + ';base64,'.length);
	}
}
