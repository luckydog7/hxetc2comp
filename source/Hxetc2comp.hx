package;

import cpp.NativeArray;
import cpp.RawPointer;
import cpp.UInt32;
import cpp.UInt8;
import etcLib.EtcErrorMetric;
import etcLib.EtcImage;
import etcLib.EtcImageFormat;
import etcLib.EtcTexture;
import flixel.FlxG;
import haxe.ds.Vector;
import haxe.io.Bytes;
import haxe.io.UInt8Array;
import lime.graphics.Image;
import lime.system.CFFI;
import lime.system.JNI;
import lime.system.System;
import lime.utils.ArrayBufferView;
import openfl.desktop.Clipboard;
import openfl.display.BitmapData;
import openfl.display3D.Context3D;
import openfl.display3D.Context3DTextureFormat;
import openfl.display3D._internal.ATFGPUFormat;
import openfl.display3D.textures.Texture;
import openfl.display3D.textures.TextureBase;
import sys.io.File;
import sys.thread.Thread;

// TODO: Need to reorganize and rewrite that shi
// @:buildXml('<include name="${haxelib:hxetc2comp}/project/Build.xml" />')
// @:unreflective
class Hxetc2comp {
	// inline public static var ETCCOMP_MIN_EFFORT_LEVEL:Float = 0.0;
	// inline public static var ETCCOMP_DEFAULT_EFFORT_LEVEL:Float = 40.0;
	// inline public static var ETCCOMP_MAX_EFFORT_LEVEL:Float = 100.0;
	// untested
	public static function nativeArrayToHaxe(ptr:cpp.Star<cpp.UInt8>, size:UInt):Array<UInt8> {
		// NativeArray.setUnmanagedData();
		return untyped __cpp__("::Array_obj<unsigned char>::fromData({0}, {1})", ptr, size);
	}

	inline public static function freeArray(arr:cpp.Pointer<cpp.UInt8>) {
		untyped __cpp__("delete[] {0}", arr);
	}

	public static function toCompressed(image:Image, filename:String = ""):BitmapData {
		trace("starting compression: " + filename);
		// image.buffer.data.buffer.getData()
		// EtcImage.name();
		// untyped __cpp__("Etc::Image(3,nullptr,128,128,nullptr);");
		// trace(image.format);
		// var floatRgb:Array<cpp.Float32> = [];

		// for (val in image.buffer.data)
		// {
		// 	floatRgb.push(val / 255);
		// }

		// skipping small images
		if (Math.max(image.width, image.height) <= 2047) {
			var b = BitmapData.fromImage(image);
			b.disposeImage(); // hehe
			return b;
		}

		// var floatRgb:Array<cpp.Float32> = new Array<cpp.Float32>(image.buffer.data.length);
		var floatRgb:Array<cpp.Float32> = NativeArray.create(image.buffer.data.length);

		// var dd = new Vector<cpp.Float32>(5);

		for (i in 0...image.buffer.data.length) {
			floatRgb[i] = image.buffer.data[i] / 255;
		}

		// cpp.Pointer.arrayElem(image.buffer.data, image.buffer.data.length);
		var im = EtcImage.Image(cast cpp.Pointer.arrayElem(floatRgb, 0).raw, image.width, image.height, EtcErrorMetric.RGBA);
		// trace(RawPointer.addressOf(im));

		// return;
		// trace(im.GetEncodingBitsBytes());
		im.Encode(EtcImageFormat.RGBA8, EtcErrorMetric.RGBA, 0, 10, 1024);

		floatRgb = null;
		cpp.vm.Gc.run(true);

		var natarr = im.GetEncodingBits();
		// natarr.ptr
		// var arrin = cpp.NativeArray.setSize(natarr, im.GetEncodingBitsBytes());

		var arr = nativeArrayToHaxe(natarr.ptr, im.GetEncodingBitsBytes());

		freeArray(natarr);

		trace("hello");
		trace('arr: ${arr.length}');

		im.DisposeImage();

		@:privateAccess
		var tex = new EtcTexture(FlxG.stage.context3D, image.width, image.height, Context3DTextureFormat.COMPRESSED_ALPHA, true, 0, cast arr);
		// untyped __cpp__("::Array<unsigned char> ar = ::Array_obj<unsigned char>::fromData(natarr.ptr, im.GetEncodingBitsBytes())");

		cpp.vm.Gc.run(true);

		return BitmapData.fromTexture(tex);
		// for (el in arr)
		// {
		// 	trace(el);
		// }
		// for (i in 0...im.GetEncodingBitsBytes())
		// {
		// 	var val = natarr[i];
		// 	if (val < 0)
		// 	{
		// 		trace("sadas" + i);
		// 		break;
		// 	}
		// }
	}
}
