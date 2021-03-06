//
//  FacebookViewController.m
//  reactive-cocoa-playground
//
//  Created by Prabir Shrestha on 1/18/13.
//  Copyright (c) 2013 Prabir Shrestha. All rights reserved.
//

#import "FacebookViewController.h"
#import "RACFacebook.h"
#import <BlocksKit.h>
#import <ReactiveCocoa.h>

@interface FacebookViewController ()

@end

@implementation FacebookViewController

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
    
    [[[[FBRequestConnection
     rac_startWithGraphPath:@"4"
     parameters:nil
     HTTPMethod:@"GET"]
     doNext:^(id x) {
         NSLog(@"%@", x);
     }]
     map:^id(RACTuple *value) {
         id result = [value second];
         return [NSString stringWithFormat:@"%@ %@", [result objectForKey:@"first_name"], [result objectForKey:@"last_name"]];
     }]
     subscribeNext:^(id x) {
         NSLog(@"%@", x);
     }
     error:^(NSError *error) {
         NSLog(@"%@", error);
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
