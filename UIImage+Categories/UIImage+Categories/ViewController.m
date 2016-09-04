//
//  ViewController.m
//  UIImage+Categories
//
//  Created by lisong on 16/9/4.
//  Copyright © 2016年 lisong. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Color.h"
#import "UIImage+Rotate.h"
#import "UIImage+SubImage.h"
#import "UIImage+Gif.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (strong, nonatomic) UIImage *image;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.image = [UIImage imageNamed:@"image"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.imageView addGestureRecognizer:tap];
    
    self.imageView.image = self.image;
    
//    self.imageView.image = [UIImage imageWithColor:[UIColor redColor]];
}

- (void)handleTap:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:tap.view];
    
    UIImage *image = self.imageView.image;
    
    CGPoint pointInImage = CGPointMake(point.x * image.size.width / self.imageView.frame.size.width, point.y * image.size.height / self.imageView.frame.size.height);
    
    self.bottomView.backgroundColor = [image colorAtPixel:pointInImage];
}

- (IBAction)rotateRight:(UIButton *)sender
{
    self.imageView.image = [self.imageView.image rotate:UIImageOrientationRight];
}

- (IBAction)flipVertical:(UIButton *)sender
{
    self.imageView.image = [self.imageView.image flipVertical];
}

- (IBAction)flipHorizontal:(UIButton *)sender
{
    self.imageView.image = [self.imageView.image flipHorizontal];
}

- (IBAction)subImage:(UIButton *)sender
{
    UIImage *image = self.imageView.image;
    self.imageView.image = [image subImageWithRect:CGRectMake(0, 0, image.size.width, image.size.height / 2)];
}

- (IBAction)imageFromView:(UIButton *)sender
{
    self.imageView.image = [UIImage imageFromView:self.view];
}

- (IBAction)convertToGray:(UIButton *)sender
{
    self.imageView.image = [self.imageView.image convertToGrayImage];
}

- (IBAction)tileImage:(UIButton *)sender
{
    UIImage *image = self.imageView.image;
    self.imageView.image = [self.imageView.image getTiledImageWithSize:CGSizeMake(image.size.width * 4, image.size.width * 4)];
}

- (IBAction)gifImage:(UIButton *)sender
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"gif" ofType:@"gif"];
    self.imageView.image = [UIImage animatedImageWithAnimatedGIFURL:[NSURL fileURLWithPath:path]];
    self.imageView.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfFile:path]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
