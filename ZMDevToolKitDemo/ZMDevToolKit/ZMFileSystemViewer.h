//
//  ZMFileSystemViewer.h
//  ZMDevToolKit
//
//  Created by zm on 15/11/11.
//  Copyright (c) 2015年 timanetworks. All rights reserved.
//

#ifndef test_ZMFileSystemViewer_h
#define test_ZMFileSystemViewer_h

@interface ZMFileSystemViewer : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)NSString *rootDirectory;

@end
#endif
