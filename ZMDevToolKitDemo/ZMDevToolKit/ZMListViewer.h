//
//  ZMListViewer.h
//  ZMDevToolKit
//
//  Created by zm on 15/11/11.
//  Copyright (c) 2015年 timanetworks. All rights reserved.
//

#ifndef test_ZMListViewer_h
#define test_ZMListViewer_h

@interface ZMListViewer : UITableViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)NSMutableArray *listData;
@end
#endif
