//
//  YAExtraItem.m
//  XiaoBao
//
//  Created by 陈亚伦 on 2017/2/23.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YAExtraItem.h"
#import <MJExtension.h>
@implementation YAExtraItem
+ (instancetype)extraItemWithKeyValues:(id)responseObject {
   return [YAExtraItem mj_objectWithKeyValues:responseObject];
}
@end
