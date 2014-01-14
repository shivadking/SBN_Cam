//
//  ViewController.m
//  photoShoot
//
//  Created by Thiruvengadam Krishnasamy on 14/12/13.
//  Copyright (c) 2013 TWILIGHT SOFTWARES. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCamera:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Capture from Camera/Gallery" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Camera", @"Gallery Library", @"Albums", nil];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    imagePicker.delegate = self;
    if(buttonIndex == 0)
    {
        [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
    }else if(buttonIndex == 1)
    {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] )
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Camera is not available" message:@"Your from stimulator" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }else if(buttonIndex == 2)
    {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Gallery is not available" message:@"Your from stimulator" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }else if(buttonIndex == 3)
    {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Album is not available" message:@"Your from stimulator" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        [_imgCamera setImage:[self imageWithImage:info[UIImagePickerControllerOriginalImage] scaledToSize:CGSizeMake(65, 65)]];
        
        [_imgBytes setText:[NSString stringWithFormat:@"%@",UIImagePNGRepresentation(_imgCamera.image)]];
    }];
}

-(UIImage *)imageWithImage:(UIImage *)imageToCompress scaledToSize:(CGSize)newSize {
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [imageToCompress drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    const CGFloat margin = 2.0f;
    CGSize size = CGSizeMake([newImage size].width + 2*margin, [newImage size].height + 2*margin);
    UIGraphicsBeginImageContext(size);
    
    [[UIColor whiteColor] setFill];
    [[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)] fill];
    
    CGRect rect = CGRectMake(margin, margin, size.width-2*margin, size.height-2*margin);
    [newImage drawInRect:rect blendMode:kCGBlendModeNormal alpha:1.0];
    
    UIImage *testImg =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return testImg;
}


- (IBAction)btnActionSheet:(UIButton*)sender {
    
    UIActionSheet *acsheet=[[UIActionSheet alloc]init];
    [acsheet addButtonWithTitle:@"Camera"];
    [acsheet addButtonWithTitle:@"Library"];
    [acsheet addButtonWithTitle:@"Album"];
    [acsheet addButtonWithTitle:@"Cancel"];
    [acsheet setDelegate:self];
    [acsheet showFromRect:sender.frame inView:self.view animated:YES];
}

- (IBAction)btnCustomCamera:(id)sender {
    
   /*UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    //hide old buttons
    picker.showsCameraControls = NO;
    
    UIView *overlay = [[UIView alloc] init];
    UIButton *newButton = [UIButton buttonWithType:UIButtonTypeCustom];
    newButton.frame = CGRectMake(20,40,70,40);
    [overlay addSubview:newButton];
    
    picker.cameraOverlayView = overlay;
    
    [self presentViewController:picker animated:YES completion:nil];*/
    
    
    //customCameraViewController *customCam = [self.storyboard instantiateViewControllerWithIdentifier:@"customCameraViewController"];
   // [self presentViewController:customCam animated:YES completion:nil];
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;

        //Create camera overlay
        CGRect f = imagePickerController.view.bounds;
        f.size.height -= imagePickerController.navigationBar.bounds.size.height;
        CGFloat barHeight = (f.size.height - f.size.width) / 2;
        UIGraphicsBeginImageContext(f.size);
        [[UIColor colorWithWhite:0 alpha:.5] set];
        UIRectFillUsingBlendMode(CGRectMake(0, 0, f.size.width, barHeight), kCGBlendModeNormal);
        UIRectFillUsingBlendMode(CGRectMake(0, f.size.height - barHeight, f.size.width, barHeight), kCGBlendModeNormal);
        UIImage *overlayImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        UIImageView *overlayIV = [[UIImageView alloc] initWithFrame:f];
        overlayIV.image = overlayImage;
        [imagePickerController.cameraOverlayView addSubview:overlayIV];
    
    UIView *overlay = [[UIView alloc] init];
    overlay.backgroundColor = [UIColor blueColor];
    UIButton *newButton = [UIButton buttonWithType:UIButtonTypeCustom];
    newButton.frame = CGRectMake(20,40,70,40);
    [overlay addSubview:newButton];
    
    [imagePickerController.cameraOverlayView addSubview:overlay];
    
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
    
    /*UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
   // imagePickerController.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeImage, nil];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    
    UIView *controllerView = imagePickerController.view;
    controllerView.alpha = 0.0;
    controllerView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    
    [[[[UIApplication sharedApplication] delegate] window] addSubview:controllerView];
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         controllerView.alpha = 1.0;
                     }
                     completion:nil
     ];*/
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    int sourceType=0;
    if(buttonIndex==0)
    {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] )
        {
            sourceType = UIImagePickerControllerSourceTypeCamera;
        }else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Camera is not available" message:@"Your from stimulator" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
    else if(buttonIndex==1)
    {
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Gallery is not available" message:@"Your from stimulator" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
    
    else if(buttonIndex==2)
    {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Album is not available" message:@"Your from stimulator" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }else if (buttonIndex == 3)
    {
        return;
    }
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.wantsFullScreenLayout = YES;
    picker.navigationBar.barStyle = UIBarStyleBlack; // Or whatever style.
    picker.sourceType = sourceType;
    
    [self presentViewController:picker animated:YES completion:nil];
    
    
    
}

@end
