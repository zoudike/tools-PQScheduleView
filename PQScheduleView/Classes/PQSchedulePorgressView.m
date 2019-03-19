//
//  PQSchedulePorgressView.m
//  Pods-PQScheduleView_Example
//
//  Created by wenpq on 2019/3/19.
//

#import "PQSchedulePorgressView.h"

#define kPQScheduleProgressColor    [UIColor colorWithRed:0xFF/255.0 green:0xAA/255.0 blue:0x00/255.0 alpha:1.0]

#define kPQScheduleBeginAngle   -0.5 * M_PI

@interface PQSchedulePorgressView ()

@property (nonatomic, strong) CAShapeLayer *progressLayer;

@property (nonatomic, assign) NSInteger progress;//进度

@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic, assign) CFTimeInterval startTime;

@end

@implementation PQSchedulePorgressView

- (void)drawRect:(CGRect)rect {
    
    self.progressLayer = [[CAShapeLayer alloc] init];
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGFloat radius = MIN(width/2.0, height/2.0);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2.0, height/2.0) radius:radius startAngle:self.beginAngle endAngle:2 * M_PI + self.beginAngle clockwise:YES];
    self.progressLayer.path = path.CGPath;
    self.progressLayer.lineWidth = self.progressWidth ? : 20.0f;
    self.progressLayer.strokeColor = (self.progressColor ? : kPQScheduleProgressColor).CGColor;
    self.progressLayer.fillColor = [UIColor clearColor].CGColor;
    self.progressLayer.lineDashPattern = @[@(3),@(3)];
    self.progressLayer.strokeStart = 0.0;
    self.progressLayer.strokeEnd = 0.3;
    [self.layer addSublayer:self.progressLayer];
}

#pragma mark -- public functions
- (void)startProgress {
    if (!self.displayLink) {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(calculateProgress:)];
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    self.progress = 0.0;//开始动作的时候，进度为0.0
    self.startTime = CACurrentMediaTime();//开始时间
}

- (void)stopProgress {
    if (self.displayLink) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}

- (void)resume {
    if (!self.displayLink) {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(calculateProgress:)];
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)calculateProgress:(CADisplayLink *)displayLink {
    CFTimeInterval progressTime = CACurrentMediaTime() - self.startTime;
    CFTimeInterval totalTime = self.totalTime ? : 100;
    NSInteger progress =  (NSInteger)(progressTime/totalTime * 100);
    if (self.progress != progress) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.progressLayer.strokeEnd = progress/100.0;
        [CATransaction commit];
        self.progress = progress;
        if (self.delegate
            && [self.delegate respondsToSelector:@selector(scheduleProgress:)]) {
            [self.delegate scheduleProgress:progress];
        }
    }
    if (self.progress >= 100) {
        [self.displayLink invalidate];
        self.displayLink = nil;
        if (self.delegate
            && [self.delegate respondsToSelector:@selector(scheduleTimeout)]) {
            [self.delegate scheduleTimeout];
        }
    }
}


@end
