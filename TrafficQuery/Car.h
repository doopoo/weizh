//
//  Car.h
//  TrafficQuery
//
//  Created by hz on 13-4-15.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject{
    NSString* carPaiNum;//车牌号
    NSString* carJiaNum;//车驾号
    NSString* carBiaoName;//车标名称
    NSString* carName;//车名
}
@property(nonatomic, retain)NSString* carPaiNum;
@property(nonatomic, retain)NSString* carJiaNum;
@property(nonatomic, retain)NSString* carBiaoName;
@property(nonatomic, retain)NSString* carName;

-(id)initWithDictionary:(NSDictionary*)dic;

@end
