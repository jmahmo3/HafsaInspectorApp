//
//  ViewController.h
//  IPDFCameraViewController
//
//  Created by Maximilian Mackh on 11/01/15.
//  Copyright (c) 2015 Maximilian Mackh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SaveImageDelegate <NSObject>

- (void)imageSaved:(UIImage *)image;

@end

@interface IPDFView : UIViewController
- (IPDFView *)create;
@property (nonatomic, weak) id <SaveImageDelegate> delegate;
@end

