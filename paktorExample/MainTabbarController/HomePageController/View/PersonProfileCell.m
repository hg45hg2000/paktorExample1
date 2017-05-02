//
//  PersonProfileCell.m
//  collectionViewStackLayout
//
//  Created by 林羣珩 on 2017/4/20.
//  Copyright © 2017年 林羣珩. All rights reserved.
//

#import "PersonProfileCell.h"
#import "paktorExample-Swift.h"

NSTimeInterval backToAnimationTime = 0.3;
CGFloat moveDetectConstants = 150;

@interface PersonProfileCell()<UIGestureRecognizerDelegate>{
    
}
@property (assign,nonatomic)CGPoint beginLocation;
@property (assign,nonatomic)CGPoint beginTouchLocation;
// tableview


@end
@implementation PersonProfileCell


- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pangeatrue:)];
    pan.delegate = self;
    [self addGestureRecognizer:pan];
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    UIView *cell = [gestureRecognizer view];
    CGPoint translation = [gestureRecognizer translationInView:[cell superview]];
    
    // Check for horizontal gesture
    if (fabs(translation.x) > fabs(translation.y))
    {
        return YES;
    }
    
    return NO;
}


- (void)pangeatrue:(UIPanGestureRecognizer*)pan{
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            self.beginTouchLocation = [pan locationInView:self.superview];
            self.beginLocation = self.frame.origin;
            break;
        case UIGestureRecognizerStateChanged:{
            CGPoint lastLocation = [pan locationInView:self.superview];
           
            CGFloat moveX =  lastLocation.x -self.superview.bounds.size.width/2 ;
            
            CGFloat moveY =  lastLocation.y - self.superview.bounds.size.height/2;
            if (self.delegate && [self.delegate respondsToSelector:@selector(PersonProfileCellMovePositionX:MovePositionY:)]) {
                [self.delegate PersonProfileCellMovePositionX:moveX/100 MovePositionY:moveY];
            }
            CGPoint trantranslation = [pan translationInView:self.superview];
            CGRect frame = self.frame;
            frame.origin.x += trantranslation.x * cos(M_PI/6);
            frame.origin.y += trantranslation.y * sin(M_PI/6);
            self.frame = frame;
            [pan setTranslation:CGPointZero inView:self.superview];
        }
            break;
        case UIGestureRecognizerStateEnded:{
            
            CGPoint lastLocation = [pan locationInView:self.superview];
//            CGFloat angle = [self  pointPairToBearingDegrees:self.beginTouchLocation secondPoint:lastLocation];
//            NSLog(@"angle %f",angle );
            CGFloat moveX =  lastLocation.x - self.superview.bounds.size.width/2 ;
            CGFloat moveY =  lastLocation.y - self.superview.bounds.size.height/2;
            NSLog(@"move x %f",moveX);
            if (moveX > moveDetectConstants) {
                NSLog(@"right");
                [self listenSwipeDirection:Right];
            }else if (moveX < - moveDetectConstants){
                NSLog(@"left");
                [self listenSwipeDirection:Left];
            }
            else{
                [self moveToBeginLocation];
            }
            [self listenSwipeDirection:End];
        }
            break;
        default:
            break;
    }
}

- (CGFloat) pointPairToBearingDegrees:(CGPoint)startingPoint secondPoint:(CGPoint) endingPoint
{
    CGPoint originPoint = CGPointMake(endingPoint.x - startingPoint.x, endingPoint.y - startingPoint.y); // get origin point to origin by subtracting end from start
    float bearingRadians = atan2f(originPoint.y, originPoint.x); // get bearing in radians
    float bearingDegrees = bearingRadians * (180.0 / M_PI); // convert to degrees
    bearingDegrees = (bearingDegrees > 0.0 ? bearingDegrees : (360.0 + bearingDegrees)); // correct discontinuity
    return bearingDegrees;
}

- (void)listenSwipeDirection:(SwipeDirection)direction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(PersonEndChoiceProfileCell:SwipeDirection:)]) {
        [self.delegate PersonEndChoiceProfileCell:self SwipeDirection:direction];
    }
}

- (void)moveToBeginLocation{
    [UIView animateWithDuration:backToAnimationTime animations:^{
        CGRect frame = self.frame;
        frame.origin = self.beginLocation;
        self.frame = frame;
    }];
}

@end
