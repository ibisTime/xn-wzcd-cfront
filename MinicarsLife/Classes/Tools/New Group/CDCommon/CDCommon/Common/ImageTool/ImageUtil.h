//
//  ImageUtil.h
//  CustomB
//
//  Created by  tianlei on 2017/9/6.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageUtil : NSObject

/**
 把颜色转换为 1px X 1px的图片
 */
+ (UIImage * )convertColorToImage:(UIColor *)color;

/**
 获取以下格式，图片名还的尺寸，方便图文混排
 iOS_图片宽_图片高_时间戳.(jpg|jpeg:png),不符合这种命名规则的返回 CGSizeMake(4,3)
 */
+ (CGSize)imageSizeByImageName:(NSString *)imageName;


/**
 根据图片本身属性对图片进行命名
 iOS_图片宽_图片高_时间戳.(jpg|jpeg:png)
 */
+ (NSString *)imageNameByImage:(UIImage *)img;


/**
 对0.5M以上的非长图，进行简单压缩
 */
+ (void)zipImageWithImage:(UIImage *)image begin:(void(^)())beginHandler end:(void(^)(UIImage *))endHandler;



/**
 七牛图片服务器，获得原图Url
 eg: imageUrl = iOS_w_h_timestamp.jpg
     ServerUrl =  http://opf6b9y6y.bkt.clouddn.com
 url =  http://opf6b9y6y.bkt.clouddn.com/iOS_w_h_timestamp.jpg?imageMogr2/auto-orient/strip
 */
+ (NSString *)convertImageUrl:(NSString *)imageUrl imageServerUrl:(NSString *)ServerUrl;

@end
