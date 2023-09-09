//
//  LanguageManagerClass.m
//  Almnabr
//
//  Created by MacBook on 30/09/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

#import "LanguageManagerClass.h"

@implementation LanguageManagerClass
+(NSString *)setLocalizedText:(NSString *)stringValue
{
    if (!stringValue || stringValue.length <= 0)
        return @"";
    
    return  DPAutolocalizedString(stringValue, stringValue);
}
@end
