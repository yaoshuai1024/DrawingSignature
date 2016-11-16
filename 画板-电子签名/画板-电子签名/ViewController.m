//
//  ViewController.m
//  画板-电子签名
//
//  Created by yaoshuai on 2016/11/16.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "ViewController.h"
#import "DrawingViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *signatureImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveImageAndShow:) name:@"signatureImageNotification" object:nil];
}

- (IBAction)signature:(id)sender {
    [self performSegueWithIdentifier:@"signature" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
}

#pragma mark - 选择图片后，展示
- (void)receiveImageAndShow:(NSNotification *)notification{
    NSDictionary *dict = notification.userInfo;
    UIImage *image = (UIImage *)dict[@"image"];
    _signatureImage.image = image;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
