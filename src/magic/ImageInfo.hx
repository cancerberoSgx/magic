package magic;


typedef ImageInfo = {
  var image:ImageInfoImage;
  @:optional var error:Dynamic;
};

typedef ImageInfoGeometry = {
  var width:Int;
  var height:Int;
  var x:Int;
  var y:Int;
};

typedef ImageInfoResolution = {
  var x:Int;
  var y:Int;
};

typedef ImageInfoPrintSize = {
  @:optional var x:Int;
  @:optional var y:Int;
};

typedef ImageInfoChannelDepth = {
  @:optional var alpha:Int;
  @:optional var red:Int;
  @:optional var green:Int;
  @:optional var blue:Int;
};

typedef ImageInfoOverall = {
  @:optional var min:Int;
  @:optional var max:Int;
  @:optional var mean:Int;
  @:optional var standardDeviation:Int;
  @:optional var kurtosis:Int;
  @:optional var skewness:Int;
  @:optional var entropy:Int;
};

typedef ImageInfoImageStatistics = {
  @:optional var Overall:ImageInfoOverall;
};

typedef ImageInfoAlpha = {
  @:optional var min:Int;
  @:optional var max:Int;
  @:optional var mean:Int;
  @:optional var standardDeviation:Int;
  @:optional var kurtosis:Int;
  @:optional var skewness:Int;
  @:optional var entropy:Int;
};

typedef ImageInfoRed = {
  @:optional var min:Int;
  @:optional var max:Int;
  @:optional var mean:Int;
  @:optional var standardDeviation:Int;
  @:optional var kurtosis:Int;
  @:optional var skewness:Int;
  @:optional var entropy:Int;
};

typedef ImageInfoGreen = {
  @:optional var min:Int;
  @:optional var max:Int;
  @:optional var mean:Int;
  @:optional var standardDeviation:Int;
  @:optional var kurtosis:Int;
  @:optional var skewness:Int;
  @:optional var entropy:Int;
};

typedef ImageInfoBlue = {
  @:optional var min:Int;
  @:optional var max:Int;
  @:optional var mean:Int;
  @:optional var standardDeviation:Int;
  @:optional var kurtosis:Int;
  @:optional var skewness:Int;
  @:optional var entropy:Int;
};

typedef ImageInfoChannelStatistics = {
  @:optional var Alpha:ImageInfoAlpha;
  @:optional var Red:ImageInfoRed;
  @:optional var Green:ImageInfoGreen;
  @:optional var Blue:ImageInfoBlue;
};

typedef ImageInfoRedPrimary = {
  @:optional var x:Int;
  @:optional var y:Int;
};

typedef ImageInfoGreenPrimary = {
  @:optional var x:Int;
  @:optional var y:Int;
};

typedef ImageInfoBluePrimary = {
  @:optional var x:Int;
  @:optional var y:Int;
};

typedef ImageInfoWhitePrimary = {
  @:optional var x:Int;
  @:optional var y:Int;
};

typedef ImageInfoChromaticity = {
  @:optional var redPrimary:ImageInfoRedPrimary;
  @:optional var greenPrimary:ImageInfoGreenPrimary;
  @:optional var bluePrimary:ImageInfoBluePrimary;
  @:optional var whitePrimary:ImageInfoWhitePrimary;
};

typedef ImageInfoPageGeometry = {
  @:optional var width:Int;
  @:optional var height:Int;
  @:optional var x:Int;
  @:optional var y:Int;
};

// typedef ImageInfoProperties = {
//   @:optional var 'date:create':String;
//   @:optional var 'date:modify':String;
//   @:optional var signature:String;
// };

// @:optional var // typedef ImageInfo8bim2 {length:Int= ;
// };

// @:optional var // typedef ImageInfoProfiles {'8bim':ImageInfo8bim2= ;
// };
// type ImageInfoProfiles = any
typedef ImageInfoImage = {
  @:optional var name:String;
  @:optional var baseName:String;
  @:optional var format:String;
  @:optional var formatDescription:String;
  @:optional var mimeType:String;
  // @:optional var class:String;
  @:optional var geometry:ImageInfoGeometry;
  @:optional var resolution:ImageInfoResolution;
  @:optional var printSize:ImageInfoPrintSize;
  @:optional var units:String;
  @:optional var type:String;
  @:optional var baseType:String;
  @:optional var endianess:String;
  @:optional var colorspace:String;
  @:optional var depth:Int;
  @:optional var baseDepth:Int;
  @:optional var channelDepth:ImageInfoChannelDepth;
  @:optional var pixels:Int;
  @:optional var imageStatistics:ImageInfoImageStatistics;
  @:optional var channelStatistics:ImageInfoChannelStatistics;
  @:optional var alpha:String;
  @:optional var renderingIntent:String;
  @:optional var gamma:Int;
  @:optional var chromaticity:ImageInfoChromaticity;
  @:optional var matteColor:String;
  @:optional var backgroundColor:String;
  @:optional var borderColor:String;
  @:optional var transparentColor:String;
  @:optional var interlace:String;
  @:optional var intensity:String;
  @:optional var compose:String;
  @:optional var pageGeometry:ImageInfoPageGeometry;
  @:optional var dispose:String;
  @:optional var iterations:Int;
  @:optional var compression:String;
  @:optional var orientation:String;
  @:optional var properties:Dynamic;
  // @:optional var profiles:ImageInfoProfiles;
  @:optional var tainted:Bool;
  @:optional var filesize:String;
  @:optional var numberPixels:String;
  @:optional var pixelsPerSecond:String;
  @:optional var userTime:String;
  @:optional var elapsedTime:String;
  @:optional var version:String;
};
