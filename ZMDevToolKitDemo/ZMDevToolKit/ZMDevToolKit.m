//
//  ZMDevToolKit.m
//  ZMDevToolKit
//
//  Created by zm on 15/11/11.
//  Copyright (c) 2015年 timanetworks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZMDevToolKit.h"
#import "ZMMagicalRecordViewer.h"
#import "ZMUserDefaultViewer.h"
#import "ZMFileSystemViewer.h"

@implementation ZMDevToolKit
{
    NSMutableDictionary *toollist;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    toollist = [[NSMutableDictionary alloc] init];
    
    [toollist setObject:@"文件系统" forKey:@"ZMFileSystemViewer"];
    [toollist setObject:@"数据库Magical Record" forKey:@"ZMMagicalRecordViewer"];
    [toollist setObject:@"数据库User Default" forKey:@"ZMUserDefaultViewer"];
    
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
    return [[toollist allKeys] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSArray *tools = [toollist allKeys];
    cell.textLabel.text = [toollist objectForKey:[tools objectAtIndex:indexPath.row]];
    cell.detailTextLabel.text = [tools objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *tools = [toollist allKeys];
    NSString *cls =  [tools objectAtIndex:indexPath.row];
    UIViewController *view = [[ NSClassFromString(cls) alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

@end