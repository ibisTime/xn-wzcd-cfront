//
//  ImageUtil.m
//  CustomB
//
//  Created by  tianlei on 2017/9/6.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "ImageUtil.h"

@implementation ImageUtil

+ (UIImage * )convertColorToImage:(UIColor *)color {
    if (!color) {
        return nil;
    }
    
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (CGSize)imageSizeByImageName:(NSString *)imageName {
    
    if ([imageName hasPrefix:@"http"]) {
        
        return CGSizeMake(4,3);
        
    } else {
        
        if ([imageName hasSuffix:@".jpg"] || [imageName hasSuffix:@".png"]) {
            
            NSString *urlName = [imageName substringWithRange:NSMakeRange(0, imageName.length - 4)];
            NSArray *arr = [urlName componentsSeparatedByString:@"_"];
            
            if (arr.count > 2) {
                
                CGFloat h = [arr[arr.count - 1] floatValue];
                CGFloat w = [arr[arr.count - 2] floatValue];
                return CGSizeMake(w, h);
            } else {
                
                return CGSizeMake(4, 3);
                
            }
            
        } else if ([imageName hasSuffix:@".jpeg"]) {
            
            NSString *urlName = [imageName substringWithRange:NSMakeRange(0, imageName.length - 5)];
            NSArray *arr = [urlName componentsSeparatedByString:@"_"];
            
            if (arr.count > 2) {
                
                CGFloat h = [arr[arr.count - 1] floatValue];
                CGFloat w = [arr[arr.count - 2] floatValue];
                return CGSizeMake(w, h);
            } else {
                
                return CGSizeMake(4, 3);
                
            }
            
        } else {
            
            return CGSizeMake(4, 3);
        }
        
    }
    
}


+ (NSString *)imageNameByImage:(UIImage *)img{
    CGSize imgSize = img.size;//
    
    NSDate *now = [NSDate date];
    NSString *timestamp = [NSString stringWithFormat:@"%f",now.timeIntervalSince1970];
    timestamp = [timestamp stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    NSString *imageName = [NSString stringWithFormat:@"iOS_%@_%.0f_%.0f.jpg",timestamp,imgSize.width,imgSize.height];
    
    return imageName;
    
}

+ (void)zipImageWithImage:(UIImage *)image begin:(void(^)())beginHandler end:(void(^)(UIImage *))endHandler {
    
    if (beginHandler) {
        beginHandler();
    }
    
    UIImage *oldImg = image;
    
    
    if (!oldImg) {
        endHandler(nil);
        return;
    }
    
    
    CGFloat H_W = oldImg.size.height/oldImg.size.width;
    if (H_W < 0.3333 || UIImageJPEGRepresentation(oldImg, 1).length < 0.5*1024*1024 ) {
        //宽图，暂不压缩
        //小于0.5M,暂不压缩
        
        if (endHandler) {
            endHandler(oldImg);
            return;
        }
        
    }
    
    //image 中size为point 但是这决定于 image的scale属性，scale == 1时 image pt == px
    CGFloat zeroW_PX = 1080;
    
    // 2X  1point = 4px;
    // 3X  1point = 9px;
    CGFloat imgScale = oldImg.scale;
    
    //正常图片
    //长图 H_W > 3.0
    CGFloat animationW = zeroW_PX/imgScale;
    
    if (oldImg.size.width <= animationW) {
        
        if (endHandler) {
            endHandler(oldImg);
            return;
        }
        
    }
    
    CGFloat zipScale = oldImg.size.width/animationW;
    CGSize targetSize = CGSizeMake(animationW, oldImg.size.height/zipScale);
    
    
    //*****1.图片缩操作，减小像素数，和尺寸*******//
    //开画布
    UIGraphicsBeginImageContext(targetSize);
    
    [oldImg drawInRect:CGRectMake(0, 0, targetSize.width,targetSize.height)];
    //新图片
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭画布
    UIGraphicsEndImageContext();
    
    //*****2.图片压操作*******//
    UIImage *lastImg = [UIImage imageWithData:UIImageJPEGRepresentation(newImg, 0.7)];
    
    if (endHandler) {
        endHandler(lastImg);
    }
}

//- (NSString *)convertThumbnailImageUrl{
//    //  限定长边，生成不超过 300x300 的缩略图
//    if ([self hasPrefix:@"http"] || [self hasPrefix:@"https"]) {
//        
//        return self;
//        
//    } else {
//        
//        return [NSString stringWithFormat:@"%@/%@?imageMogr2/auto-orient/strip/thumbnail/300x300/quality/50!",[AppConfig config].qiniuDomain,self];
//        
//    }
//    
//}

+ (NSString *)convertImageUrl:(NSString *)imageUrl imageServerUrl:(NSString *)ServerUrl {
    
    //auto-orient 根据原信息 旋转
    //strip 取出图片原信息
    if (!imageUrl) {
        return nil;
    }
    
    if ([imageUrl hasPrefix:@"http"] || [imageUrl hasPrefix:@"https"]) {
        
        return imageUrl;
        
    } else {
//        return [[NSString stringWithFormat:@"%@/%@?imageMogr2/auto-orient/strip",ServerUrl,imageUrl] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     return [[NSString stringWithFormat:@"%@/%@?imageMogr2/auto-orient/strip",ServerUrl,imageUrl] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    }
    
}


@end
