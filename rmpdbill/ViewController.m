//
//  ViewController.m
//  rmpdbill
//
//  Created by Rodrigo Andrade on 9/21/19.
//  Copyright © 2019 Rodrigo Andrade. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *orgIDField;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)loginUser {
    
}

- (IBAction)didTapLogin:(id)sender {
    // static NSString *BASEURLString = @"https://app-sandbox.bill.com/api/v2";
    static NSString *devKey = @"01JFJIGOPULHADWJD201";
    
    static NSString *LOGINURLString = @"https://app-sandbox.bill.com/api/v2/Login.json";
    NSDictionary *dictParameters = @{@"userName": self.usernameField.text, @"password": self.passwordField.text, @"orgId": self.orgIDField.text, @"devKey": devKey};
    
    AFHTTPSessionManager *manager =  [AFHTTPSessionManager manager];
    [manager GET:LOGINURLString parameters:dictParameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (IBAction)didTapLoginView:(id)sender {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
