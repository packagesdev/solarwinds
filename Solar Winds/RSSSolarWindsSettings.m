
#import "RSSSolarWindsSettings.h"

NSString * const RSSSolarWinds_Settings_StandardSetKey=@"Standard set";

NSString * const RSSSolarWinds_Settings_WindsCount=@"Winds count";
NSString * const RSSSolarWinds_Settings_ParticlesCountKey=@"Particles count";
NSString * const RSSSolarWinds_Settings_EmittersCountKey=@"Emiiters count";	// Keep the typo for backward compatibility
NSString * const RSSSolarWinds_Settings_GeometryTypeKey=@"Geometry";
NSString * const RSSSolarWinds_Settings_ParticleSizeKey=@"Particle Size";
NSString * const RSSSolarWinds_Settings_EmitterSpeedKey=@"Emitter Speed";
NSString * const RSSSolarWinds_Settings_ParticleSpeedKey=@"Particle Speed";
NSString * const RSSSolarWinds_Settings_WindSpeedKey=@"Wind Speed";
NSString * const RSSSolarWinds_Settings_MotionBlurKey=@"Blur";

@implementation RSSSolarWindsSettings

- (id)initWithDictionaryRepresentation:(NSDictionary *)inDictionary
{
	self=[super init];
	
	if (self!=nil)
	{
		NSNumber * tNumber=inDictionary[RSSSolarWinds_Settings_StandardSetKey];
		
		if (tNumber==nil)
			_standardSet=RSSSolarWindsSetRegular;
		else
			_standardSet=[tNumber unsignedIntegerValue];
		
		if (_standardSet==RSSSolarWindsSetCustom)
		{
			_numberOfWinds=[inDictionary[RSSSolarWinds_Settings_WindsCount] unsignedIntegerValue];
			_particlesPerWind=[inDictionary[RSSSolarWinds_Settings_ParticlesCountKey] unsignedIntegerValue];
			_emittersPerWind=[inDictionary[RSSSolarWinds_Settings_EmittersCountKey] unsignedIntegerValue];
			_geometryType=[inDictionary[RSSSolarWinds_Settings_GeometryTypeKey] unsignedIntegerValue];
			_particleSize=[inDictionary[RSSSolarWinds_Settings_ParticleSizeKey] unsignedIntegerValue];
			_emitterSpeed=[inDictionary[RSSSolarWinds_Settings_EmitterSpeedKey] unsignedIntegerValue];
			_particleSpeed=[inDictionary[RSSSolarWinds_Settings_ParticleSpeedKey] unsignedIntegerValue];
			_windSpeed=[inDictionary[RSSSolarWinds_Settings_WindSpeedKey] unsignedIntegerValue];
			_motionBlur=[inDictionary[RSSSolarWinds_Settings_MotionBlurKey] unsignedIntegerValue];
		}
		else if (_standardSet!=RSSSolarWindsSetRandom)
		{
			[self resetSettingsToStandardSet:_standardSet];
		}
	}
	
	return self;
}

- (NSDictionary *)dictionaryRepresentation
{
	NSMutableDictionary * tMutableDictionary=[NSMutableDictionary dictionary];
	
	if (tMutableDictionary!=nil)
	{
		tMutableDictionary[RSSSolarWinds_Settings_StandardSetKey]=@(_standardSet);
		
		tMutableDictionary[RSSSolarWinds_Settings_WindsCount]=@(_numberOfWinds);
		tMutableDictionary[RSSSolarWinds_Settings_ParticlesCountKey]=@(_particlesPerWind);
		tMutableDictionary[RSSSolarWinds_Settings_EmittersCountKey]=@(_emittersPerWind);
		tMutableDictionary[RSSSolarWinds_Settings_GeometryTypeKey]=@(_geometryType);
		tMutableDictionary[RSSSolarWinds_Settings_ParticleSizeKey]=@(_particleSize);
		tMutableDictionary[RSSSolarWinds_Settings_EmitterSpeedKey]=@(_emitterSpeed);
		tMutableDictionary[RSSSolarWinds_Settings_ParticleSpeedKey]=@(_particleSpeed);
		tMutableDictionary[RSSSolarWinds_Settings_WindSpeedKey]=@(_windSpeed);
		tMutableDictionary[RSSSolarWinds_Settings_MotionBlurKey]=@(_motionBlur);
	}
	
	return [tMutableDictionary copy];
}

#pragma mark -

- (void)resetSettings
{
	_standardSet=RSSSolarWindsSetRegular;
	
	[self resetSettingsToStandardSet:_standardSet];
}

- (void)resetSettingsToStandardSet:(RSSSolarWindsSet)inSet;
{
	switch(inSet)
	{
		case RSSSolarWindsSetRegular:
			
			_numberOfWinds=1;
			_emittersPerWind = 30;
			_particlesPerWind = 2000;
			_geometryType = RSSSolarWindsGeometryTypeLights;
			_particleSize = 50;
			_windSpeed = 20;
			_emitterSpeed = 15;
			_particleSpeed = 10;
			_motionBlur = 40;
			
			break;
			
		case RSSSolarWindsSetCosmicStrings:
			
			_numberOfWinds = 1;
			_emittersPerWind = 50;
			_particlesPerWind = 3000;
			_geometryType = RSSSolarWindsGeometryTypeLines;
			_particleSize = 20;
			_windSpeed = 10;
			_emitterSpeed = 10;
			_particleSpeed = 10;
			_motionBlur = 10;
			
			break;
			
		case RSSSolarWindsSetColdPricklies:
			
			_numberOfWinds = 1;
			_emittersPerWind = 300;
			_particlesPerWind = 3000;
			_geometryType = RSSSolarWindsGeometryTypeLines;
			_particleSize = 5;
			_windSpeed = 20;
			_emitterSpeed = 100;
			_particleSpeed = 15;
			_motionBlur = 70;
			
			break;
			
		case RSSSolarWindsSetSpaceFur:
			
			_numberOfWinds = 2;
			_emittersPerWind = 400;
			_particlesPerWind = 1600;
			_geometryType = RSSSolarWindsGeometryTypeLines;
			_particleSize = 15;
			_windSpeed = 20;
			_emitterSpeed = 15;
			_particleSpeed = 10;
			_motionBlur = 0;
			
			break;
			
		case RSSSolarWindsSetJiggly:
			
			_numberOfWinds = 1;
			_emittersPerWind = 40;
			_particlesPerWind = 1200;
			_geometryType = RSSSolarWindsGeometryTypePoints;
			_particleSize = 20;
			_windSpeed = 100;
			_emitterSpeed = 20;
			_particleSpeed = 4;
			_motionBlur = 50;
			
			break;
			
		case RSSSolarWindsSetUndertow:
			
			_numberOfWinds = 1;
			_emittersPerWind = 400;
			_particlesPerWind = 1200;
			_geometryType = RSSSolarWindsGeometryTypeLights;
			_particleSize = 40;
			_windSpeed = 20;
			_emitterSpeed = 1;
			_particleSpeed = 100;
			_motionBlur = 50;
			
			break;
			
		default:
			
			NSLog(@"This should not be invoked for set: %u",(unsigned int)inSet);
			
			break;
	}
}

@end