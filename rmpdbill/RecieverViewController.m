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
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation RecieverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.registerButton.layer.cornerRadius = 5;
    self.registerButton.clipsToBounds = YES;
    [self setupTextFields];
    
}

- (void)setupTextFields{
    
    ZXLuminanceSource *source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:[self.imageToDecode CGImage]];
    ZXBinaryBitmap *bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
    
    NSError *error = nil;
    
    // There are a number of hints we can give to the reader, including
    // possible formats, allowed lengths, and the string encoding.
    ZXDecodeHints *hints = [ZXDecodeHints hints];
    
    ZXMultiFormatReader *reader = [ZXMultiFormatReader reader];
    ZXResult *result = [reader decode:bitmap
                                hints:hints
                                error:&error];
    if (result) {
        // The coded result as a string. The raw data can be accessed with
        // result.rawBytes and result.length.
        NSString *contents = result.text;
        
        NSString *display = [NSString stringWithFormat:@"%@", contents];
        
        NSArray *infoArray = [display componentsSeparatedByString:@";"];
        NSLog(@"Info Array is %@", infoArray);
        
        self.nameTextField.text = [infoArray[0] componentsSeparatedByString:@","][0];
        self.emailTextField.text = [infoArray[3] componentsSeparatedByString:@"'"][1];
        self.phoneTextField.text = [infoArray[10] componentsSeparatedByString:@"'"][1];
        
        // After recieving the needed information from the QR Code an API request could be made to then register new relation
        
    } else {
        // Use error to determine why we didn't get a result, such as a barcode
        // not being found, an invalid checksum, or a format inconsistency.
    }
}

- (IBAction)didTapRecieverView:(id)sender {
    [self.view endEditing:YES];
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
