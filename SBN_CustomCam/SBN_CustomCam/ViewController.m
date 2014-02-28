//
//  ViewController.m
//
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <ImageIO/CGImageProperties.h>
#import "imgController.h"

@interface ViewController ()

@end

@implementation ViewController
AVCaptureStillImageOutput *stillImageOutput;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        // Choosing bigger preset for bigger screen.
        //_sessionPreset = AVCaptureSessionPreset1280x720;
        session.sessionPreset = AVCaptureSessionPreset1280x720;
    }
    else
    {
        //_sessionPreset = AVCaptureSessionPresetHigh;
        session.sessionPreset = AVCaptureSessionPresetHigh;
    }
    
    CALayer *viewLayer = self.view.layer;
    NSLog(@"viewLayer = %@", viewLayer);
    
    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    
    CGRect frame = self.view.bounds;
    captureVideoPreviewLayer.frame = frame;
    captureVideoPreviewLayer.connection.videoOrientation = AVCaptureVideoOrientationLandscapeRight;
    [self.view.layer addSublayer:captureVideoPreviewLayer];
    NSLog(@"%f, %f",self.view.bounds.size.width,self.view.bounds.size.height);
    
    UIButton *overlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [overlayButton setFrame:CGRectMake(0, 0, 100, 30)];
    [overlayButton setTitle:@"Capture" forState:UIControlStateNormal];
    [overlayButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    overlayButton.frame = CGRectMake((self.view.frame.size.width/2) -(overlayButton.frame.size.width/2), self.view.frame.size.height - 50, overlayButton.frame.size.width, overlayButton.frame.size.height);
    [overlayButton addTarget:self action:@selector(btnCapture:) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:overlayButton];
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (!input) {
        // Handle the error appropriately.
        NSLog(@"ERROR: trying to open camera: %@", error);
    }
    [session addInput:input];
    
    stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [stillImageOutput setOutputSettings:outputSettings];
    [session addOutput:stillImageOutput];
    
    [session startRunning];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCapture:(id)sender {
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in stillImageOutput.connections)
    {
        for (AVCaptureInputPort *port in [connection inputPorts])
        {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] )
            {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection)
        {
            break;
        }
    }
    
    NSLog(@"about to request a capture from: %@", stillImageOutput);
    [stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error)
     {
         CFDictionaryRef exifAttachments = CMGetAttachment( imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
          if (exifAttachments)
          {
          // Do something with the attachments.
          NSLog(@"attachements: %@", exifAttachments);
          } else {
          NSLog(@"no attachments");
          }
         
         NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
         UIImage *image = [[UIImage alloc] initWithData:imageData];
         
         imgController *img = [self.storyboard instantiateViewControllerWithIdentifier:@"imgController"];
         [img setImgaes:image];
         [self presentViewController:img animated:YES completion:nil];
         
         //self.vImage.image = image;
         //NSLog(@"img => %@",UIImagePNGRepresentation(image));
         
         
         UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
     }];
}
@end
