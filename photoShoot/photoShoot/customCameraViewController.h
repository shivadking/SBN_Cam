//
//  customCameraViewController.h
//  photoShoot
//
//  Created by Thiruvengadam Krishnasamy on 16/12/13.
//  Copyright (c) 2013 TWILIGHT SOFTWARES. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customCameraViewController : UIViewController<UIImagePickerControllerDelegate>
- (IBAction)btnBack:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *camView;

@end
