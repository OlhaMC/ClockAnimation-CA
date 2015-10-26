//
//  OFClockView.m
//  ClockAnimation
//
//  Created by Admin on 24.10.15.
//  Copyright (c) 2015 OlhaF. All rights reserved.
//

#import "OFClockView.h"

@interface OFClockView ()

@property (strong, nonatomic) NSCalendar * calendar;
@property (strong, nonatomic) NSDate * currentDate;

@end

@implementation OFClockView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        CGRect imageViewFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        _clockFaceImageView = [[UIImageView alloc] initWithFrame: imageViewFrame];
        _hourHandImageView = [[UIImageView alloc] initWithFrame: imageViewFrame];
        _minuteHandImageView = [[UIImageView alloc] initWithFrame: imageViewFrame];
        _secondsHandImageView = [[UIImageView alloc] initWithFrame: imageViewFrame];
        
        [self addSubview: _clockFaceImageView];
        [self addSubview: _hourHandImageView];
        [self addSubview: _minuteHandImageView];
        [self addSubview: _secondsHandImageView];
    }
    
    _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    return  self;
}

- (void)start
{
    self.currentDate = [NSDate date];
    
    double radianAngleForHours = [self getRadianAngleForHoursHand];
    double radianAngleForMinutes = [self getRadianAngleForMinutesHand];
    double radianAngleForSeconds = [self getRadianAngleForSecondsHand];
    
    [self animationForImageView:self.hourHandImageView fromState:radianAngleForHours withDuration:43200];
    [self animationForImageView:self.minuteHandImageView fromState:radianAngleForMinutes withDuration:3600];
    [self animationForImageView:self.secondsHandImageView fromState:radianAngleForSeconds withDuration:60];
    
}

- (void) animationForImageView: (UIImageView*)clockHand fromState:(double)currentAngle withDuration: (double)duration
{
    CABasicAnimation * animation =
                            [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = duration;
    animation.repeatCount = INFINITY;
    animation.fromValue = [NSNumber numberWithDouble: currentAngle];
    animation.toValue = [NSNumber numberWithDouble:(360 * M_PI / 180 + currentAngle)];
    
    [clockHand.layer addAnimation:animation forKey:@"transform"];
    
}

- (double) getRadianAngleForHoursHand
{
    NSInteger degreesPerHour   = 30;
    NSInteger degreesPerMinute = 6;
    
    double degreesForHours = ([self hours] % 12) * degreesPerHour;
    double degreesForMinutes = ([self minutes] / 12) * degreesPerMinute;
    double totalDegrees = degreesForHours + degreesForMinutes;
    
    double hourRadianAngle = totalDegrees * M_PI / 180;
    
    return hourRadianAngle;
}

- (double) getRadianAngleForMinutesHand
{
    NSInteger degreesPerMinute = 6;
    double degreesPerSecond = 1.2f;
    
    double degreesForMinutes = [self minutes] * degreesPerMinute;
    double degreesForSeconds = ([self seconds] / 12) * degreesPerSecond;
    double totalDegrees = degreesForMinutes+degreesForSeconds;

    double minutesRadianAngle = totalDegrees * M_PI / 180;
    
    return minutesRadianAngle;
}

- (double) getRadianAngleForSecondsHand
{
    NSInteger degreesPerSecond = 6;
    
    double secondsRadianAngle = ([self seconds] * degreesPerSecond)* M_PI / 180;
    
    return secondsRadianAngle;
}


- (NSInteger) hours
{
    return [self.calendar component:NSCalendarUnitHour fromDate:self.currentDate];
}

- (NSInteger) minutes
{
    return [self.calendar component:NSCalendarUnitMinute fromDate:self.currentDate];
}

- (NSInteger) seconds
{
    return [self.calendar component:NSCalendarUnitSecond fromDate:self.currentDate];
}


@end
