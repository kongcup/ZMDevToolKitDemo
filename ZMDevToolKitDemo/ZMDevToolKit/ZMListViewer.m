//
//  ZMListViewer.m
//  ZMDevToolKit
//
//  Created by zm on 15/11/11.
//  Copyright (c) 2015年 timanetworks. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZMListViewer.h"


@implementation ZMListViewer

@synthesize listData;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //_listData = [[NSMutableArray alloc] init];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    UITableView *mytableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    mytableView.dataSource = self;
    mytableView.delegate = self;
    [self.view addSubview:mytableView];
    
    //右滑返回
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    [self.view addGestureRecognizer:rightSwipeGestureRecognizer];
}

-(void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    id value = [listData objectAtIndex:indexPath.row];
    if ([value isKindOfClass:[NSString class]]) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", value];
    }
    else
    {
        cell.textLabel.text = @"unkonwn";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end