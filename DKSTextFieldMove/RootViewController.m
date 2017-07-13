//
//  RootViewController.m
//  DKSTextFieldMove
//
//  Created by aDu on 2017/7/13.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import "RootViewController.h"
#import "TestViewController.h"
#import "RootCell.h"

#define K_Cell @"cell"
@interface RootViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"根视图";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(pushNextPage)];
}

- (void)pushNextPage {
    TestViewController *testVC = [[TestViewController alloc] initWithNibName:@"TestViewController" bundle:nil];
    [self.navigationController pushViewController:testVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RootCell *cell = [tableView dequeueReusableCellWithIdentifier:K_Cell forIndexPath:indexPath];
    cell.textField.inputAccessoryView = [self addToolbar];
    return cell;
}

#pragma mark ====== init ======
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:@"RootCell" bundle:nil] forCellReuseIdentifier:K_Cell];
        _tableView.rowHeight = 60;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (UIToolbar *)addToolbar
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35)];
    toolbar.tintColor = [UIColor blueColor];
    toolbar.backgroundColor = [UIColor grayColor];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolbar.items = @[space, bar];
    return toolbar;
}

- (void)textFieldDone {
    [self.view endEditing:YES];
}

@end
