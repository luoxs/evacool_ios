//
//  SemiCircleProgressView.m
//  SHProgressView
//
//  Created by zxy on 16/3/16.
//  Copyright © 2016年 Chenshaohua. All rights reserved.
//

#import "SemiCircleProgressView.h"

@interface SemiCircleProgressView(){
    CAShapeLayer *_bottomShapeLayer;
    CAShapeLayer *_upperShapeLayer;
    CAShapeLayer *_longShapeLayer;
    CGFloat _percent;
}
@end

@implementation SemiCircleProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    if ((self = [super initWithFrame:frame])) {
        [self drawBottomLayer];
        [self drawUpperLayer:0];
        [self drawLongLayer:0];
        [self.layer addSublayer:_bottomShapeLayer ];
        [_bottomShapeLayer addSublayer:_upperShapeLayer];
        [_upperShapeLayer addSublayer:_longShapeLayer];
    }
    return self;
}

-(void) setchgt:(int) c{
    [_longShapeLayer removeFromSuperlayer];
    [_upperShapeLayer removeFromSuperlayer];
    [_bottomShapeLayer removeFromSuperlayer];
    
    [self drawBottomLayer];
    [self drawUpperLayer:c];
    [self drawLongLayer:c];
    [self.layer addSublayer:_bottomShapeLayer ];
    [_bottomShapeLayer addSublayer:_upperShapeLayer];
    [_upperShapeLayer addSublayer:_longShapeLayer];
}


- (CAShapeLayer *)drawBottomLayer{
    _bottomShapeLayer                 = [[CAShapeLayer alloc] init];
    _bottomShapeLayer.frame           = self.bounds;
    CGFloat width                     = self.bounds.size.width;

    UIBezierPath *path                = [UIBezierPath bezierPathWithArcCenter:CGPointMake((CGRectGetMaxX(self.frame) - CGRectGetMinX(self.frame)) / 2, (CGRectGetMaxY(self.frame) - CGRectGetMinY(self.frame)) / 2)  radius:width / 2 startAngle:2.3625 endAngle:0.785 clockwise:YES];
    
    
    _bottomShapeLayer.path            = path.CGPath;
    _bottomShapeLayer.lineCap = kCALineCapButt;
    _bottomShapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:2],[NSNumber numberWithInt:4], nil];
    _bottomShapeLayer.lineWidth = 20;
    _bottomShapeLayer.strokeColor = [UIColor grayColor].CGColor;
    //_bottomShapeLayer.strokeColor  = [UIColor colorWithRed:29.0/255 green:130.0/255 blue:254.0/255 alpha:1.0].CGColor;
    _bottomShapeLayer.fillColor       = [UIColor clearColor].CGColor;
    return _bottomShapeLayer;
}


- (CAShapeLayer *)drawUpperLayer:(int) c{
    _upperShapeLayer                 = [[CAShapeLayer alloc] init];
    _upperShapeLayer.frame           = self.bounds;
    CGFloat width                     = self.bounds.size.width;
   
    UIBezierPath *path                = [UIBezierPath bezierPathWithArcCenter:CGPointMake((CGRectGetMaxX(self.frame) - CGRectGetMinX(self.frame)) / 2, (CGRectGetMaxY(self.frame) - CGRectGetMinY(self.frame)) / 2)  radius:width / 2 startAngle:2.3625 endAngle:0.785 clockwise:YES];
    _upperShapeLayer.path            = path.CGPath;
    _upperShapeLayer.strokeStart = 0;
   // _upperShapeLayer.strokeEnd =   0;
 //   [self performSelector:@selector(shapeChange) withObject:nil afterDelay:0.0];
    _upperShapeLayer.strokeEnd = _percent;
   // _longShapeLayer.strokeStart = _percent - 0.0225;
   // _longShapeLayer.strokeStart = _percent - 0.01;
  //  _longShapeLayer.strokeEnd = _percent;
    _upperShapeLayer.lineWidth = 20;
    _upperShapeLayer.lineCap = kCALineCapButt;
    _upperShapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:2],[NSNumber numberWithInt:4], nil];
    if(c==0){
        _upperShapeLayer.strokeColor = [UIColor colorWithRed:29/255.0 green:130/255.0 blue:254/255.0 alpha:1].CGColor;
    }else if(c==1){
        _upperShapeLayer.strokeColor = [UIColor brownColor].CGColor;
    }else{
        _upperShapeLayer.strokeColor = [UIColor grayColor].CGColor;
    }
   // _upperShapeLayer.strokeColor     = [UIColor colorWithRed:29.0/255 green:130.0/255 blue:254.0/255 alpha:1.0].CGColor;
    _upperShapeLayer.fillColor       = [UIColor clearColor].CGColor;
    return _upperShapeLayer;
}

- (CAShapeLayer *)drawLongLayer:(int) c{
    _longShapeLayer                 = [[CAShapeLayer alloc] init];
    _longShapeLayer.frame           = self.bounds;
    CGFloat width                     = self.bounds.size.width;
   
    UIBezierPath *path                = [UIBezierPath bezierPathWithArcCenter:CGPointMake((CGRectGetMaxX(self.frame) - CGRectGetMinX(self.frame)) / 2, (CGRectGetMaxY(self.frame) - CGRectGetMinY(self.frame)) / 2)  radius:width / 1.85 startAngle:2.3625 endAngle:0.785 clockwise:YES];
    _longShapeLayer.path            = path.CGPath;
  //  _longShapeLayer.strokeStart = 0;
  //  _longShapeLayer.strokeEnd =   0;
 //   [self performSelector:@selector(shapeChange) withObject:nil afterDelay:0.0];
  //  _upperShapeLayer.strokeEnd = _percent;
   // _longShapeLayer.strokeStart = _percent - 0.0225;
    _longShapeLayer.strokeStart = _percent - 0.01;
    _longShapeLayer.strokeEnd = _percent;
    
    _longShapeLayer.lineWidth = 25;
    _longShapeLayer.lineCap = kCALineCapButt;
    _longShapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:2],[NSNumber numberWithInt:4], nil];
    //_longShapeLayer.strokeColor     = [UIColor colorWithRed:29.0/255 green:130.0/255 blue:254.0/255 alpha:1.0].CGColor;
    if(c==0){
        _longShapeLayer.strokeColor  = [UIColor colorWithRed:29.0/255 green:130.0/255 blue:254.0/255 alpha:1.0].CGColor;
       // _longShapeLayer.strokeColor = [UIColor blueColor].CGColor;
    }else if(c==1){
        _longShapeLayer.strokeColor = [UIColor brownColor].CGColor;
    }else{
        _longShapeLayer.strokeColor = [UIColor grayColor].CGColor;
    }
    _longShapeLayer.fillColor       = [UIColor clearColor].CGColor;
    return _longShapeLayer;
}



@synthesize percent = _percent;
- (CGFloat )percent{
    return _percent;
}
- (void)setPercent:(CGFloat)percent{
    _percent = percent;
    
    if (percent > 1) {
        percent = 1;
    }else if (percent < 0){
        percent = 0;
    }
}

- (void)shapeChange{
    _upperShapeLayer.strokeEnd = _percent;
   // _longShapeLayer.strokeStart = _percent - 0.0225;
    _longShapeLayer.strokeStart = _percent - 0.01;
    _longShapeLayer.strokeEnd = _percent;
}
@end
