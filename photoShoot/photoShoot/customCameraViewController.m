//
//  customCameraViewController.m
//  photoShoot
//
//  Created by Thiruvengadam Krishnasamy on 16/12/13.
//  Copyright (c) 2013 TWILIGHT SOFTWARES. All rights reserved.
//

#import "customCameraViewController.h"

@interface customCameraViewController ()

@end

@implementation customCameraViewController

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
	// Do any additional setup after loading the view.
    
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    imagePicker.delegate = self;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] )
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [_camView addSubview:imagePicker.view];
        
        //[self presentViewController:imagePicker animated:YES completion:nil];
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Camera is not available" message:@"Your from stimulator" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
