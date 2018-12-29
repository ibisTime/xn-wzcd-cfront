//
//  APICodeMacro.h
//  YS_iOS
//
//  Created by 蔡卓越 on 2017/6/8.
//  Copyright © 2017年 caizhuoyue. All rights reserved.
//

#ifndef APICodeMacro_h
#define APICodeMacro_h


//研发
//#define APPURL @"http://120.26.6.213:2601/forward-service//api"
//测试
#define APPURL @"http://47.96.161.183:2601/forward-service//api"
//线上
//#define APPURL @"http://39.104.89.43:2601/forward-service/api/"

#define QINIUURL @"http://ounm8iw2d.bkt.clouddn.com/"

//验证码
#define CAPTCHA_CODE @"805950"
//用户
#define USER_REG_CODE @"805041"//注册
#define USER_LOGIN_CODE @"805050"//登录


// ====================   个人中心    ===================
#define VERIFICATION_CODE_CODE @"630090"//发送验证码
#define ModifyPhoneNumberURL @"805061"//修改手机号
#define ChangePasswordURL @"805063"//修改密码
#define TopUpPaymentPassword @"805067"//充值支付密码
#define ModifyTheNicknameURL @"805081"//修改昵称
#define ShippingAddressURL @"805165"//收货地址
#define AddShippingAddressURL @"805160"//新增收件地址
#define SetTheDefaultAddress @"805163"//设置默认收件地址
#define ModifyReceiverAddressURL @"805162"//修改收件地址
#define DeleteEceiptAddressURL @"805161"//删除收件地址
#define DetailsOfTheUserDataURL @"805121"//用户数据详情
#define AccountsCheckingListURL @"802503"//查询账户列表
#define WithdrawalURL @"802751"//取现
#define BankListURL @"802015"//银行列表
#define QueryChannelBankURL @"802116"//查询渠道银行
#define BindingOfBankCARDSURL @"802010"//绑定银行卡
#define ModifyBankCardURL @"802012"//修改银行卡
#define deleteBankCardURL @"802011"//删除银行卡
#define PlaceOrderImmediatelyURL @"808050"//立即下单
#define ConfirmTheGoodsURL @"808057"//确认收货
#define CancelTheOrderURL @"808053"//取消订单
#define TheOrderDetailsURL @"808066"//订单详情
#define TheOrderDetailsURL @"808066"//订单详情
#define MyNewsURL @"804040"//我的消息




// ====================    还款    =================
#define RepaymentPlanURL @"630540"//还款计划



// ====================   首页    ===================

#define PPURL @"630405"//品牌
#define CXURL @"630415"//车系
#define CXGLURL @"630425"//车型

#define RecommendedRangeURL @"630416"//推荐车系
#define RecommendedStagingURL @"808025"//推荐分期
#define VehicleManagementURL @"630425"//车型管理
#define VehicleInformationQueryURL @"630427"//车型详情查询
#define RecordURL @"802524"//我的查询流水
#define TheCalculatorURL @"630045"//计算器
#define ToApplyForCarLoanURL @"630430"//申请车贷
#define MyCarLoanApplicationURL @"630435"//我的车贷申请
#define GoodsDetailsURL @"808026"//商品详情
#define TheOrderURL @"808065"//订单分页查询



//根据ckey查询系统参数
#define USER_CKEY_CVALUE    @"805917"
//七牛图片上传
#define IMG_UPLOAD_CODE @"630091"
//用户信息
#define USER_INFO @"805121"
//AppKind
#define APP_KIND [TLUser user].kind

#endif /* APICodeMacro_h */
