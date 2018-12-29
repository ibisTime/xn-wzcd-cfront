//
//  FaceToFaceSignVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/8/9.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "FaceToFaceSignVC.h"

@interface FaceToFaceSignVC ()

@property (nonatomic, strong) UIAlertController *alertCtrl;

@end

@implementation FaceToFaceSignVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"面签";
    [self detectAuthorizationStatus];

    [[ILiveRoomManager getInstance] enableCamera:CameraPosFront enable:YES succ:^{
        NSLog(@"打开摄像头成功");
    } failed:^(NSString *module, int errId, NSString *errMsg) {
        NSLog(@"打开摄像头失败");
    }];

    [[ILiveRoomManager getInstance] enableMic:YES succ:^{
        NSLog(@"打开麦克风成功");
    } failed:^(NSString *module, int errId, NSString *errMsg) {
        NSLog(@"打开麦克风失败");
    }];
}

#pragma mark - Accessor
- (UIAlertController *)alertCtrl {
    if (!_alertCtrl) {
        _alertCtrl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        }] ;
        [_alertCtrl addAction:action];
    }
    return _alertCtrl;
}

#pragma mark - Custom Method
// 检测音视频权限
- (void)detectAuthorizationStatus {
    // 检测是否有摄像头权限
    AVAuthorizationStatus statusVideo = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (statusVideo == AVAuthorizationStatusRestricted || statusVideo == AVAuthorizationStatusDenied) {
        self.alertCtrl.message = @"获取摄像头权限失败，请前往隐私-麦克风设置里面打开应用权限";
        [self presentViewController:self.alertCtrl animated:YES completion:nil];
        return;
    } else if (statusVideo == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {

        }];
    }

    // 检测是否有麦克风权限
    AVAuthorizationStatus statusAudio = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (statusAudio == AVAuthorizationStatusRestricted || statusAudio == AVAuthorizationStatusDenied) {
        self.alertCtrl.message = @"获取麦克风权限失败，请前往隐私-麦克风设置里面打开应用权限";
        [self presentViewController:self.alertCtrl animated:YES completion:nil];
        return;
    } else if (statusAudio == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {

        }];
    }
}

// 房间销毁时记得调用退出房间接口
- (void)dealloc {
    [[ILiveRoomManager getInstance] quitRoom:^{
        NSLog(@"退出房间成功");
    } failed:^(NSString *module, int errId, NSString *errMsg) {
        NSLog(@"退出房间失败 %d : %@", errId, errMsg);
    }];
}

// 上/下麦
//- (IBAction)upToVideo:(id)sender {
//    if ([[self.upVideoButton titleForState:UIControlStateNormal] isEqualToString:@"上麦"]) {
//        // 上麦，打开摄像头和麦克风

//
//        [self.upVideoButton setTitle:@"下麦" forState:UIControlStateNormal];
//    } else {
//        // 下麦，关闭摄像头和麦克风
//        [[ILiveRoomManager getInstance] enableCamera:CameraPosFront enable:NO succ:^{
//            NSLog(@"打开摄像头成功");
//        } failed:^(NSString *module, int errId, NSString *errMsg) {
//            NSLog(@"打开摄像头失败");
//        }];
//
//        [[ILiveRoomManager getInstance] enableMic:NO succ:^{
//            NSLog(@"打开麦克风成功");
//        } failed:^(NSString *module, int errId, NSString *errMsg) {
//            NSLog(@"打开麦克风失败");
//        }];
//
//        [self.upVideoButton setTitle:@"上麦" forState:UIControlStateNormal];
//    }
//}

#pragma mark - Custom Action

// 房间内上麦用户数量变化时调用，重新布局所有渲染视图，这里简单处理，从上到下等分布局
- (void)onCameraNumChange {
    // 获取当前所有渲染视图
    NSArray *allRenderViews = [[[ILiveRoomManager getInstance] getFrameDispatcher] getAllRenderViews];

    // 检测异常情况
    if (allRenderViews.count == 0) {
        return;
    }

    // 计算并设置每一个渲染视图的frame
    CGFloat renderViewHeight = (SCREEN_HEIGHT - kStatusBarHeight) / allRenderViews.count;
    CGFloat renderViewWidth = SCREEN_WIDTH;
    __block CGFloat renderViewY = 0.f;
    CGFloat renderViewX = 0.f;

    [allRenderViews enumerateObjectsUsingBlock:^(ILiveRenderView *renderView, NSUInteger idx, BOOL * _Nonnull stop) {
        renderViewY = renderViewY + renderViewHeight * idx;
        CGRect frame = CGRectMake(renderViewX, renderViewY, renderViewWidth, renderViewHeight);
        renderView.frame = frame;
    }];
}

#pragma mark - ILiveMemStatusListener
// 音视频事件回调
- (BOOL)onEndpointsUpdateInfo:(QAVUpdateEvent)event updateList:(NSArray *)endpoints {
    if (endpoints.count <= 0) {
        return NO;
    }
    for (QAVEndpoint *endpoint in endpoints) {
        switch (event) {
            case QAV_EVENT_ID_ENDPOINT_HAS_CAMERA_VIDEO:
            {
                /*
                 创建并添加渲染视图，传入userID和渲染画面类型，这里传入 QAVVIDEO_SRC_TYPE_CAMERA（摄像头画面）,
                 */
                ILiveFrameDispatcher *frameDispatcher = [[ILiveRoomManager getInstance] getFrameDispatcher];
                ILiveRenderView *renderView = [frameDispatcher addRenderAt:CGRectZero forIdentifier:endpoint.identifier srcType:QAVVIDEO_SRC_TYPE_CAMERA];
                [self.view addSubview:renderView];
                [self.view sendSubviewToBack:renderView];
                // 房间内上麦用户数量变化，重新布局渲染视图
                [self onCameraNumChange];
            }
                break;
            case QAV_EVENT_ID_ENDPOINT_NO_CAMERA_VIDEO:
            {
                // 移除渲染视图
                ILiveFrameDispatcher *frameDispatcher = [[ILiveRoomManager getInstance] getFrameDispatcher];
                ILiveRenderView *renderView = [frameDispatcher removeRenderViewFor:endpoint.identifier srcType:QAVVIDEO_SRC_TYPE_CAMERA];
                [renderView removeFromSuperview];
                // 房间内上麦用户数量变化，重新布局渲染视图
                [self onCameraNumChange];
            }
                break;
            default:
                break;
        }
    }
    return YES;
}

#pragma mark - ILiveRoomDisconnectListener
/**
 SDK主动退出房间提示。该回调方法表示SDK内部主动退出了房间。SDK内部会因为30s心跳包超时等原因主动退出房间，APP需要监听此退出房间事件并对该事件进行相应处理

 @param reason 退出房间的原因，具体值见返回码

 @return YES 执行成功
 */
- (BOOL)onRoomDisconnect:(int)reason {
    NSLog(@"房间异常退出：%d", reason);
    return YES;
}

@end
