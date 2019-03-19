//
//  PQSchedulePorgressView.h
//  Pods-PQScheduleView_Example
//
//  Created by wenpq on 2019/3/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PQScheduleProgressDelegate <NSObject>

@optional

- (void)scheduleTimeout;

- (void)scheduleProgress:(CGFloat)progress;

@end

@interface PQSchedulePorgressView : UIView

@property (nonatomic, strong) UIColor *progressColor;//进度条颜色，默认为0xffaa00

@property (nonatomic, assign) CGFloat beginAngle;//开始角度，默认是0

@property (nonatomic, assign) CGFloat progressWidth;//刻度的宽度,默认是20

@property (nonatomic, assign) CFTimeInterval totalTime;//总时间,默认是100s

@property (nonatomic, weak) id<PQScheduleProgressDelegate> delegate;

- (void)startProgress;

- (void)stopProgress;

- (void)resume;

@end

NS_ASSUME_NONNULL_END
