//
//  RDemoViewController.h
//  StatusBarMessageDemo
//
//  Created by Jia Ru on 12/6/13.
//  Copyright (c) 2013 JiaruPrimer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RDemoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *messageTextField;

- (IBAction)showMessageWithRed:(id)sender;
- (IBAction)showMessageWithOrange:(id)sender;

@end
