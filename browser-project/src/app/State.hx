package app;

import magic.Magic.MagicResults;
import magic.*;
import examples.*;

typedef  State= {
	public var example:Example;
  public var inputFiles:Array<File>;
  // public var result: MagicResults
  public var outputFiles:Array<File>;
  // public var examples:Array<Example>;
  public var stdout:String;
  public var stderr:String;

};

