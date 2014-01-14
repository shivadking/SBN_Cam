//
//  ViewController.h
//  photoShoot
//
//  Created by Thiruvengadam Krishnasamy on 14/12/13.
//  Copyright (c) 2013 TWILIGHT SOFTWARES. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate,UIActionSheetDelegate>

- (IBAction)btnCamera:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imgCamera;
@property (strong, nonatomic) IBOutlet UITextView *imgBytes;
- (IBAction)btnActionSheet:(id)sender;

- (IBAction)btnCustomCamera:(id)sender;

@end
