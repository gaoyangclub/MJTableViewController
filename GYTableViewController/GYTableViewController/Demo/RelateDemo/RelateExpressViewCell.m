//
//  RelateExpressViewCell.m
//  GYTableViewController
//
//  Created by 高扬 on 2018/3/27.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "RelateExpressViewCell.h"
#import "ExpressModel.h"

#define LEFT_AREA_WIDTH 100
#define NORMAL_ROUTE_RADIUS 5
#define FIRST_ROUTE_RADIUS 7

@interface RelateExpressViewCell()

@property (nonatomic,strong) UIView *routeLine;//竖直线
@property (nonatomic,strong) UIView *roundNode;//圆点
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *yearLabel;
@property (nonatomic,strong) UILabel *timeLabel;

@end

@implementation RelateExpressViewCell

#pragma mark 根据外部传入数据开始布局
- (void)showSubviews {
    self.backgroundColor = [UIColor whiteColor];
    
    ExpressModel* expressModel = [self getCellData];
    
    self.titleLabel.text = expressModel.title;
    [self.titleLabel sizeToFit];
    
    self.yearLabel.text = expressModel.year;
    [self.yearLabel sizeToFit];
    self.timeLabel.text = expressModel.time;
    [self.timeLabel sizeToFit];
    
    CGFloat const gap = 3;
    CGFloat const baseY = (self.contentView.height - self.yearLabel.height - gap - self.timeLabel.height) / 2;
    
    self.yearLabel.y = baseY;
    self.timeLabel.y = self.yearLabel.maxY + gap;
    self.yearLabel.centerX = self.timeLabel.centerX = LEFT_AREA_WIDTH / 2.;
    
    self.routeLine.x = LEFT_AREA_WIDTH;
    
    self.titleLabel.x = self.routeLine.maxX + 20;
    self.titleLabel.centerY = self.contentView.height / 2.;
    
    [self checkCellRelate];
}

#pragma mark 设置选中效果
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self checkCellRelate];
}
//如要显示选中后一直按下效果 请使用setSelected
//- (BOOL)showSelectionStyle{
//    return YES;
//}
#pragma mark 位于第一个或最后一个和中间段的选中未选中的Cell样式不同
- (void)checkCellRelate {
    self.titleLabel.textColor = self.yearLabel.textColor = self.timeLabel.textColor = self.selected ? TVStyle.colorPrimaryExpress : TVStyle.colorTextPrimary;
    UIColor *nodeColor;
    if (self.selected) {
        nodeColor = TVStyle.colorPrimaryExpress;
    }else{
        nodeColor = TVStyle.colorLine;
    }
    if (self.isFirst) {
        [self drawFirstStyle:nodeColor];
    }else if(self.isLast){
        [self drawLastStyle:nodeColor];
    }else{
        [self drawNormalStyle:nodeColor];
    }
}

- (void)drawFirstStyle:(UIColor *)color {
    self.routeLine.height = self.contentView.height / 2.;
    self.routeLine.y = self.contentView.height / 2.;
    self.roundNode.size = CGSizeMake(FIRST_ROUTE_RADIUS * 2, FIRST_ROUTE_RADIUS * 2);
    self.roundNode.layer.borderColor = color.CGColor;
    self.roundNode.layer.borderWidth = 2;
    self.roundNode.layer.cornerRadius = FIRST_ROUTE_RADIUS;
    self.roundNode.layer.masksToBounds = YES;
    self.roundNode.centerX = self.routeLine.centerX;
    self.roundNode.centerY = self.contentView.height / 2.;
    self.roundNode.backgroundColor = [UIColor whiteColor];
}

- (void)drawLastStyle:(UIColor *)color {
    self.routeLine.height = self.contentView.height / 2.;
    self.routeLine.y = 0;
    self.roundNode.size = CGSizeMake(FIRST_ROUTE_RADIUS * 2, FIRST_ROUTE_RADIUS * 2);
    self.roundNode.layer.borderColor = color.CGColor;
    self.roundNode.layer.borderWidth = 2;
    self.roundNode.layer.cornerRadius = FIRST_ROUTE_RADIUS;
    self.roundNode.layer.masksToBounds = YES;
    self.roundNode.centerX = self.routeLine.centerX;
    self.roundNode.centerY = self.contentView.height / 2.;
    self.roundNode.backgroundColor = [UIColor whiteColor];
}

- (void)drawNormalStyle:(UIColor *)color {
    self.routeLine.height = self.contentView.height;
    self.routeLine.y = 0;
    self.roundNode.size = CGSizeMake(NORMAL_ROUTE_RADIUS * 2, NORMAL_ROUTE_RADIUS * 2);
    self.roundNode.layer.borderColor = [UIColor clearColor].CGColor;
    self.roundNode.layer.borderWidth = 0;
    self.roundNode.layer.cornerRadius = NORMAL_ROUTE_RADIUS;
    self.roundNode.layer.masksToBounds = YES;
    self.roundNode.centerX = self.routeLine.centerX;
    self.roundNode.centerY = self.contentView.height / 2.;
    self.roundNode.backgroundColor = color;
}

#pragma mark 懒加载添加视图
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createLabel:TVStyle.sizeTextPrimary color:TVStyle.colorTextPrimary];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)yearLabel {
    if (!_yearLabel) {
        _yearLabel = [UICreationUtils createLabel:TVStyle.sizeTextSecondary color:TVStyle.colorTextPrimary];
        [self.contentView addSubview:_yearLabel];
    }
    return _yearLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UICreationUtils createLabel:TVStyle.sizeTextPrimary color:TVStyle.colorTextPrimary];
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UIView *)routeLine {
    if (!_routeLine) {
        _routeLine = [[UIView alloc]init];
        _routeLine.width = 2;
        _routeLine.backgroundColor = TVStyle.colorLine;
        [self.contentView addSubview:_routeLine];
    }
    return _routeLine;
}

- (UIView *)roundNode {
    if (!_roundNode) {
        _roundNode = [[UIView alloc]init];
        [self.contentView addSubview:_roundNode];
    }
    return _roundNode;
}

@end
