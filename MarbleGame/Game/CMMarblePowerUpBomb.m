//
//  CMMarblePowerUpBomb.m
//  MarbleGame
//
//  Created by Carsten Müller on 9/25/13.
//  Copyright (c) 2013 Carsten Müller. All rights reserved.
//

#import "CMMarblePowerUpBomb.h"
#import "CMParticleSystemQuad.h"
#import "CocosDenshion.h"
#import "SimpleAudioEngine.h"
#import "CMSimpleGradient.h"

@interface CMMarblePowerUpBase ()
@property (nonatomic,retain) CMParticleSystemQuad* particles;
@property (nonatomic,retain) CMSimpleGradient *startColorGradient;
@property (nonatomic,retain) CMSimpleGradient *endColorGradient;
@end

@implementation CMMarblePowerUpBomb
@synthesize startColorGradient = startColorGradient_, endColorGradient=endColorGradient_ ;

- (id) init
{
	self = [super init];
	if (self) {
		self.particles = [CMParticleSystemQuad particleWithFile:MARBLE_POWERUP_EXPLODE];
    self.startColorGradient = [[[CMSimpleGradient alloc]initWithStartColor:self.particles.startColor
                                                                  endColor:ccc4f(1.0, 0.0, 0.0, 1.0)]autorelease];

    self.endColorGradient = [[[CMSimpleGradient alloc]initWithStartColor:self.particles.endColor
                                                                endColor:ccc4f(0.0, 0.0, 0.0, 1.0)]autorelease];
	}
	return self;
}

- (void) dealloc
{
  self.startColorGradient = nil;
  self.endColorGradient = nil;
  [super dealloc];
}

- (CGFloat)scoreValue
{
  CGFloat value = 10;
  if (self.activeTime>0.0) {
    value= ((10 - 2) * (1-[self percentTime]))+2;
  }
  return value;
}

- (void) performActionFor:(CMMarbleSprite *)marble
{
  [super performActionFor:marble];
//	NSLog(@"A C T I O N");
	ChipmunkSpace *currentSpace = marble.chipmunkBody.space;
	ChipmunkBody* currentBody = marble.chipmunkBody;
	
	CGPoint pos = marble.position;
	
	NSArray *results = [currentSpace nearestPointQueryAll:pos maxDistance:100 layers:CP_ALL_LAYERS group:CP_NO_GROUP];
	for (ChipmunkNearestPointQueryInfo* info in results) {
    ChipmunkBody *body = info.shape.body;
		if (!body.isStatic) {
			CGPoint direction = cpvnormalize( cpvsub(info.point, pos));
      CGFloat maxPulse = 20000.0 * (1-[self percentTime]);
			CGPoint impulse = cpvmult(direction, maxPulse);
			[body applyImpulse:impulse offset:CGPointMake(0, 0)];
		}
	}
  CGFloat gain = 1.0-[self percentTime];
  if (gain >1.0) {
    gain = 1.0f;
  }
  if (gain < 0.0) {
    gain = 0.0;
  }
	[[SimpleAudioEngine sharedEngine] playEffect:DEFAULT_MARBLE_BOOM];
  [[SimpleAudioEngine sharedEngine] playEffect:DEFAULT_MARBLE_BOOM pitch:1.0 pan:0.0 gain:gain];
}

- (CGFloat) percentTime
{
  CGFloat value = 1.0;
  if (self.activeTime>0.0) {
    value = 1-(self.remainingTime / self.activeTime);
  }
  return value;
}

- (void) update
{
  if ( (self.activeTime >0.0)){
  CGFloat percentTime = [self percentTime];

  self.particles.startColor = [self.startColorGradient colorForNormalizedPosition:percentTime];
  self.particles.endColor = [self.endColorGradient colorForNormalizedPosition:percentTime];

  }
  [super update];
}
@end
