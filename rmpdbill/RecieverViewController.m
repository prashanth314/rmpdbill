//
//  RecieverViewController.m
//  rmpdbill
//
//  Created by Rodrigo Andrade on 9/21/19.
//  Copyright © 2019 Rodrigo Andrade. All rights reserved.
//

#import "RecieverViewController.h"
#import "AFNetworking.h"
#import "ZXingObjC.h"

@interface RecieverViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *testQR;

@end

@implementation RecieverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.testQR setImage:self.imageToDecode];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
