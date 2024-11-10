package etcLib;

extern enum abstract EtcImageFormat(EtcImageFormat_Impl) 
{
	@:native("Etc::Image::Format::UNKNOWN")
	var UNKNOWN;

	@:native("Etc::Image::Format::ETC1")
	var ETC1;

	@:native("Etc::Image::Format::RGB8")
	var RGB8;
	@:native("Etc::Image::Format::SRGB8")
	var SRGB8;
	@:native("Etc::Image::Format::RGBA8")
	var RGBA8;
	@:native("Etc::Image::Format::SRGBA8")
	var SRGBA8;
	@:native("Etc::Image::Format::R11")
	var R11;
	@:native("Etc::Image::Format::SIGNED_R11")
	var SIGNED_R11;
	@:native("Etc::Image::Format::RG11")
	var RG11;
	@:native("Etc::Image::Format::SIGNED_RG11")
	var SIGNED_RG11;
	@:native("Etc::Image::Format::RGB8A1")
	var RGB8A1;
	@:native("Etc::Image::Format::SRGB8A1")
	var SRGB8A1;

	@:native("Etc::Image::Format::FORMATS")
	var FORMATS;

	@:native("Etc::Image::Format::DEFAULT")
	var DEFAULT;
}

@:unreflective
@:native("Etc::Image::Format")
@:include("Etc.h")
private extern class EtcImageFormat_Impl {}