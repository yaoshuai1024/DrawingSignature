//
//  SigningDrawView.h
//  test
//
//  Created by yaoshuai on 2016/11/16.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

@interface SigningDrawView : GLKView

@property (assign, nonatomic) UIColor *strokeColor;

@property (assign, nonatomic) BOOL hasSignature;

@property (strong, nonatomic) UIImage *signatureImage;

- (void)erase;

@end
