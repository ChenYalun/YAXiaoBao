//
//  UIImage+YAVImage.h
//  XiaoBao
//
//  Created by 陈亚伦 on 2017/3/2.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YAVImage)

// 返回高斯模糊图片
+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

// 返回圆形图片
+(UIImage *)imageToRoundImageWithImage:(UIImage *)image;

// 以下来自系统
#pragma mark - Blur Image

/**
 *  Get blured image.
 *
 *  @return Blured image.
 */
- (UIImage *)blurImage;

/**
 *  Get the blured image masked by another image.
 *
 *  @param maskImage Image used for mask.
 *
 *  @return the Blured image.
 */
- (UIImage *)blurImageWithMask:(UIImage *)maskImage;

/**
 *  Get blured image and you can set the blur radius.
 *
 *  @param radius Blur radius.
 *
 *  @return Blured image.
 */
- (UIImage *)blurImageWithRadius:(CGFloat)radius;

/**
 *  Get blured image at specified frame.
 *
 *  @param frame The specified frame that you use to blur.
 *
 *  @return Blured image.
 */
- (UIImage *)blurImageAtFrame:(CGRect)frame;

#pragma mark - Grayscale Image

/**
 *  Get grayScale image.
 *
 *  @return GrayScaled image.
 */
- (UIImage *)grayScale;

#pragma mark - Some Useful Method

/**
 *  Scale image with fixed width.
 *
 *  @param width The fixed width you give.
 *
 *  @return Scaled image.
 */
- (UIImage *)scaleWithFixedWidth:(CGFloat)width;

/**
 *  Scale image with fixed height.
 *
 *  @param height The fixed height you give.
 *
 *  @return Scaled image.
 */
- (UIImage *)scaleWithFixedHeight:(CGFloat)height;

/**
 *  Get the image average color.
 *
 *  @return Average color from the image.
 */
- (UIColor *)averageColor;

/**
 *  Get cropped image at specified frame.
 *
 *  @param frame The specified frame that you use to crop.
 *
 *  @return Cropped image
 */
- (UIImage *)croppedImageAtFrame:(CGRect)frame;


@end
