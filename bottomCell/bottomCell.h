//
//  bottomCell.h
//  leftSlideOnCell
//
//  Created by wkr on 16/5/24.
//  Copyright © 2016年 pantao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol cellDelegate <NSObject>

- (void)open:(NSInteger)row;

- (void)btn0:(NSInteger)row;

- (void)btn1:(NSInteger)row;

@end

@interface bottomCell : UITableViewCell<UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger btnWidth;// cell的宽度
@property (nonatomic, assign) NSInteger cellHeight;// cell的高度

@property (nonatomic, strong) UIButton *btn0;// 右起第一个按钮

@property (nonatomic, strong) UIButton *btn1;// 右起第二个按钮

@property (nonatomic, strong) UIScrollView *topScrollView;// 顶部的scrollview

@property (nonatomic, strong) UIView *topView;// 顶部scrollview上的view
@property (nonatomic, strong) UILabel *title;

@property (nonatomic, assign) NSInteger touchRow;// 记碰的那一行

@property (nonatomic, weak) id<cellDelegate>delegate;

- (void)offsetBack;

@end
