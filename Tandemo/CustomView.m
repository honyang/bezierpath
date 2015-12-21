//
//  CustomView.m
//  Tandemo
//
//  Created by jkb on 15/12/21.
//  Copyright © 2015年 Enjoyor. All rights reserved.
//

#import "CustomView.h"
#define SYS_DEVICE_WIDTH    ([[UIScreen mainScreen] bounds].size.width)                  // 屏幕宽度
#define SYS_DEVICE_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)                 // 屏幕长度
#define MIN_HEIGHT 100
@interface CustomView(){
     CGPoint _currentPoint;
     UIView *_dView;
}
@property (nonatomic,retain)CAShapeLayer  *shaperLayer;
@property (nonatomic,retain)CADisplayLink *displayLinker;
@end
@implementation CustomView
- (void)drawRect:(CGRect)rect{
    [self shaperLayer];
    [self displayLinker];
    _currentPoint=CGPointMake(SYS_DEVICE_WIDTH/2, MIN_HEIGHT);
    _dView=[[UIView alloc]initWithFrame:CGRectMake(SYS_DEVICE_WIDTH/2, MIN_HEIGHT, 3, 3)];
    UIPanGestureRecognizer *panGesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    [self addGestureRecognizer:panGesture];
    _currentPoint=CGPointMake(SYS_DEVICE_WIDTH/2, 200);
    _dView=[[UIView alloc]initWithFrame:CGRectMake(SYS_DEVICE_WIDTH/2, 200, 3, 3)];
    [self addSubview:_dView];
    [self updatePath];
}
-(CAShapeLayer *)shaperLayer{
    if (_shaperLayer==nil) {
        _shaperLayer = [CAShapeLayer layer];
        _shaperLayer.fillColor = [UIColor colorWithRed:
                                        57/255.0 green:67/255.0
                                                  blue:89/255.0
                                                 alpha:1.0].CGColor;
        [self.layer addSublayer:_shaperLayer];
    }
    return _shaperLayer;
}
-(CADisplayLink *)displayLinker{
    if (_displayLinker==nil) {
        _displayLinker=[CADisplayLink displayLinkWithTarget:self selector:@selector(configPath)];
        [_displayLinker addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return _displayLinker;
}
-(void)updatePath{
    UIBezierPath *path=[UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 200)];
    [path addQuadCurveToPoint:CGPointMake(SYS_DEVICE_WIDTH,200) controlPoint:CGPointMake(_currentPoint.x,_currentPoint.y)];
    [path addLineToPoint:CGPointMake(SYS_DEVICE_WIDTH,210)];
    [path addQuadCurveToPoint:CGPointMake(0,210) controlPoint:CGPointMake(_currentPoint.x,_currentPoint.y+10)];
    [path addLineToPoint:CGPointMake(0,200)];
    path.lineCapStyle=kCGLineCapRound;
    path.lineJoinStyle=kCGLineJoinRound;
    [path closePath];
    _shaperLayer.path=path.CGPath;
    if (self.displayLinker.paused) {
        NSLog(@"yes");
    }else{
        NSLog(@"no");
    }
    NSLog(@"self.disPlayLink==%@",self.displayLinker);
}
-(void)configPath{
    CALayer *layer = _dView.layer.presentationLayer;
    _currentPoint.x = layer.position.x;
    _currentPoint.y = layer.position.y;
    [self updatePath];
}
-(void)panAction:(UIPanGestureRecognizer *)gesture{
    if (gesture.state==UIGestureRecognizerStateChanged) {
        CGPoint point=[gesture translationInView:self];
        _currentPoint.x=point.x+SYS_DEVICE_WIDTH/2;
        _currentPoint.y=point.y+200;
       // _currentPoint.y=point.y;
        _dView.frame=CGRectMake(_currentPoint.x, _currentPoint.y, 3, 3);
        [self updatePath];
    }else if(gesture.state == UIGestureRecognizerStateCancelled ||
             gesture.state == UIGestureRecognizerStateEnded ||
             gesture.state == UIGestureRecognizerStateFailed){
        self.displayLinker.paused=NO;
        [UIView animateWithDuration:0.3
                              delay:0
             usingSpringWithDamping:0.3
              initialSpringVelocity:100
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                                _dView.frame=CGRectMake(SYS_DEVICE_WIDTH/2, 200, 3, 3);
                            } completion:^(BOOL finished) {
                                if (finished) {
                                    self.displayLinker.paused=YES;
                                }
                            }
        ];
    }
    
}
@end
