//
//  StatusBarMessageMaster.h
//  StatusBarMessage
//
//  Created by Jia Ru on 12/5/13.
//  Copyright (c) 2013 Jiaru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatusBarMessageMaster : NSObject

+ (StatusBarMessageMaster *)getInstance;

- (void)showNotice:(NSString *)noticeContent backgroundColor:(UIColor *)backgroundColor;

@end

@interface StatusBarNotice : NSObject

@property (copy, nonatomic) NSString *noticeContent;
@property (strong, nonatomic) UIColor *backgroundColor;

- (id)initWithContent:(NSString *)noticeContent andBackgroundColor:(UIColor *)backgroundColor;

@end