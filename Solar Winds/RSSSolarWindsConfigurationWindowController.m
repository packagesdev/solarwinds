
#import "RSSSolarWindsConfigurationWindowController.h"

#import "RSSSolarWindsSettings.h"

#import "RSSCollectionView.h"

#import "RSSCollectionViewItem.h"

@interface RSSSolarWindsConfigurationWindowController () <RSSCollectionViewDelegate>
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

- (void)_updateMinValueOfParticlesPerWindSlider;

- (void)_selectCollectionViewItemWithTag:(NSInteger)inTag;

- (void)_setAsCustomSet;

- (IBAction)setGeometryType:(id)sender;

- (IBAction)setNumberOfWinds:(id)sender;
- (IBAction)setWindSpeed:(id)sender;

- (IBAction)setNumberOfParticlesPerWind:(id)sender;
- (IBAction)setParticleSize:(id)sender;
- (IBAction)setParticleSpeed:(id)sender;

- (IBAction)setNumberOfEmittersPerWind:(id)sender;
- (IBAction)setEmitterSpeed:(id)sender;

- (IBAction)setMotionBlur:(id)sender;



/*- (void)preferredScrollerStyleDidChange:(NSNotification *)inNotification;*/

@end

@implementation RSSSolarWindsConfigurationWindowController

- (void)dealloc
{
	[[NSDistributedNotificationCenter defaultCenter] removeObserver:self];
}

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
	
	NSBundle * tBundle=[NSBundle bundleForClass:[self class]];
	
	NSArray * tStandardSettingsArray=@[@{
										   RSSCollectionViewRepresentedObjectThumbnail : @"regular_thumbnail",
										   RSSCollectionViewRepresentedObjectTag : @(RSSSolarWindsSetRegular),
										   RSSCollectionViewRepresentedObjectName : NSLocalizedStringFromTableInBundle(@"Regular",@"Localized",tBundle,@"")
										 },
									   @{
										   RSSCollectionViewRepresentedObjectThumbnail : @"cosmic_strings_thumbnail",
										   RSSCollectionViewRepresentedObjectTag : @(RSSSolarWindsSetCosmicStrings),
										   RSSCollectionViewRepresentedObjectName : NSLocalizedStringFromTableInBundle(@"Cosmic Strings",@"Localized",tBundle,@"")
										 },
									   @{
										   RSSCollectionViewRepresentedObjectThumbnail : @"cold_pricklies_thumbnail",
										   RSSCollectionViewRepresentedObjectTag : @(RSSSolarWindsSetColdPricklies),
										   RSSCollectionViewRepresentedObjectName : NSLocalizedStringFromTableInBundle(@"Cold Pricklies",@"Localized",tBundle,@"")
										 },
									   @{
										   RSSCollectionViewRepresentedObjectThumbnail : @"space_fur_thumbnail",
										   RSSCollectionViewRepresentedObjectTag : @(RSSSolarWindsSetSpaceFur),
										   RSSCollectionViewRepresentedObjectName : NSLocalizedStringFromTableInBundle(@"Space Fur",@"Localized",tBundle,@"")
										 },
									   @{
										   RSSCollectionViewRepresentedObjectThumbnail : @"jiggy_thumbnail",
										   RSSCollectionViewRepresentedObjectTag : @(RSSSolarWindsSetJiggly),
										   RSSCollectionViewRepresentedObjectName : NSLocalizedStringFromTableInBundle(@"Jiggly",@"Localized",tBundle,@"")
										 },
									   @{
										   RSSCollectionViewRepresentedObjectThumbnail : @"undertow_thumbnail",
										   RSSCollectionViewRepresentedObjectTag : @(RSSSolarWindsSetUndertow),
										   RSSCollectionViewRepresentedObjectName : NSLocalizedStringFromTableInBundle(@"Undertow",@"Localized",tBundle,@"")
										 },
									   @{
										   RSSCollectionViewRepresentedObjectThumbnail : @"random_thumbnail",
										   RSSCollectionViewRepresentedObjectTag : @(RSSSolarWindsSetRandom),
										   RSSCollectionViewRepresentedObjectName : NSLocalizedStringFromTableInBundle(@"Random",@"Localized",tBundle,@"")
										 },
									   @{
										   RSSCollectionViewRepresentedObjectThumbnail : @"custom_thumbnail",
										   RSSCollectionViewRepresentedObjectTag : @(RSSSolarWindsSetCustom),
										   RSSCollectionViewRepresentedObjectName : NSLocalizedStringFromTableInBundle(@"Custom",@"Localized",tBundle,@"")
										 }];
	
	[_settingsCollectionView setContent:tStandardSettingsArray];
	
	/*[[NSDistributedNotificationCenter defaultCenter] addObserver:self
														selector:@selector(preferredScrollerStyleDidChange:)
															name:NSPreferredScrollerStyleDidChangeNotification
														  object:nil
											  suspensionBehavior:NSNotificationSuspensionBehaviorDeliverImmediately];*/
}

- (void)restoreUI
{
	[super restoreUI];
	
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	[self _selectCollectionViewItemWithTag:tSolarWindsSettings.standardSet];
	
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
	
	[self _updateMinValueOfParticlesPerWindSlider];
}

#pragma mark -

- (void)_updateMinValueOfParticlesPerWindSlider
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

- (void)_selectCollectionViewItemWithTag:(NSInteger)inTag
{
	[_settingsCollectionView.content enumerateObjectsUsingBlock:^(NSDictionary * bDictionary,NSUInteger bIndex,BOOL * bOutStop){
		NSNumber * tNumber=bDictionary[RSSCollectionViewRepresentedObjectTag];
		
		if (tNumber!=nil)
		{
			if (inTag==[tNumber integerValue])
			{
				[_settingsCollectionView RSS_selectItemAtIndex:bIndex];
				
				*bOutStop=YES;
			}
		}
	}];
}

- (void)_setAsCustomSet
{
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	if (tSolarWindsSettings.standardSet!=RSSSolarWindsSetCustom)
	{
		tSolarWindsSettings.standardSet=RSSSolarWindsSetCustom;
	
		[self _selectCollectionViewItemWithTag:tSolarWindsSettings.standardSet];
	}
}

- (IBAction)setGeometryType:(id)sender
{
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	if (tSolarWindsSettings.geometryType!=[sender selectedTag])
	{
		tSolarWindsSettings.geometryType=[sender selectedTag];
		
		[self _updateMinValueOfParticlesPerWindSlider];
		
		[self _setAsCustomSet];
	}
}

- (IBAction)setNumberOfWinds:(id)sender
{
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	if (tSolarWindsSettings.numberOfWinds!=[sender integerValue])
	{
		tSolarWindsSettings.numberOfWinds=[sender integerValue];
	
		[_numberOfWindsLabel setIntegerValue:tSolarWindsSettings.numberOfWinds];
	
		[self _setAsCustomSet];
	}
}

- (IBAction)setWindSpeed:(id)sender
{
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	if (tSolarWindsSettings.windSpeed!=[sender integerValue])
	{
		tSolarWindsSettings.windSpeed=[sender integerValue];
	
		[_windSpeedLabel setIntegerValue:tSolarWindsSettings.windSpeed];
	
		[self _setAsCustomSet];
	}
}


- (IBAction)setNumberOfParticlesPerWind:(id)sender
{
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	if (tSolarWindsSettings.particlesPerWind!=[sender integerValue])
	{
		tSolarWindsSettings.particlesPerWind=[sender integerValue];
		
		NSString * tFormattedString=[_numberFormatter stringFromNumber:[NSNumber numberWithUnsignedInteger:tSolarWindsSettings.particlesPerWind]];
	
		[_numberOfParticlesPerWindLabel setStringValue:tFormattedString];
	
		[self _setAsCustomSet];
	}
}

- (IBAction)setParticleSize:(id)sender
{
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	if (tSolarWindsSettings.particleSize!=[sender integerValue])
	{
		tSolarWindsSettings.particleSize=[sender integerValue];
	
		[_particleSizeLabel setIntegerValue:tSolarWindsSettings.particleSize];
	
		[self _setAsCustomSet];
	}
}

- (IBAction)setParticleSpeed:(id)sender
{
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	if (tSolarWindsSettings.particleSpeed!=[sender integerValue])
	{
		tSolarWindsSettings.particleSpeed=[sender integerValue];
	
		[_particleSpeedLabel setIntegerValue:tSolarWindsSettings.particleSpeed];
	
		[self _setAsCustomSet];
	}
}


- (IBAction)setNumberOfEmittersPerWind:(id)sender
{
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	if (tSolarWindsSettings.emittersPerWind!=[sender integerValue])
	{
		tSolarWindsSettings.emittersPerWind=[sender integerValue];
	
		NSString * tFormattedString=[_numberFormatter stringFromNumber:[NSNumber numberWithUnsignedInteger:tSolarWindsSettings.emittersPerWind]];
	
		[_numberOfEmittersPerWindLabel setStringValue:tFormattedString];
	
		[self _updateMinValueOfParticlesPerWindSlider];
	
		[self _setAsCustomSet];
	}
}

- (IBAction)setEmitterSpeed:(id)sender
{
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	if (tSolarWindsSettings.emitterSpeed!=[sender integerValue])
	{
		tSolarWindsSettings.emitterSpeed=[sender integerValue];
	
		[_emitterSpeedLabel setIntegerValue:tSolarWindsSettings.emitterSpeed];
	
		[self _setAsCustomSet];
	}
}

- (IBAction)setMotionBlur:(id)sender
{
	RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
	
	if (tSolarWindsSettings.motionBlur!=[sender integerValue])
	{
		tSolarWindsSettings.motionBlur=[sender integerValue];
	
		[_motionBlurLabel setIntegerValue:tSolarWindsSettings.motionBlur];
	
		[self _setAsCustomSet];
	}
}

#pragma mark -

- (BOOL)RSS_collectionView:(NSCollectionView *)inCollectionView shouldSelectItemAtIndex:(NSInteger)inIndex
{
	RSSCollectionViewItem * tCollectionViewItem=(RSSCollectionViewItem *)[_settingsCollectionView itemAtIndex:inIndex];
	
	if (tCollectionViewItem!=nil)
	{
		NSInteger tTag=tCollectionViewItem.tag;
		
		if (tTag==RSSSolarWindsSetCustom)
			return NO;
	}
	
	return YES;
}

- (void)RSS_collectionViewSelectionDidChange:(NSNotification *)inNotification
{
	if (inNotification.object==_settingsCollectionView)
	{
		NSIndexSet * tIndexSet=[_settingsCollectionView selectionIndexes];
		NSUInteger tIndex=[tIndexSet firstIndex];
		
		RSSCollectionViewItem * tCollectionViewItem=(RSSCollectionViewItem *)[_settingsCollectionView itemAtIndex:tIndex];
		
		if (tCollectionViewItem!=nil)
		{
			NSInteger tTag=tCollectionViewItem.tag;
			RSSSolarWindsSettings * tSolarWindsSettings=(RSSSolarWindsSettings *) sceneSettings;
			
			if (tSolarWindsSettings.standardSet!=tTag)
			{
				tSolarWindsSettings.standardSet=tTag;
				
				if (tTag!=RSSSolarWindsSetRandom)
				{
					[tSolarWindsSettings resetSettingsToStandardSet:tTag];
					
					[self restoreUI];
				}
			}
		}
	}
}

/*- (void)preferredScrollerStyleDidChange:(NSNotification *)inNotification
{
	NSLog(@"preferredScrollerStyleDidChange");
}*/

@end
