//
//  CMMarbleSimulationLayer.h
//  MarbleGame
//
//  Created by Carsten Müller on 6/28/13.
//  Copyright Carsten Müller 2013. All rights reserved.
//

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"



// Importing Chipmunk headers
#import "ObjectiveChipmunk.h"
#import "CMMarbleGameDelegate.h"


#define USE_NEW_COLLISION_DETECTOR 1
@class  CMMarbleCollisionCollector, CMMarbleLevel;
@interface CMMarbleSimulationLayer : CCLayerColor

@property (nonatomic, assign) id<CMMarbleGameDelegate> gameDelegate;
@property (nonatomic, retain) ChipmunkSpace *space;
@property (nonatomic, assign) CCNode* marbleBatchNode;
@property (nonatomic, assign) CCNode* otherSpritesNode;
@property (nonatomic, retain) NSString* currentMarbleSet;
@property (nonatomic, readonly) CCPhysicsDebugNode *debugLayer;
@property (nonatomic, assign,getter = isSimulationRunning) BOOL simulationRunning;
@property (nonatomic, retain) CMMarbleCollisionCollector *collisionCollector;
@property (nonatomic, retain) NSMutableArray* simulatedMarbles;
@property (nonatomic, retain) NSArray* staticShapes;

@property (nonatomic, retain) ChipmunkGrooveJoint *dollyGroove;
@property (nonatomic, retain) ChipmunkShape *dollyShape;
@property (nonatomic, retain) ChipmunkPivotJoint* dollyServo;
@property (nonatomic, retain) ChipmunkBody *dollyBody;
@property (nonatomic, assign) CMMarbleLevel *currentLevel;
@property (nonatomic, assign) NSUInteger marblesToFire;
@property (nonatomic, retain) NSTimer* marbleFireTimer;
@property (nonatomic, assign) NSUInteger currentMarbleIndex;
@property (nonatomic, retain) NSArray* bounds;
@property (nonatomic, assign) NSTimeInterval lastMarbleSoundTime;


// returns a CCScene that contains the HelloWorldLayer as the only child


+(CCScene *) scene;

- (void) prepareMarble;
-(void) startSimulation;
-(void) stopSimulation;
-(void) resetSimulation;

-(void) retextureMarbles;
- (void) removeCollisionSets:(NSArray*) layers;
- (void) removedMarbles:(NSSet*) removedOnes;
@end
