//
//  ViewController.m
//  ClockAnimation
//
//  Created by Admin on 24.10.15.
//  Copyright (c) 2015 OlhaF. All rights reserved.
//

#import "ViewController.h"
#import "OFClockView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView * analogView;
@property (strong, nonatomic) OFClockView * clockView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setClock];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setClock
{
    CGRect clockFrame = CGRectMake(0, 0, 250, 250);
    self.clockView = [[OFClockView alloc] initWithFrame:clockFrame];
    
    self.clockView.clockFaceImageView.image = [UIImage imageNamed:@"ClockFace2.jpeg"];
    self.clockView.hourHandImageView.image = [UIImage imageNamed:@"hourHand.png"];
    self.clockView.minuteHandImageView.image = [UIImage imageNamed:@"minuteHand.png"];
    self.clockView.secondsHandImageView.image = [UIImage imageNamed:@"secondsHand.png"];
    
    [self.analogView addSubview:self.clockView];
    
    [self.clockView start];
}

@end
