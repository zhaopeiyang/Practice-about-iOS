//
//  ViewController.m
//  Layer
//
//  Created by ifeng on 2018/4/25.
//  Copyright © 2018年 ifeng. All rights reserved.
//

#import "ViewController.h"

static NSString *const kLayerCellReuseIdentifier = @"kLayerCellReuseIdentifier";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Layer";
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLayerCellReuseIdentifier
                                                            forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    cell.textLabel.text = dict[@"Title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = self.dataArray[indexPath.row];
    Class cls = NSClassFromString(dict[@"ViewController"]);
    UIViewController *vc = [[cls alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        
        [_tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:kLayerCellReuseIdentifier];
    }
    return _tableView;
}

- (NSArray *)dataArray
{
    if (nil == _dataArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"LayerDataSource"
                                                         ofType:@"plist"];
        _dataArray = [NSArray arrayWithContentsOfFile:path];
    }
    return _dataArray;
}

@end
