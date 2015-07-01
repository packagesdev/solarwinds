
#import "RSSSolarWindsConfigurationWindowController.h"

#import "RSSSolarWindsSettings.h"

#import "RSSCollectionView.h"

@interface RSSSolarWindsConfigurationWindowController () <NSCollectionViewDelegate>
{
	IBOutlet RSSCollectionView *_settingsCollectionView;
	
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

- (void)updateMinValueOfParticlesPerWindSlider;

- (void)setAsCustomSet;

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
	
	[self updateMinValueOfParticlesPerWindSlider];
	
	/* A COMPLETER */
}

#pragma mark -

- (BOOL)validateMenuItem:(NSMenuItem *)anItem
{
	if ([anItem action]==@selector(print:))
		return NO;
	
	return YES;
}

#pragma mark -

- (void)updateMinValueOfParticlesPerWindSlider
{
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
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
	else
	{
		[_numberOfParticlesPerWindSlider setMinValue:1];
	}
}

- (void)setAsCustomSet
{
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	tSolarWindsSettings.standardSet=RSSSolarWindsSetCustom;
}

- (IBAction)setGeometryType:(id)sender
{
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	tSolarWindsSettings.geometryType=[sender selectedTag];
	
	[self updateMinValueOfParticlesPerWindSlider];
	
	[self setAsCustomSet];
}

- (IBAction)setNumberOfWinds:(id)sender
{
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	tSolarWindsSettings.numberOfWinds=[sender integerValue];
	
	[_numberOfWindsLabel setIntegerValue:tSolarWindsSettings.numberOfWinds];
	
	[self setAsCustomSet];
}

- (IBAction)setWindSpeed:(id)sender
{
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	tSolarWindsSettings.windSpeed=[sender integerValue];
	
	[_windSpeedLabel setIntegerValue:tSolarWindsSettings.windSpeed];
	
	[self setAsCustomSet];
}


- (IBAction)setNumberOfParticlesPerWind:(id)sender
{
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	tSolarWindsSettings.particlesPerWind=[sender integerValue];
	
	NSString * tFormattedString=[_numberFormatter stringFromNumber:[NSNumber numberWithUnsignedInteger:tSolarWindsSettings.particlesPerWind]];
	
	[_numberOfParticlesPerWindLabel setStringValue:tFormattedString];
	
	[self setAsCustomSet];
}

- (IBAction)setParticleSize:(id)sender
{
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	tSolarWindsSettings.particleSize=[sender integerValue];
	
	[_particleSizeLabel setIntegerValue:tSolarWindsSettings.particleSize];
	
	[self setAsCustomSet];
}

- (IBAction)setParticleSpeed:(id)sender
{
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	tSolarWindsSettings.particleSpeed=[sender integerValue];
	
	[_particleSpeedLabel setIntegerValue:tSolarWindsSettings.particleSpeed];
	
	[self setAsCustomSet];
}


- (IBAction)setNumberOfEmittersPerWind:(id)sender
{
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	tSolarWindsSettings.emittersPerWind=[sender integerValue];
	
	NSString * tFormattedString=[_numberFormatter stringFromNumber:[NSNumber numberWithUnsignedInteger:tSolarWindsSettings.emittersPerWind]];
	
	[_numberOfEmittersPerWindLabel setStringValue:tFormattedString];
	
	
	[self updateMinValueOfParticlesPerWindSlider];
	
	[self setAsCustomSet];
}

- (IBAction)setEmitterSpeed:(id)sender
{
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	tSolarWindsSettings.emitterSpeed=[sender integerValue];
	
	[_emitterSpeedLabel setIntegerValue:tSolarWindsSettings.emitterSpeed];
	
	[self setAsCustomSet];
}


- (IBAction)setMotionBlur:(id)sender
{
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	tSolarWindsSettings.motionBlur=[sender integerValue];
	
	[_motionBlurLabel setIntegerValue:tSolarWindsSettings.motionBlur];
	
	[self setAsCustomSet];
}

- (void)preferredScrollerStyleDidChange:(NSNotification *)inNotification
{
	NSLog(@"preferredScrollerStyleDidChange");
}

@end
