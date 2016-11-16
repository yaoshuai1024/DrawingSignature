//
//  ChooseImageViewController.m
//  画板-电子签名
//
//  Created by yaoshuai on 2016/11/16.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "ChooseImageViewController.h"

@interface ChooseImageViewController ()<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *maskView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property(assign,nonatomic) CGRect rect;

@end

@implementation ChooseImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _rect = _imageView.bounds;
    
    [self addMask];
    
    _imageView.image = _image;
    _imageView.userInteractionEnabled = YES;
    
    UIPinchGestureRecognizer *recognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    recognizer.delegate = self;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    panGesture.delegate = self;
    [self.imageView addGestureRecognizer:panGesture];
    
    [_imageView addGestureRecognizer:recognizer];
}

/**
 添加罩层
 */
- (void)addMask{
    CGRect rect = _imageView.frame;
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    
    layer.path = path.CGPath;
    
    _maskView.layer.mask = layer;
}

- (void)pinch:(UIPinchGestureRecognizer *)recognizer{
    CGFloat scale = recognizer.scale;
    self.imageView.transform = CGAffineTransformScale(_imageView.transform, scale, scale);
    recognizer.scale = 1.0f;
}
- (void)panAction:(UIPanGestureRecognizer *)panGesture
{
    CGPoint translation = [panGesture translationInView:self.imageView];
    _imageView.transform = CGAffineTransformTranslate(_imageView.transform, translation.x, translation.y);
    [panGesture setTranslation:CGPointZero inView:panGesture.view];
}

- (IBAction)submitAction:(id)sender {
    UIGraphicsBeginImageContextWithOptions(_imageView.bounds.size, NO, 0.0);
    
    [_maskView drawViewHierarchyInRect:_rect afterScreenUpdates:NO];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    NSDictionary *dict = @{@"image":img};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"signatureImageNotification" object:self userInfo:dict];
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
