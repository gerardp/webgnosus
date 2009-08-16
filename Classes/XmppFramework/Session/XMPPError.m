//
//  XMPPError.m
//  webgnosus
//
//  Created by Troy Stribling on 3/29/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "XMPPError.h"
#import "NSXMLElementAdditions.h"

//-----------------------------------------------------------------------------------------------------------------------------------

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation XMPPError

//-----------------------------------------------------------------------------------------------------------------------------------

//===================================================================================================================================
#pragma mark XMPPBind

//-----------------------------------------------------------------------------------------------------------------------------------
+ (XMPPError*)createFromElement:(NSXMLElement*)element {
	XMPPError* result = (XMPPError*)element;
	result->isa = [XMPPError class];
	return result;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (XMPPError*)init {
	if(self = [super initWithName:@"error"]) {
	}
	return self;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (XMPPError*)initWithType:(NSString*)errorType {
	if([self init]) {
        [self addType:errorType];
	}
	return self;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSString*)type {
    return [[self attributeForName:@"type"] stringValue];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)addType:(NSString*)val {
    [self addAttributeWithName:@"type" stringValue:val];
}

@end
