//
//  ZMFileSystemViewer.m
//  ZMDevToolKit
//
//  Created by zm on 15/11/11.
//  Copyright (c) 2015年 timanetworks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZMFileSystemViewer.h"

@implementation ZMFileSystemViewer
{
    NSMutableArray *contents;
}

@synthesize rootDirectory;

-(void)viewDidLoad
{
    [super viewDidLoad];
    if (!rootDirectory) {
        rootDirectory = NSHomeDirectory();
    }
    if (!contents) {
        contents = [[NSMutableArray alloc] init];
    }
    
    NSError *err;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:rootDirectory error:&err];
    if (files) {
        [contents setArray:files];
    }
    
    UITableView *tableViewFileSystem = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableViewFileSystem.dataSource = self;
    tableViewFileSystem.delegate = self;
    tableViewFileSystem.rowHeight = 44.0f;
    tableViewFileSystem.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:tableViewFileSystem];
    
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    [self.view addGestureRecognizer:rightSwipeGestureRecognizer];
}
-(void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString * dir = [rootDirectory stringByReplacingOccurrencesOfString:NSHomeDirectory() withString:@""];
    if ([dir isEqualToString:@""]) {
        dir = @"./";
    }
    return dir;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return contents.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *path = [NSString stringWithFormat:@"%@/%@", rootDirectory, [contents objectAtIndex:indexPath.row]];
    
    NSNumber *isDirectory;
    [[NSURL fileURLWithPath:path] getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:NULL];
    
    if ([isDirectory boolValue] == YES) {
        ZMFileSystemViewer *view = [[ZMFileSystemViewer alloc]init];
        [view setRootDirectory:path];
        [self.navigationController pushViewController:view animated:YES];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    cell.textLabel.text = [contents objectAtIndex:indexPath.row];
    NSString *path = [NSString stringWithFormat:@"%@/%@", rootDirectory, [contents objectAtIndex:indexPath.row]];
    
    NSNumber *isDirectory;
    [[NSURL fileURLWithPath:path] getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:NULL];
    
    if ([isDirectory boolValue] == YES) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.text = @"文件夹";
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        NSFileManager *manager = [NSFileManager defaultManager];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYMMdd HH:mm:ss"];
        
        NSDictionary *attr = [manager attributesOfItemAtPath:path error:nil];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"文件:C:%@ M:%@ S:%.1lluK",
                                     [formatter stringFromDate:[attr fileCreationDate]],
                                     [formatter stringFromDate:[attr fileModificationDate]],
                                     [attr fileSize] / (1024)];
    }
    
    return cell;
}
-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return @"删除";
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;//默认没有编辑风格
    result = UITableViewCellEditingStyleDelete;//设置编辑风格为删除风格
    return result;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{//请求数据源提交的插入或删除指定行接收者。
    if (editingStyle == UITableViewCellEditingStyleDelete) {//如果编辑样式为删除样式
        NSString *path = [NSString stringWithFormat:@"%@/%@", rootDirectory, [contents objectAtIndex:indexPath.row]];
        NSError *err;
        [[NSFileManager defaultManager] removeItemAtPath:path error:&err];
        [contents removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];//移除tableView中的数据
    }
}

@end