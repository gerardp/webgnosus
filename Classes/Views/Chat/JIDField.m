//
//  JIDField.m
//  webgnosus
//
//  Created by Troy Stribling on 11/19/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "JIDField.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface JIDField (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation JIDField

//===================================================================================================================================
#pragma mark JIDField

//-----------------------------------------------------------------------------------------------------------------------------------
- (BOOL)isValidJID {
    BOOL isValid = YES;
    NSString* field = self.text;
    if (field) {
        if (![field isEqualToString:@""]) {
            NSArray* splitJid = [self.text componentsSeparatedByString:@"@"];
            if ([splitJid count] != 2) {
                isValid = NO;
            }
        }
    }
    return isValid;
}

//===================================================================================================================================
#pragma mark JIDField PrivateAPI

//===================================================================================================================================
#pragma mark UIView

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)drawRect:(CGRect)rect {
}

//===================================================================================================================================
#pragma mark NSObject

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)dealloc {
    [super dealloc];
}

@end
