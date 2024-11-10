package etcLib;

@:unreflective
@:buildXml('<include name="${haxelib:hxetc2comp}/project/Build.xml" />')
@:native("Etc::Image")
@:include("Etc.h")
@:structAccess
extern class EtcImage 
{
	@:native("Etc::Image")
	public static function Image(pafSourceRGBA:cpp.RawPointer<cpp.Float32>, uiSourceWidth:cpp.UInt32, uiSourceHeight:cpp.UInt32, errorMetric:EtcErrorMetric):EtcImage;

	@:native("~Image")
	public function DisposeImage():Void;

	@:native("Encode")
	public function Encode(a_format:EtcImageFormat, a_errormetric:EtcErrorMetric, a_fEffort:cpp.Float32, a_uiJobs:cpp.UInt32, a_uiMaxJobs:cpp.UInt32):Int;

	@:native("GetEncodingBits")
	public function GetEncodingBits():cpp.Pointer<cpp.UInt8>; // cpp.RawPointer<cpp.UInt8>;//Array<cpp.UInt8>;//cpp.NativeArray;

	@:native("GetEncodingBitsBytes")
	public function GetEncodingBitsBytes():UInt;
}