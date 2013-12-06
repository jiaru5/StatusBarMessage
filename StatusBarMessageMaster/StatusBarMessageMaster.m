//
//  StatusBarMessageMaster.m
//  StatusBarMessage
//
//  Created by Jia Ru on 12/5/13.
//  Copyright (c) 2013 Jiaru. All rights reserved.
//

#import "StatusBarMessageMaster.h"

#define kStatusBarNoticeAnimationDuration   0.4f

@interface StatusBarMessageMaster()

@property (strong, nonatomic) UIWindow *noticeWindow;
@property (strong, nonatomic) UILabel *noticeLabel;

@property (strong, nonatomic) NSMutableArray *noticeQueue;
@property (assign, nonatomic) BOOL isShowingNotice;
@property (assign, nonatomic) int currentShowingNoticeIndexInQueue;

@end

@implementation StatusBarMessageMaster

static StatusBarMessageMaster *INSTANCE = nil;

+ (StatusBarMessageMaster *)getInstance
{
    @synchronized(self) {
        if (INSTANCE == nil)
            INSTANCE = [[self alloc] init];
    }
    return INSTANCE;
}

- (void)showNotice:(NSString *)noticeContent backgroundColor:(UIColor *)backgroundColor {
    @synchronized(self.noticeQueue) {
        if (nil == self.noticeQueue) {
            self.noticeQueue = [NSMutableArray array];
        }
        [self.noticeQueue addObject:[[StatusBarNotice alloc] initWithContent:noticeContent andBackgroundColor:backgroundColor]];
        if (!self.isShowingNotice) {
            self.isShowingNotice = YES;
            self.currentShowingNoticeIndexInQueue = 0;
            [self showNoticeFromQueue:self.currentShowingNoticeIndexInQueue];
        }
    }
}

- (void)showNoticeFromQueue:(int)indexInQueue {
    StatusBarNotice *noticeToShow = (StatusBarNotice *)[self.noticeQueue objectAtIndex:self.currentShowingNoticeIndexInQueue];
    [self drawWindowAndLabelWithColor:noticeToShow.backgroundColor];
    self.noticeLabel.text = noticeToShow.noticeContent;
    [self setNoticeLabelToUpPosition];
    [UIView animateWithDuration:kStatusBarNoticeAnimationDuration animations:^{
        [self setNoticeLabelToShowPosition];
    }];
    
    [self performSelector:@selector(dismissNoticeAnimated) withObject:self afterDelay:3.4f];
}

- (void)drawWindowAndLabelWithColor:(UIColor *)color {
    if (nil == self.noticeWindow) {
        _noticeWindow = [[UIWindow alloc] initWithFrame:[UIApplication sharedApplication].statusBarFrame];
        _noticeWindow.backgroundColor = [UIColor clearColor];
        _noticeWindow.windowLevel = UIWindowLevelAlert;
        [self.noticeWindow makeKeyAndVisible];
    }
    
    if (nil == self.noticeLabel) {
        self.noticeLabel = [[UILabel alloc] initWithFrame:[UIApplication sharedApplication].statusBarFrame];
        [self.noticeWindow addSubview:self.noticeLabel];
        self.noticeLabel.alpha = 0.9f;
        self.noticeLabel.textAlignment = NSTextAlignmentCenter;
    }
    self.noticeLabel.backgroundColor = color;
}

- (void)dismissNoticeAnimated {
    [UIView animateWithDuration:kStatusBarNoticeAnimationDuration animations:^{
        [self setNoticeLabelToUpPosition];
    } completion:^(BOOL finished) {
        @synchronized(self.noticeQueue) {
            if ((self.noticeQueue.count - 1) == self.currentShowingNoticeIndexInQueue) { // all notices have finish showing.
                [self dismissWindow];
            } else {
                self.currentShowingNoticeIndexInQueue++;
                [self showNoticeFromQueue:self.currentShowingNoticeIndexInQueue];
            }
        }
    }];
}

- (void)dismissWindow {
    self.isShowingNotice = NO;
    self.noticeLabel = nil;
    [self.noticeLabel removeFromSuperview];
    self.noticeWindow = nil;
    [self.noticeWindow removeFromSuperview];
    self.noticeQueue = nil;
}

- (void)setNoticeLabelToUpPosition {
    [self setNoticeLabelFrameY:(-[self getStatusBarHeight])];
}

- (void)setNoticeLabelToShowPosition {
    [self setNoticeLabelFrameY:0];
}

- (void)setNoticeLabelToDownPosition {
    [self setNoticeLabelFrameY:[self getStatusBarHeight]];
}

- (CGFloat)getStatusBarHeight {
    return CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
}

- (void)setNoticeLabelFrameY:(CGFloat)frameY {
    CGRect frameOfNoticeLabel = self.noticeLabel.frame;
    frameOfNoticeLabel.origin.y = frameY;
    self.noticeLabel.frame = frameOfNoticeLabel;
}

@end

@implementation StatusBarNotice

- (id)initWithContent:(NSString *)noticeContent andBackgroundColor:(UIColor *)backgroundColor {
    self = [super init];
    if (self) {
        _noticeContent = noticeContent;
        _backgroundColor = backgroundColor;
    }
    return self;
}

@end