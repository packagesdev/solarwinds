
#import "RSSSolarWindsConfigurationWindowController.h"

#import "RSSSolarWindsSettings.h"

@interface RSSSolarWindsConfigurationWindowController () <NSCollectionViewDelegate>
{
	IBOutlet NSCollectionView *_settingsCollectionView;
	
	IBOutlet NSPopUpButton * _geometryTypePopupButton;
	
	IBOutlet NSSlider * _numberOfWindsSlider;
	IBOutlet NSTextField * _numberOfWindsLabel;
	IBOutlet NSSlider * _windSpeedSlider;
	IBOutlet NSTextField * _windSpeedLabel;
	
	IBOutlet NSSlider * _numberOfParticlesPerWindSlider;
	IBOutlet NSTextField * _numberOfParticlesPerWindLabel;
	IBOutlet NSSlider * _particleSizeSlider;
	IBOutlet NSTextField * _particleSizeLabel;
	IBOutlet NSSlider * _particleSpeedSlider;
	IBOutlet NSTextField * _particleSpeedLabel;
	
	IBOutlet NSSlider * _numberOfEmittersPerWindSlider;
	IBOutlet NSTextField * _numberOfEmittersPerWindLabel;
	IBOutlet NSSlider * _emitterSpeedSlider;
	IBOutlet NSTextField * _emitterSpeedLabel;

	IBOutlet NSSlider * _motionBlurSlider;
	IBOutlet NSTextField * _motionBlurLabel;
	
	NSNumberFormatter * _numberFormatter;
}

- (IBAction)setGeometryType:(id)sender;

- (IBAction)setNumberOfWinds:(id)sender;
- (IBAction)setWindSpeed:(id)sender;

- (IBAction)setNumberOfParticlesPerWind:(id)sender;
- (IBAction)setParticleSize:(id)sender;
- (IBAction)setParticleSpeed:(id)sender;

- (IBAction)setNumberOfEmittersPerWind:(id)sender;
- (IBAction)setEmitterSpeed:(id)sender;

- (IBAction)setMotionBlur:(id)sender;



- (void)preferredScrollerStyleDidChange:(NSNotification *)inNotification;

@end

@implementation RSSSolarWindsConfigurationWindowController

- (Class)settingsClass
{
	return [RSSSolarWindsSettings class];
}

- (void)windowDidLoad
{
	[super windowDidLoad];
	
	_numberFormatter=[[NSNumberFormatter alloc] init];
	
	if (_numberFormatter!=nil)
	{
		_numberFormatter.hasThousandSeparators=YES;
		_numberFormatter.localizesFormat=YES;
	}
	
	[[NSDistributedNotificationCenter defaultCenter] addObserver:self
														selector:@selector(preferredScrollerStyleDidChange:)
															name:NSPreferredScrollerStyleDidChangeNotification
														  object:nil
											  suspensionBehavior:NSNotificationSuspensionBehaviorDeliverImmediately];
}

- (void)restoreUI
{
	[super restoreUI];
	
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	// A COMPLETER
	
	[_geometryTypePopupButton selectItemWithTag:tSolarWindsSettings.geometryType];
	
	[_numberOfWindsSlider setIntegerValue:tSolarWindsSettings.numberOfWinds];
	[_numberOfWindsLabel setIntegerValue:tSolarWindsSettings.numberOfWinds];
	
	[_windSpeedSlider setIntegerValue:tSolarWindsSettings.windSpeed];
	[_windSpeedLabel setIntegerValue:tSolarWindsSettings.windSpeed];
	
	
	[_numberOfParticlesPerWindSlider setIntegerValue:tSolarWindsSettings.particlesPerWind];
	[_numberOfParticlesPerWindLabel setIntegerValue:tSolarWindsSettings.particlesPerWind];
	
	[_particleSizeSlider setIntegerValue:tSolarWindsSettings.particleSize];
	[_particleSizeLabel setIntegerValue:tSolarWindsSettings.particleSize];
	
	[_particleSpeedSlider setIntegerValue:tSolarWindsSettings.particleSpeed];
	[_particleSpeedLabel setIntegerValue:tSolarWindsSettings.particleSpeed];
	
	
	[_numberOfEmittersPerWindSlider setIntegerValue:tSolarWindsSettings.emittersPerWind];
	[_numberOfEmittersPerWindLabel setIntegerValue:tSolarWindsSettings.emittersPerWind];
	
	[_emitterSpeedSlider setIntegerValue:tSolarWindsSettings.emitterSpeed];
	[_emitterSpeedLabel setIntegerValue:tSolarWindsSettings.emitterSpeed];
	
	
	[_motionBlurSlider setIntegerValue:tSolarWindsSettings.motionBlur];
	[_motionBlurLabel setIntegerValue:tSolarWindsSettings.motionBlur];
	
	/* A COMPLETER */
}

#pragma mark -

- (BOOL)validateMenuItem:(NSMenuItem *)anItem
{
	
	if ([anItem action]==@selector(print:))
	{
		return NO;
	}
	
	return YES;
}

#pragma mark -

- (IBAction)setGeometryType:(id)sender
{
	// A COMPLETER
}

- (IBAction)setNumberOfWinds:(id)sender
{
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	tSolarWindsSettings.numberOfWinds=[sender integerValue];
	
	[_numberOfWindsLabel setIntegerValue:tSolarWindsSettings.numberOfWinds];
	
	// A COMPLETER
}

- (IBAction)setWindSpeed:(id)sender
{
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	tSolarWindsSettings.windSpeed=[sender integerValue];
	
	[_windSpeedLabel setIntegerValue:tSolarWindsSettings.windSpeed];
	
	// A COMPLETER
}


- (IBAction)setNumberOfParticlesPerWind:(id)sender
{
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	tSolarWindsSettings.particlesPerWind=[sender integerValue];
	
	NSString * tFormattedString=[_numberFormatter stringFromNumber:[NSNumber numberWithUnsignedInteger:tSolarWindsSettings.particlesPerWind]];
	
	[_numberOfParticlesPerWindLabel setStringValue:tFormattedString];
	
	// A COMPLETER
}

- (IBAction)setParticleSize:(id)sender
{
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	tSolarWindsSettings.particleSize=[sender integerValue];
	
	[_particleSizeLabel setIntegerValue:tSolarWindsSettings.particleSize];
	
	// A COMPLETER
}

- (IBAction)setParticleSpeed:(id)sender
{
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	tSolarWindsSettings.particleSpeed=[sender integerValue];
	
	[_particleSpeedLabel setIntegerValue:tSolarWindsSettings.particleSpeed];
	
	// A COMPLETER
}


- (IBAction)setNumberOfEmittersPerWind:(id)sender
{
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	tSolarWindsSettings.emittersPerWind=[sender integerValue];
	
	NSString * tFormattedString=[_numberFormatter stringFromNumber:[NSNumber numberWithUnsignedInteger:tSolarWindsSettings.emittersPerWind]];
	
	[_numberOfEmittersPerWindLabel setStringValue:tFormattedString];
	
	
	if (tSolarWindsSettings.geometryType==RSSSolarWindsGeometryTypeLines)
	{
		NSUInteger tMinimumNumberOfParticlesPerWind=tSolarWindsSettings.emittersPerWind*3;
		
		[_numberOfParticlesPerWindSlider setMinValue:tMinimumNumberOfParticlesPerWind];
		
		if ((tSolarWindsSettings.particlesPerWind)<tMinimumNumberOfParticlesPerWind)
		{
			tSolarWindsSettings.particlesPerWind=tMinimumNumberOfParticlesPerWind;
			
			[_numberOfParticlesPerWindSlider setIntegerValue:tMinimumNumberOfParticlesPerWind];
			
			NSString * tFormattedString=[_numberFormatter stringFromNumber:[NSNumber numberWithUnsignedInteger:tMinimumNumberOfParticlesPerWind]];
			
			[_numberOfParticlesPerWindLabel setStringValue:tFormattedString];
		}
	}
	
	// A COMPLETER
}

- (IBAction)setEmitterSpeed:(id)sender
{
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	tSolarWindsSettings.emitterSpeed=[sender integerValue];
	
	[_emitterSpeedLabel setIntegerValue:tSolarWindsSettings.emitterSpeed];
	
	// A COMPLETER
}


- (IBAction)setMotionBlur:(id)sender
{
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	tSolarWindsSettings.motionBlur=[sender integerValue];
	
	[_motionBlurLabel setIntegerValue:tSolarWindsSettings.motionBlur];
	
	// A COMPLETER
}




/*

- (IBAction)selectGeometry:(id)sender
{
	settings_.dGeometry=[[sender selectedItem] tag];
	
	settings_.standardSet=0;
	[IBsettingsPopupButton_ selectItemAtIndex:[IBsettingsPopupButton_ indexOfItemWithTag:settings_.standardSet]];
	
	if (settings_.dGeometry==2)
	{
		[IBparticlesStepper_ setMinValue:settings_.dEmitters*3];
		
		if (settings_.dParticles<settings_.dEmitters*3)
		{
			settings_.dParticles=settings_.dEmitters*3;
			
			[IBparticlesStepper_ setIntValue:settings_.dParticles];
			[IBparticlesTextField_ setIntValue:settings_.dParticles];
		}
	}
	else
	{
		[IBparticlesStepper_ setMinValue:1.0];
	}
}
*/

- (void)preferredScrollerStyleDidChange:(NSNotification *)inNotification
{
	NSLog(@"preferredScrollerStyleDidChange");
}

@end
