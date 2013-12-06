//
//  RDemoViewController.m
//  StatusBarMessageDemo
//
//  Created by Jia Ru on 12/6/13.
//  Copyright (c) 2013 JiaruPrimer. All rights reserved.
//

#import "RDemoViewController.h"
#import "StatusBarMessageMaster.h"

@interface RDemoViewController ()

@end

@implementation RDemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showMessageWithRed:(id)sender {
    [[StatusBarMessageMaster getInstance] showNotice:self.messageTextField.text backgroundColor:[UIColor redColor]];
}

- (IBAction)showMessageWithOrange:(id)sender {
    [[StatusBarMessageMaster getInstance] showNotice:self.messageTextField.text backgroundColor:[UIColor orangeColor]];
}
@end
