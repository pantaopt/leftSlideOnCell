//
//  bottomCell.m
//  leftSlideOnCell
//
//  Created by wkr on 16/5/24.
//  Copyright © 2016年 pantao. All rights reserved.
//
#define kUISCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define kUISCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define kScale kUISCREENWIDTH/375

#import "bottomCell.h"

@implementation bottomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.topScrollView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [tap addTarget:self action:@selector(offsetBack)];
        [self.contentView addGestureRecognizer:tap];
    }
    return self;
}


- (UIScrollView *)topScrollView{
    if (!_topScrollView) {
        _topScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kUISCREENWIDTH+120*kScale, 60*kScale)];
        _topScrollView.delegate = self;
        _topScrollView.backgroundColor = [UIColor whiteColor];
        _topScrollView.contentSize = CGSizeMake(kUISCREENWIDTH+240*kScale, 60*kScale);
        _topScrollView.backgroundColor = [UIColor clearColor];
//        _topScrollView.backgroundColor = [UIColor brownColor];
        _topScrollView.showsHorizontalScrollIndicator = NO;
        [_topScrollView addSubview:self.btn0];
        [_topScrollView addSubview:self.btn1];
        [_topScrollView addSubview:self.topView];
    }
    return _topScrollView;
}

- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kUISCREENWIDTH, 60*kScale)];
        _topView.backgroundColor = [UIColor greenColor];
        [_topView addSubview:self.title];
    }
    return _topView;
}

- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]initWithFrame:CGRectMake(10*kScale, 10*kScale, 80*kScale, 40*kScale)];
        _title.textColor = [UIColor whiteColor];
    }
    return _title;
}

- (UIButton *)btn0{
    if (!_btn0) {
        _btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn0.frame = CGRectMake(kUISCREENWIDTH+60*kScale, 0, 60*kScale, 60*kScale);
        [_btn0 setTitle:@"删除" forState:UIControlStateNormal];
        [_btn0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn0.backgroundColor = [UIColor redColor];
        [_btn0 addTarget:self action:@selector(btnAction0) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn0;
}

- (UIButton *)btn1{
    if (!_btn1) {
        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn1.frame = CGRectMake(kUISCREENWIDTH, 0, 60*kScale, 60*kScale);
        [_btn1 setTitle:@"修改" forState:UIControlStateNormal];
        [_btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn1.backgroundColor = [UIColor lightGrayColor];
        [_btn1 addTarget:self action:@selector(btnAction1) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn1;
}

- (void)btnAction0{
    [self.delegate btn0:self.touchRow];
}

- (void)btnAction1{
    [self.delegate btn1:self.touchRow];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self offsetBack];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@" == %f",self.topScrollView.contentOffset.x);
    if (self.topScrollView.contentOffset.x > 120*kScale) {
        [self.topScrollView setContentOffset:CGPointMake(120*kScale, 0) animated:NO];
    }else if (self.topScrollView.contentOffset.x < 0){
        [self.topScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    NSLog(@" -- %f",self.topScrollView.contentOffset.x);
    if (self.topScrollView.contentOffset.x < 60*kScale) {
        [self.topScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else{
        [self.topScrollView setContentOffset:CGPointMake(120*kScale, 0) animated:YES];
    }
    if (self.topScrollView.contentOffset.x > 0) {
        [self.delegate open:self.touchRow];
    }
}

- (void)offsetBack{
    [self.topScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}



//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    if ([touch.view isKindOfClass:[UIButton class]]){
//        return NO;
//    }
//    
//    return YES;
//}


@end
