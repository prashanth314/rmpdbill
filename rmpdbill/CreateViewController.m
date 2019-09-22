//
//  CreateViewController.m
//  rmpdbill
//
//  Created by Rodrigo Andrade on 9/21/19.
//  Copyright © 2019 Rodrigo Andrade. All rights reserved.
//

#import "CreateViewController.h"
#import "ZXingObjC.h"
#import "RecieverViewController.h"

@interface CreateViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIImageView *codeQR;
@property (strong, nonatomic) UIImage *encodedImage;
@end

@implementation CreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)didTapGenerateQRCode:(id)sender {
    NSString *customerInfo = [NSString stringWithFormat:@"%@, %@, %@", self.nameTextField.text, self.emailTextField, self.phoneTextField];
    
    NSError *error = nil;
    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
    ZXBitMatrix* result = [writer encode:[NSString stringWithFormat:@"%@", customerInfo]
                                  format:kBarcodeFormatQRCode
                                   width:700
                                  height:700
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
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (IBAction)didTapLogout:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    self.encodedImage = info[UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self performSegueWithIdentifier:@"recieverSegue" sender:nil];
}
- (IBAction)didTapCreateView:(id)sender {
    [self.view endEditing:YES];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"recieverSegue"]){
        RecieverViewController *recieverController = [segue destinationViewController];
        recieverController.imageToDecode = self.encodedImage;
    };
}


@end
