//
//  TLNetworking.m
//  WeRide
//
//  Created by  蔡卓越 on 2016/11/28.
//  Copyright © 2016年 trek. All rights reserved.
//

#import "TLNetworking.h"
//Manager
//#import "AppConfig.h"
//#import "TLUser.h"
//Category
#import "TLProgressHUD.h"
#import "TLAlert.h"
#import "HttpLogger.h"
//#import "UIViewController+Extension.h"
//Extension
#import "SVProgressHUD.h"
//C
#import "BaseViewController.h"

//121.43.101.148:5703/cd-qlqq-front

@interface TLNetworking()

@property (nonatomic, strong) BaseViewController *baseVC;

@end

@implementation TLNetworking

- (BaseViewController *)baseVC {
    
    if (!_baseVC) {
        
//        _baseVC = [[BaseViewController alloc] getCurrentVC];
    }
    return _baseVC;
}

+ (AFHTTPSessionManager *)HTTPSessionManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer.timeoutInterval = 15.0;
    //去除返回的null的value
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
    manager.responseSerializer = response;
    
    NSSet *set = manager.responseSerializer.acceptableContentTypes;
    
    set = [set setByAddingObject:@"text/plain"];
    set = [set setByAddingObject:@"text/html"];
//    set = [set setByAddingObject:@"text/html"];

    manager.responseSerializer.acceptableContentTypes = set;
    
    return manager;
}

//+ (NSString *)serveUrl {
//
////    return [[self baseUrl] stringByAppendingString:@"/forward-service/api"];
//}
//
//+ (NSString *)ipUrl {
//
//    return [[self baseUrl] stringByAppendingString:@"/forward-service/ip"];
//
//}


//+ (NSString *)baseUrl {
//
////    return [AppConfig config].addr;
//
//}
//
//
//+ (NSString *)systemCode {
//
//    return [AppConfig config].systemCode;
//
//}
//
//+ (NSString *)companyCode {
//
//    return [AppConfig config].companyCode;
//}

- (instancetype)init{

    if(self = [super init]){
    
       _manager = [[self class] HTTPSessionManager];
        _isShowMsg = YES;
        self.parameters = [NSMutableDictionary dictionary];
        
    }
    return self;

}


- (NSURLSessionDataTask *)postWithSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //如果想要设置其它 请求头信息 直接设置 HTTPSessionManager 的 requestSerializer 就可以了，不用直接设置 NSURLRequest
    
    if(self.showView){
    
        [TLProgressHUD show];
    }
    if (self.isShowMsg) {
        [TLProgressHUD dismiss];
    }
    
    if(self.code && self.code.length > 0){
    
//        if (!(self.url && self.url.length > 0)) {

//            self.url = [[self class] serveUrl];
//        }

        if (![_isShow isEqualToString:@"100"]) {
            
//            self.parameters[@"systemCode"] = [[self class] systemCode];
        }
        
//        if ([TLUser user].token) {
//
//            self.parameters[@"token"] = [TLUser user].token;
//        }
//
//        self.parameters[@"companyCode"] = [[self class] companyCode];


    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:self.parameters options:NSJSONWritingPrettyPrinted error:nil];
    self.parameters = [NSMutableDictionary dictionaryWithCapacity:2];


    self.parameters[@"companyCode"] = @"CD-HTWT000020";
    self.parameters[@"systemCode"] = @"CD-HTWT000020";
    self.parameters[@"json"] = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    self.parameters[@"code"] = self.code;
//    if (!self.url || !self.url.length) {
//        NSLog(@"url 不存在啊");
////        if (hud || self.showView) {
////            [hud hideAnimated:YES];
////        }
//        return nil;
//    }
//
    WGLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    WGLog(@"%@",self.parameters);
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:APPURL]];
//    [HttpLogger logDebugInfoWithRequest:request apiName:self.code requestParams:self.parameters httpMethod:@"POST"];

    return [self.manager POST:APPURL parameters:self.parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      
      [HttpLogger logDebugInfoWithResponse:task.response apiName:self.code resposeString:responseObject request:task.originalRequest error:nil];

      //打印JSON字符串
      [HttpLogger logJSONStringWithResponseObject:responseObject];

      if(self.showView){
          
          [TLProgressHUD dismiss];
      }
      
      if([responseObject[@"errorCode"] isEqual:@"0"]){ //成功
          
          if(success) {
              
              //在主线程中加载UI
              dispatch_async(dispatch_get_main_queue(), ^{
                  
                  if (self.baseVC) {
                      if ([self.baseVC isKindOfClass:[BaseViewController class]]) {
//                          [self.baseVC removePlaceholderView];

                      }
                  }
              });
              
              success(responseObject);
          }
          
      } else {
          
          if (failure) {
              
              failure(nil);
          }
          
          if ([responseObject[@"errorCode"] isEqual:@"4"]) {
              //token错误  4
              
              [TLAlert alertWithTitle:@"提示" message:@"为了您的账户安全,请重新登录" confirmAction:^{
                  LoginViewController *vc = [[LoginViewController alloc]init];
                  UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//                  vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//                  vc.modalPresentationStyle = UIModalTransitionStyleFlipHorizontal;
                  vc.state = @"100";
                  UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
                  [rootViewController presentViewController:nav animated:YES completion:nil];
              }];
              return;
          }
          
          if(self.isShowMsg) { //异常也是失败
              
              [TLAlert alertWithInfo:responseObject[@"errorInfo"]];

          }
      }
      
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
       if(self.showView) {
           
           [TLProgressHUD dismiss];
       }
       
       if (self.isShowMsg) {

           [TLAlert alertWithInfo:@"网络异常"];
       }

       if(failure) {
           //在主线程中加载UI
           dispatch_async(dispatch_get_main_queue(), ^{
               
               if (self.baseVC) {
                   
//                   [self.baseVC addPlaceholderView];
               }
           });
        
           failure(error);
       }
       
   }];

}

- (void)hundleSuccess:(id)responseObj {

    if([responseObj[@"success"] isEqual:@1]){
    
        
    }
}


+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
                       success:(void (^)(id responseObject))success
                       failure: (void (^)(NSError *error))failure{
    
    AFHTTPSessionManager *manager = [self HTTPSessionManager];
    
    return [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            
            success(responseObject);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(failure){
            
            failure(error);
            
        }
        
    }];


}

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                       parameters:(NSDictionary *)parameters
                          success:(void (^)(id responseObject))success
                      abnormality:(void (^)(NSString *msg))abnormality
                          failure:(void (^)(NSError * _Nullable  error))failure;
{
    //先检查网络
    
    AFHTTPSessionManager *manager = [self HTTPSessionManager];
    
    return [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(failure){
            failure(error);
        }
        
    }];
    
}


//#pragma mark - GET
+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                         success:(void (^)(NSString *msg,id data))success
                     abnormality:(void (^)())abnormality
                         failure:(void (^)(NSError *error))failure;
{
    AFHTTPSessionManager *manager = [self HTTPSessionManager];
    
    
    return [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(@"",responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
    
    
}



@end
