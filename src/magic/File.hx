package magic;
import magic.*;
import haxe.io.*;

class File{
  public function new(_name:String,_content:Bytes) {
    name=_name;
    content=_content;
  }
  public var name:String;
  public var content:Bytes;
  public static function fromFile(path:String, ?preserveDir:Bool):File {
    var name = preserveDir==null ? Path.withoutDirectory(path): path;
    var content = IOUtil.readFile(path).readAll();
    return new File(name, content);
  }
}