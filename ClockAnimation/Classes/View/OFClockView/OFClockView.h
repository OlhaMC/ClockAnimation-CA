//
//  OFClockView.h
//  ClockAnimation
//
//  Created by Admin on 24.10.15.
//  Copyright (c) 2015 OlhaF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OFClockView : UIView

@property (strong, nonatomic) UIImageView * clockFaceImageView;
@property (strong, nonatomic) UIImageView * hourHandImageView;
@property (strong, nonatomic) UIImageView * minuteHandImageView;
@property (strong, nonatomic) UIImageView * secondsHandImageView;

- (id) initWithFrame:(CGRect)frame;
- (void) start;

@end
