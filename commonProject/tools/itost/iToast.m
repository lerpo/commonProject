//  iToast.m
//  iToastDemo
//
//  Created by amao on 12/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "iToast.h"
#import <QuartzCore/QuartzCore.h>

const CGFloat kToastTextPadding     = 15;
const CGFloat kToastButtonPaddding  = 20;
const CGFloat kToastLabelWidth      = 280;
const CGFloat kToastLabelHeight     = 60;
const CGFloat kToastMargin          = 45;
const CGFloat kToastXOffset         = 95;

@implementation iToast

@synthesize toastPosition;
@synthesize toastDuration;
@synthesize toastText;
@synthesize button;

- (id)init
{
    if (self = [super init])
    {
        toastPosition = kToastPositionCenter;
        toastDuration = kToastDurationNormal;
    }
    return self;
}

- (id)initWithText:(NSString *)text
{
    if (self = [super init])
    {
        toastPosition = kToastPositionCenter;
        toastDuration = kToastDurationNormal;
        self.toastText= text;
    }
    return self;
}

- (void)dealloc
{
    [toastText release];
    [super dealloc];
}

+ (iToast *)makeToast:(NSString *)text
{
    iToast *toast = [[iToast alloc]initWithText:text];
    return [toast autorelease];
}

- (void)show
{
    isRemove = 0;
    UIFont *font   = [UIFont systemFontOfSize:16];
    CGSize textSize= [toastText sizeWithFont:font constrainedToSize:CGSizeMake(kToastLabelWidth, kToastLabelHeight)];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, textSize.width + 2 * kToastTextPadding, 
                                                              textSize.height + 2 * kToastTextPadding)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
	label.font = font;
	label.text = toastText;
	label.numberOfLines = 0;
	label.shadowColor = [UIColor darkGrayColor];
	label.shadowOffset = CGSizeMake(1, 1);
    label.textAlignment = UITextAlignmentCenter;

    button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.bounds = CGRectMake(0, 0, textSize.width + 2 * kToastButtonPaddding, textSize.height + 2 * kToastButtonPaddding);
	label.center = CGPointMake(button.bounds.size.width / 2, button.bounds.size.height / 2);
	[button addSubview:label];
    [label release];
	
	button.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
	button.layer.cornerRadius = 5;
	
	UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    CGPoint point = window.center;
    CGPoint center = window.center;
    CGFloat dx = 0;
    
    if (toastPosition == kToastPositionTop) 
    {
        point = CGPointMake(point.x, kToastMargin + button.bounds.size.height);
        dx    = center.x - kToastXOffset;
    }
    else if(toastPosition == kToastPositionBottom)
    {
        point = CGPointMake(point.x, window.bounds.size.height - kToastMargin - button.bounds.size.height);
        dx    = kToastXOffset - center.x ;

    }
    button.center = point;
    
    UIInterfaceOrientation currentOrient= [UIApplication
                                           sharedApplication].statusBarOrientation;
    
    if(currentOrient == UIDeviceOrientationLandscapeRight)
    {
        CGAffineTransform rotateTransform   = CGAffineTransformMakeRotation((M_PI/2) * -1);
        CGAffineTransform translateTransform= CGAffineTransformMakeTranslation(-dx,center.y - point.y);
        CGAffineTransform t = CGAffineTransformConcat(rotateTransform,translateTransform);
        button.transform = CGAffineTransformConcat(button.transform, t);
    }
    else if(currentOrient == UIDeviceOrientationLandscapeLeft)
    {
        CGAffineTransform rotateTransform   = CGAffineTransformMakeRotation((M_PI/2));
        CGAffineTransform translateTransform= CGAffineTransformMakeTranslation(dx,center.y - point.y);
        CGAffineTransform t = CGAffineTransformConcat(rotateTransform,translateTransform);
        button.transform = CGAffineTransformConcat(button.transform, t);
    }
    else if(currentOrient == UIDeviceOrientationPortraitUpsideDown)
    {
        button.transform = CGAffineTransformRotate(button.transform, M_PI);
    }
    [window addSubview:button];
    view = button;
    NSTimer *timer = [NSTimer timerWithTimeInterval:(CGFloat)toastDuration / 1000.0 
                                              target:self selector:@selector(onHideToast:) 
                                            userInfo:nil repeats:NO];
	[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [button addTarget:self action:@selector(hideToast:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)hideToast:(id)sender
{
    [self doHideToast];
}

- (void)onHideToast:(NSTimer *)timer
{
    [self doHideToast];
}

- (void)doHideToast
{
    if (isRemove==0) {
        [UIView beginAnimations:nil context:nil];
        view.alpha = 0;
        [UIView commitAnimations];
        NSTimer *timer = [NSTimer timerWithTimeInterval:100
                                                 target:self selector:@selector(onRemoveToast:)
                                               userInfo:nil repeats:NO];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    }
}

- (void)onRemoveToast:(NSTimer *)timer
{
    [view removeFromSuperview];
    isRemove = 1;
}

@end