//
//  FrameTableViewController.m
//  MJTableViewController
//
//  Created by 高扬 on 2018/3/25.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "FrameTableViewController.h"
#import "DishesModel.h"
#import "FrameDishesViewCell.h"
#import "WebViewController.h"

@interface FrameTableViewController ()

@property(nonatomic,retain)UIView* noticeBack;
@property(nonatomic,retain)UILabel* noticeLabel;
@property(nonatomic,retain)UILabel* noticeIcon;

@property(nonatomic,retain)UIButton* submitButton;

@property(nonatomic,retain)NSArray<DishesModel*>* dishesModels;

@end

@implementation FrameTableViewController


-(NSArray<DishesModel *> *)dishesModels{
    if (!_dishesModels) {
        _dishesModels = @[
                          [DishesModel initWithParams:@"苹果iphone X" iconName:@"https://img13.360buyimg.com/n7/jfs/t10675/253/1344769770/66891/92d54ca4/59df2e7fN86c99a27.jpg" des:@"亮黑色 64G 移动网络" price:@"9999" linkUrl:@"https://item.jd.com/5089253.html"],
                          
                          [DishesModel initWithParams:@"苹果iphone 8Plus" iconName:@"https://img10.360buyimg.com/n7/jfs/t9313/81/1352027902/75682/4abc569f/59b85834Ne59b864d.jpg" des:@"金色 64G 电信网络" price:@"7999" linkUrl:@"https://item.jd.com/5089255.html"],
                          
                          [DishesModel initWithParams:@"苹果iphone 8" iconName:@"https://img10.360buyimg.com/n7/jfs/t9085/22/907696059/71305/93f88c62/59b85847N20776d8e.jpg" des:@"玫瑰金 64G 联通网络" price:@"6999" linkUrl:@"https://item.jd.com/5089225.html"],
                          
                          [DishesModel initWithParams:@"苹果iphone 7Plus" iconName:@"https://img10.360buyimg.com/n7/jfs/t3250/72/1629247361/133742/e0c6726d/57d11c72N093250ec.jpg" des:@"银白色 32G 铁通网络" price:@"4999" linkUrl:@"https://item.jd.com/3133853.html"],
                          
                          
                          
                          ];
    }
    return _dishesModels;
}

-(UIView*)noticeBack{
    if (!_noticeBack) {
        _noticeBack = [[UIView alloc]init];
        _noticeBack.backgroundColor = COLOR_NOTICE_BACK;
        [self.view addSubview:_noticeBack];
    }
    return _noticeBack;
}

-(UILabel *)noticeIcon{
    if (!_noticeIcon) {
        _noticeIcon = [UICreationUtils createLabel:ICON_FONT_NAME size:16 color:[UIColor whiteColor] text:ICON_GONG_GAO sizeToFit:YES superView:self.noticeBack];
    }
    return _noticeIcon;
}

-(UILabel *)noticeLabel{
    if (!_noticeLabel) {
        _noticeLabel = [UICreationUtils createLabel:SIZE_TEXT_SECONDARY color:[UIColor whiteColor] text:@"春季数码产品新款上市，全场3折，预购从速" sizeToFit:YES superView:self.noticeBack];
    }
    return _noticeLabel;
}

-(UIButton *)submitButton{
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _submitButton.backgroundColor = COLOR_RIMARY_DISHES;
        [_submitButton setTitle:@"结   算" forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:20];
        
        [self.view addSubview:_submitButton];
        
//        [_submitButton setShowTouch:YES];
//        [_submitButton addTarget:self action:@selector(clickSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

-(CGRect)getTableViewFrame{
    self.noticeBack.frame = CGRectMake(0, 0, self.view.width, 30);
    
    self.submitButton.x = 0;
    self.submitButton.width = self.view.width;
    self.submitButton.height = 60;
    self.submitButton.maxY = self.view.height;
    
    return CGRectMake(0, self.noticeBack.height, self.view.width, self.view.height - self.noticeBack.height - self.submitButton.height);
}

-(void)headerRefresh:(MJTableBaseView *)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler{
    int64_t delay = 0.5 * NSEC_PER_SEC;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//模拟网络请求产生异步加载
        [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
            [svo addCellVoByList:[CellVo dividingCellVoBySourceArray:80 cellClass:FrameDishesViewCell.class sourceArray:self.dishesModels]];
        }]];
        endRefreshHandler(YES);
    });
}

-(void)tableView:(MJTableBaseView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CellVo* cvo = [tableView getCellVoByIndexPath:indexPath];
    DishesModel* dishesModel = cvo.cellData;
    WebViewController* webViewController = [[WebViewController alloc]init];
    webViewController.linkUrl = dishesModel.linkUrl;
    webViewController.navigationTitle = dishesModel.title;
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_BACKGROUND;
    
//    CGFloat const noticeBackHeight = 30;
//    self.noticeBack.frame = CGRectMake(0, 0, self.view.width, noticeBackHeight);
    
    CGFloat const leftMargin = 10;
    self.noticeLabel.centerY = self.noticeIcon.centerY = self.noticeBack.height / 2.;
    self.noticeIcon.x = leftMargin;
    self.noticeLabel.x = self.noticeIcon.maxX + leftMargin;
}


@end