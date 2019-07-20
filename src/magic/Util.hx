package magic;

class Util {
	public static function getFileNameFromUrl(url:String) {
		var hashIndex = url.indexOf('#');
		url = hashIndex != -1 ? url.substring(0, hashIndex) : url;
    var s = url.split('/').pop();
		return (cast(s==null? '':s)).replace(~/[\?].*$/g, '');
	}
}
