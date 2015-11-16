//
//  StudentsEntity.h
//  test
//
//  Created by zm on 15/10/22.
//  Copyright (c) 2015年 zhangmin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface StudentsEntity : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSNumber * chinese;
@property (nonatomic, retain) NSNumber * math;
@property (nonatomic, retain) NSString * value1;
@end
