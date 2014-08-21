//
//  MathUtil.m
//  TestRest
//
//  Created by KindAzrael on 14-8-17.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import "MathUtil.h"

@implementation MathUtil

+ (double)getRandomGPSInc {
  int i = [MathUtil getRandomFrom:-1000 to:1000];
  return i * 0.00001;
}

+ (int)getRandomFrom:(int)from to:(int)to {
  return from + (arc4random() % (to - from + 1));
}

@end
