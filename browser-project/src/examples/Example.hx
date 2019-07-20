
package examples;
import magic.*;

typedef Example = {
  // public function run(options:ExampleOptions):Promise<>;
  // public function getSource():String;
//  public function getName():String;
public var name:String;
public var command:Array<String>;
}

// typedef ExampleOptions = {
//   var files : File;
// };

// typedef ExampleResult = {
//   var output: Array<Bitmap>;
// };


class Examples {
  public static var list: Array<Example> = [
    {
      name: 'identify',
      command: ['identify', 'rose:']
    }
  ];
}