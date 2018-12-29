

#import "ChooseView.h"
#define screen_Width [UIScreen mainScreen].bounds.size.width
#define screen_Height [UIScreen mainScreen].bounds.size.height
@interface ChooseView ()

//规格分类
@property(nonatomic,strong)NSArray *rankArr;

@end

@implementation ChooseView

@synthesize alphaView,whiteView,headImage,LB_detail,LB_line,LB_price,LB_stock,LB_showSales,mainscrollview,cancelBtn,addBtn,buyBtn,stockBtn;

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];

    if (self) {

        self.backgroundColor = [UIColor clearColor];

        self.showSales = @"135";
        [self creatUI];

    }
    return self;
}



-(void)creatUI{

    //半透明视图
//    alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height)];
//    alphaView.backgroundColor = [UIColor blackColor];
//    alphaView.alpha = 0.3;
//    [self addSubview:alphaView];

    //装载商品信息的视图
    whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 280, screen_Width, screen_Height - 280)];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.layer.shadowColor = [UIColor grayColor].CGColor;//阴影颜色
    whiteView.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
    whiteView.layer.shadowOpacity = 0.5;//不透明度
    whiteView.layer.shadowRadius = 10.0;//半径

    [self addSubview:whiteView];

    //商品图片
    headImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, -20, 130, 130)];
    headImage.layer.cornerRadius = 5;
    headImage.layer.borderColor = BackColor.CGColor;
    headImage.layer.borderWidth = 1;
    [headImage.layer setMasksToBounds:YES];
    [whiteView addSubview:headImage];

    cancelBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(screen_Width-40, 10, 25, 25);
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"close"] forState:0];
    [whiteView addSubview:cancelBtn];


    //商品价格
    LB_price = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame)+20, 10, 150, 20)];
    //    LB_price.text = @"¥100";
//    LB_price.textColor = PriceColor;
    LB_price.font = [UIFont systemFontOfSize:13];
    [whiteView addSubview:LB_price];
    //商品库存
    LB_stock = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame)+20, CGRectGetMaxY(LB_price.frame), 80, 20)];
    LB_stock.textColor = [UIColor blackColor];
    LB_stock.font = [UIFont systemFontOfSize:13];
    [whiteView addSubview:LB_stock];

    //已售件数
    LB_showSales = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(LB_stock.frame), CGRectGetMaxY(LB_price.frame), 80, 20)];
    LB_showSales.textColor = [UIColor blackColor];

    NSString *sellStr = [NSString stringWithFormat:@"已售 %@ 件",self.showSales];

    NSDictionary*subStrAttribute = @{
                                     NSForegroundColorAttributeName: [UIColor redColor],
                                     };
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:sellStr];
    [attributedText setAttributes:subStrAttribute range:NSMakeRange([sellStr rangeOfString:[self.showSales description]].location, [sellStr rangeOfString:[self.showSales description]].length)];
    //    [attributedText setAttributes:subStrAttribute range:NSMakeRange(3, 2)];
    //    LB_showSales.attributedText = attributedText;

    LB_showSales.font = [UIFont systemFontOfSize:13];
    [whiteView addSubview:LB_showSales];

    //用户所选择商品的尺码和颜色
    LB_detail = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame)+20, CGRectGetMaxY(LB_stock.frame) + 10, 150, 20)];
//    LB_detail.text = @"请选择 尺码 颜色分类";
//    LB_detail.numberOfLines = 0;
    LB_detail.textColor = PriceColor;
    LB_detail.font = [UIFont systemFontOfSize:16];
    [whiteView addSubview:LB_detail];
    
    //分界线
    LB_line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headImage.frame)+10, screen_Width, 0.5)];
    LB_line.backgroundColor = BackColor;
    [whiteView addSubview:LB_line];

    //加入购物车按钮
//    addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    addBtn.frame = CGRectMake(0, whiteView.frame.size.height-40 - 64, whiteView.frame.size.width/2, 40);
//
//    [addBtn setBackgroundColor:MainColor];
//    [addBtn setTitleColor:[UIColor whiteColor] forState:0];
//    addBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [addBtn setTitle:@"加入购物车" forState:0];
//    [whiteView addSubview:addBtn];

    _MonthlyPaymentsLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, whiteView.frame.size.height- 50 - kNavigationBarHeight, SCREEN_WIDTH - 120, 50)];
    _MonthlyPaymentsLabel.font = HGfont(14);
    
    [whiteView addSubview:_MonthlyPaymentsLabel];


    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, whiteView.frame.size.height-50- kNavigationBarHeight, screen_Width, 1)];
    lineView.backgroundColor = BackColor;
    [whiteView addSubview:lineView];

    //立即购买按钮
    buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.frame = CGRectMake(screen_Width - 100,  whiteView.frame.size.height-50- kNavigationBarHeight, 100, 50);
    [buyBtn setBackgroundColor:MainColor];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:0];
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [buyBtn setTitle:@"立即购买" forState:0];
    [whiteView addSubview:buyBtn];

    //库存不足按钮
    stockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    stockBtn.frame = CGRectMake(0,  whiteView.frame.size.width-40, screen_Width, 40);
    [stockBtn setBackgroundColor:[UIColor lightGrayColor]];
    [stockBtn setTitleColor:[UIColor blackColor] forState:0];
    stockBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [stockBtn setTitle:@"库存不足" forState:0];
    [whiteView addSubview:stockBtn];
    //默认隐藏
    stockBtn.hidden = YES;

    //有的商品尺码和颜色分类特别多 所以用UIScrollView 分类过多显示不全的时候可滑动查看
    mainscrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headImage.frame)+10, screen_Width, whiteView.frame.size.width-CGRectGetMaxY(headImage.frame) - 20 - kNavigationBarHeight)];
    mainscrollview.backgroundColor = [UIColor clearColor];
    mainscrollview.contentSize = CGSizeMake(0, 200);
    mainscrollview.showsHorizontalScrollIndicator = NO;
    mainscrollview.showsVerticalScrollIndicator = NO;
    [whiteView addSubview:mainscrollview];

}




@end








