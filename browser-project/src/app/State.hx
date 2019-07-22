package app;

import magic.*;
import examples.*;

typedef  State= {
	public var example:Example;
  public var inputFiles:Array<File>;
  public var script: String;
  public var outputFiles:Array<File>;
  public var stdout:String;
  public var stderr:String;
};

