package magic;
using StringTools;

class Util {
	public static function getFileNameFromUrl(url:String) {
		var hashIndex = url.indexOf('#');
		url = hashIndex != -1 ? url.substring(0, hashIndex) : url;
    var s = url.split('/').pop();
    s = s==null? '':s;
    s = ~/[\?].*$/g.replace(s, '');
    return s;
		// return (s+'').replace(, '');
	}
}
