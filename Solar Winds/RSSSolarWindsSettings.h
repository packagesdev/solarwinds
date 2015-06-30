
#import "RSSSettings.h"

typedef NS_ENUM(NSUInteger, RSSSolarWindsSet)
{
	RSSSolarWindsSetCustom=0,
	RSSSolarWindsSetRandom=1,
	RSSSolarWindsSetRegular=1027,
	RSSSolarWindsSetCosmicStrings=1028,
	RSSSolarWindsSetColdPricklies=1029,
	RSSSolarWindsSetSpaceFur=1030,
	RSSSolarWindsSetJiggly=1031,
	RSSSolarWindsSetUndertow=1032
};

typedef NS_ENUM(NSUInteger, RSSSolarWindsGeometryType)
{
	RSSSolarWindsGeometryTypeLights=0,
	RSSSolarWindsGeometryTypePoints=1,
	RSSSolarWindsGeometryTypeLines=2
};

@interface RSSSolarWindsSettings : RSSSettings

@property RSSSolarWindsSet standardSet;

@property RSSSolarWindsGeometryType geometryType;

@property NSUInteger numberOfWinds;
@property NSUInteger windSpeed;

@property NSUInteger particlesPerWind;
@property NSUInteger particleSize;
@property NSUInteger particleSpeed;

@property NSUInteger emittersPerWind;
@property NSUInteger emitterSpeed;

@property NSUInteger motionBlur;

- (void)resetSettingsToStandardSet:(RSSSolarWindsSet)inSet;

@end
