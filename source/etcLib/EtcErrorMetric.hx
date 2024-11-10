package etcLib;

extern enum abstract EtcErrorMetric(EtcErrorMetric_Impl) 
{
	@:native("Etc::ErrorMetric::RGBA")
	var RGBA;
	@:native("Etc::ErrorMetric::RGBX")
	var RGBX;
	@:native("Etc::ErrorMetric::REC709")
	var REC709;
	@:native("Etc::ErrorMetric::NUMERIC")
	var NUMERIC;
	@:native("Etc::ErrorMetric::NORMALXYZ")
	var NORMALXYZ;
	//
	@:native("Etc::ErrorMetric::ERROR_METRICS")
	var ERROR_METRICS;
	//
	@:native("Etc::ErrorMetric::BT709")
	var BT709;
}

@:unreflective
@:native("Etc::ErrorMetric")
@:include("Etc.h")
extern class EtcErrorMetric_Impl {}