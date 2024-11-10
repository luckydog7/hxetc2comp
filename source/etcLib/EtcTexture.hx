package etcLib;

import openfl.display3D.textures.TextureBase;
import openfl.display3D.Context3D;
import openfl.display3D.Context3DTextureFormat;
import openfl.display3D._internal.ATFGPUFormat;
import haxe.io.Bytes;

class EtcTexture extends TextureBase 
{
	@:noCompletion private function new(context:Context3D, width:Int, height:Int, format:Context3DTextureFormat, optimizeForRenderToTexture:Bool,
			streamingLevels:Int, srcData:Array<cpp.UInt8>) {
		super(context);

		__width = width;
		__height = height;
		// __format = format;
		__optimizeForRenderToTexture = optimizeForRenderToTexture;
		__streamingLevels = streamingLevels;

		@:privateAccess
		var gl = __context.gl;

		// FlxG.stage.

		// and why etc2 extension doesnt exist
		// // wtf there is no etc2 in parent class
		// // var etc2AlphaExtension = gl.getExtension("OES_compressed_ETC1_RGB8_texture");
		// #if (js && html5)
		// var etc2Extension = gl.getExtension("WEBGL_compressed_texture_etc");
		// #else
		// var etc2Extension = gl.getExtension("OES_compressed_ETC2_sRGB8_alpha8_texture");
		// #end

		// // if (etc2Extension != null)
		// // {
		TextureBase.__compressedFormatsAlpha[ATFGPUFormat.ETC2] = 0x9278; // etc2Extension.COMPRESSED_SRGB8_ALPHA8_ETC2_EAC;
		// 	// trace(etc2Extension.COMPRESSED_SRGB8_ALPHA8_ETC2_EAC);
		// // }
		// // Clipboard.generalClipboard.setData(TEXT_FORMAT, gl.getParameter(0x1F02));

		// @:privateAccess
		// lime._internal.backend.native.NativeOpenGLRenderContext.__supportedExtensions = null;
		// trace(gl.getSupportedExtensions());

		// @:privateAccess
		// {
		// 	gl.getIntegerv();
		// }

		// Clipboard.generalClipboard.setData(TEXT_FORMAT, gl.getSupportedExtensions());

		__textureTarget = gl.TEXTURE_2D;

		@:privateAccess
		__context.__bindGLTexture2D(__textureID);

		// gl.texImage2D(__textureTarget, 0, __internalFormat, __width, __height, 0, __format, gl.UNSIGNED_BYTE, null);
		var context = __context;
		@:privateAccess
		var gl = context.gl;
		var level = 0;
		var alpha = true;

		@:privateAccess
		__context.__bindGLTexture2D(__textureID);

		var gpuFormat:ATFGPUFormat = ATFGPUFormat.ETC2;

		var format = alpha ? TextureBase.__compressedFormatsAlpha[gpuFormat] : TextureBase.__compressedFormats[gpuFormat];
		if (format == 0) {
			trace("ETC2 is not supported on this device");
			return;
		}

		__format = format;
		__internalFormat = format;

		// @:privateAccess
		// var inData = new ArrayBufferView(cast srcData, 4);
		// trace(__internalFormat);
		@:privateAccess
		gl.compressedTexImage2D(__textureTarget, level, __internalFormat, width, height, 0,
			lime.utils.UInt8Array.fromBytes(new Bytes(srcData.length, srcData)));

		// UInt8Array.fromBytes(new Bytes(srcData.length, srcData)
		var error = 'GL Error: ${gl.getError()}';

		trace(error);
		// Clipboard.generalClipboard.setData(TEXT_FORMAT, error);

		@:privateAccess
		__context.__bindGLTexture2D(null);

		if (optimizeForRenderToTexture)
			__getGLFramebuffer(true, 0, 0);
	}
	// public function uploadCompressedTextureFromRawBytes(arr:Array<UInt>)
	// {
	// var context = __context;
	// var gl = context.gl;
	// __context.__bindGLTexture2D(__textureID);
	// var gpuFormat:ATFGPUFormat = ATFGPUFormat.ETC2;
	// var format = alpha ? TextureBase.__compressedFormatsAlpha[gpuFormat] : TextureBase.__compressedFormats[gpuFormat];
	// if (format == 0) return;
	// }
}