//
//  CreateViewController.m
//  rmpdbill
//
//  Created by Rodrigo Andrade on 9/21/19.
//  Copyright © 2019 Rodrigo Andrade. All rights reserved.
//

#import "CreateViewController.h"
#import "ZXingObjC.h"

@interface CreateViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIImageView *codeQR;

@end

@implementation CreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)didTapGenerateQRCode:(id)sender {
    NSDictionary *customerInfo = @{@"name": self.nameTextField.text, @"email": self.emailTextField.text, @"phone": self.phoneTextField.text};
    
    NSError *error = nil;
    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
    ZXBitMatrix* result = [writer encode:[NSString stringWithFormat:@"%@", customerInfo]
                                  format:kBarcodeFormatQRCode
                                   width:500
                                  height:500
                                   error:&error];
    if (result) {
        CGImageRef imageRef = CGImageRetain([[ZXImage imageWithMatrix:result] cgimage]);
        UIImage* uiImage = [[UIImage alloc] initWithCGImage:imageRef];
        [self.codeQR setImage:uiImage];
        
        CGImageRelease(imageRef);
    } else {
        NSString *errorMessage = [error localizedDescription];
        NSLog(@"%@", errorMessage);
    }
}

- (IBAction)didTapScanner:(id)sender {
}

- (IBAction)didTapLogout:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
