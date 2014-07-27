//
//  Location.h
//  TestRest
//
//  Created by KindAzrael on 14-7-27.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

@property(nonatomic, retain) NSString *type;
@property(nonatomic, retain) NSArray *coordinates;

- (id)initWithX:(double)x andY:(double)y;

@end
