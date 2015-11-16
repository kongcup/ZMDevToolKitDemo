//
//  ZMUserDefaultViewer.m
//  ZMDevToolKit
//
//  Created by zm on 15/11/11.
//  Copyright (c) 2015年 timanetworks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZMUserDefaultViewer.h"
#import "ZMListViewer.h"

@implementation ZMUserDefaultViewer
{
    NSDictionary *userDefault;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
    userDefault = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    
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
    return [[userDefault allKeys] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    NSString *key = [[userDefault allKeys] objectAtIndex:indexPath.row];
    cell.textLabel.text = key;
    id value = [userDefault objectForKey:key];
    if ([value isKindOfClass:[NSArray class]]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.text = @"";
    }
    else
    {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", value];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *key = [[userDefault allKeys] objectAtIndex:indexPath.row];
    id value = [userDefault objectForKey:key];
    if ([value isKindOfClass:[NSArray class]]) {
        ZMListViewer *view = [[ZMListViewer alloc] init];
        [view setListData:value];
        [self.navigationController pushViewController:view animated:YES];
    }
    else
    {
        NSString *msg = [NSString stringWithFormat:@"%@", value];
        if (msg.length > 700) {
            msg = [msg substringToIndex:700];
        }
        UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:key message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        [dialog show];
    }
}

@end