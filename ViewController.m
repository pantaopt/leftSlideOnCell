//
//  ViewController.m
//  leftSlideOnCell
//
//  Created by wkr on 16/5/24.
//  Copyright © 2016年 pantao. All rights reserved.
//
#define kUISCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define kUISCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define kScale kUISCREENWIDTH/375

#import "ViewController.h"
#import "bottomCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,cellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.tableView];
    _dataArray = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:@"close" forKey:@"status"];
        [dic setValue:[NSString stringWithFormat:@"zuohua %d",i] forKey:@"title"];
        [_dataArray addObject:dic];
    }
    [self.tableView reloadData];
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, kUISCREENWIDTH, 180*kScale+30) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark cellDelegate
- (void)open:(NSInteger)row{
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
//    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
    [self.dataArray[row] setValue:@"open" forKey:@"status"];
    for (NSMutableDictionary *dict in self.dataArray) {
        if ([self.dataArray indexOfObject:dict] != row && [[dict valueForKey:@"status"] isEqualToString:@"open"]) {
            [dict setValue:@"close" forKey:@"status"];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.dataArray indexOfObject:dict]*2 inSection:0];
            NSLog(@" -- %ld",[self.dataArray indexOfObject:dict]*2);
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            break;
        }
        
    }
}

- (void)btn0:(NSInteger)row{
    NSLog(@"删除第%ld行",(long)row);
}

- (void)btn1:(NSInteger)row{
    NSLog(@"修改第%ld行",(long)row);
}

#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row%2 != 0){
        return 10;
    }
    return 60*kScale;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row%2 != 0){
        static NSString *cellId = @"cellId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    static NSString *cellId = @"bottomCell";
    bottomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[bottomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.touchRow = indexPath.row/2;
    cell.delegate = self;
    cell.title.text = [_dataArray[indexPath.row/2] valueForKey:@"title"];
    if ([[_dataArray[indexPath.row/2] valueForKey:@"status"] isEqualToString:@"close"]) {
        [cell offsetBack];
    }else{
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
