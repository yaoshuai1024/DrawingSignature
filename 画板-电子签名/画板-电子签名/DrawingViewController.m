//
//  DrawingViewController.m
//  画板-电子签名
//
//  Created by yaoshuai on 2016/11/16.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "DrawingViewController.h"
#import "DrawingBoardView.h"
#import "ChooseImageViewController.h"

@interface DrawingViewController ()

@property (weak, nonatomic) IBOutlet DrawingBoardView *drawingView;

@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (strong,nonatomic) UIImage *drawedImage;

@end

@implementation DrawingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _drawingView.lineWidth = _slider.value;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotiAndThenDissmiss) name:@"signatureImageNotification" object:nil];
}

- (IBAction)lineWidthChanged:(UISlider *)sender {
    _drawingView.lineWidth = sender.value;
}

- (IBAction)colorChanged:(UIButton *)sender {
    _drawingView.color = sender.backgroundColor;
}

- (IBAction)submitAction:(id)sender {
    UIGraphicsBeginImageContextWithOptions(_drawingView.bounds.size, NO, 0.0);
    
    [_drawingView drawViewHierarchyInRect:_drawingView.bounds afterScreenUpdates:YES];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    _drawedImage = img;
    
    // 写入相册
    // UIImageWriteToSavedPhotosAlbum(img, nil, NSURLIsDirectoryKey, nil);
    
    [self performSegueWithIdentifier:@"choose" sender:nil];
}

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)afreshAction:(id)sender {
    [_drawingView afreshView];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ChooseImageViewController *chooseVC = (ChooseImageViewController *)[segue destinationViewController];
    chooseVC.image = _drawedImage;
}

#pragma mark - 接收到通知(图片选择后)，消失
- (void)receiveNotiAndThenDissmiss{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    });
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
