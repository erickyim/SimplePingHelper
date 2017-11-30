//
//  FirstViewController.m
//  PingTester
//
//  Created by Chris Hulbert on 18/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import "SimplePingHelper.h"

@implementation FirstViewController

@synthesize ipAddr;
@synthesize results;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Ping Tester";
        
        UIBarButtonItem *go = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(tapPing)];
        self.navigationItem.rightBarButtonItem = go;
    }
    return self;
}
                            
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)log:(NSString *)str {
    self.results.text = [NSString stringWithFormat:@"%@%@\n", self.results.text, str];
    NSLog(@"%@", str);
}

- (void)tapPing {
    self.results.text = [[NSDate date] descriptionWithLocale:[NSLocale currentLocale]];
    [self log:@""];
    [self log:@"-----------"];
    [self log:@"Tapped Ping"];
    [SimplePingHelper ping:self.ipAddr.text completionHandler:^(BOOL success, NSString *reaseon) {
        if (success) {
            [self log:@"SUCCESS"];
        } else {
            [self log:@"FAILURE"];
        }
    }];
}

- (void)pingResult:(NSNumber*)success {

}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ipAddr.text = @"192.168.30.138";
    self.results.text = @"";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
