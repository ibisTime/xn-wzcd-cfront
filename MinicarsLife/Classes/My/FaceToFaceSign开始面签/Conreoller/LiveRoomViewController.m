//
//  LiveRoomViewController.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/7.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "LiveRoomViewController.h"

@interface LiveRoomViewController ()
@property (nonatomic, strong) UIAlertController *alertCtrl;     //!< 提示框
@end

@implementation LiveRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"直播间";
    // 检测音视频权限
    [self detectAuthorizationStatus];
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


// 房间销毁时记得调用退出房间接口
- (void)dealloc {
    [[ILiveRoomManager getInstance] quitRoom:^{
        NSLog(@"退出房间成功");
    } failed:^(NSString *module, int errId, NSString *errMsg) {
        NSLog(@"退出房间失败 %d : %@", errId, errMsg);
    }];
}

#pragma mark - ILiveMemStatusListener
- (BOOL)onEndpointsUpdateInfo:(QAVUpdateEvent)event updateList:(NSArray *)endpoints {
    switch (event) {
        case QAV_EVENT_ID_ENDPOINT_HAS_CAMERA_VIDEO:
        {
            /*
             创建并添加渲染视图，传入userID和渲染画面类型，这里传入 QAVVIDEO_SRC_TYPE_CAMERA（摄像头画面）
             */
            ILiveFrameDispatcher *frameDispatcher = [[ILiveRoomManager getInstance] getFrameDispatcher];
            ILiveRenderView *renderView = [frameDispatcher addRenderAt:self.view.bounds forIdentifier:[endpoints.firstObject identifier] srcType:QAVVIDEO_SRC_TYPE_CAMERA];
            [self.view addSubview:renderView];
        }
            break;
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
