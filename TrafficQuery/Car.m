//
//  Car.m
//  TrafficQuery
//
//  Created by hz on 13-4-15.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "Car.h"

@implementation Car

@synthesize carPaiNum;
@synthesize carJiaNum;
@synthesize carBiaoName;
@synthesize carName;

-(id)initWithDictionary:(NSDictionary *)dic{
    if([self init]){
        self.carPaiNum = [dic valueForKey:@"carNum"];
        self.carJiaNum = [dic valueForKey:@"carJiaNum"];
        self.carBiaoName = [dic valueForKey:@"carImageNum"];
        self.carName = [dic valueForKey:@"carImage"];
    }
    return self;
}
-(void)dealloc{
    [carPaiNum release];
    [carJiaNum release];
    [carBiaoName release];
    [carName release];
    [super dealloc];
}

@end
