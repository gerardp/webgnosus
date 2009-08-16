//
//  XMPPBind.m
//  webgnosus
//
//  Created by Troy Stribling on 3/29/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "XMPPBind.h"
#import "NSXMLElementAdditions.h"

//-----------------------------------------------------------------------------------------------------------------------------------

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation XMPPBind

//-----------------------------------------------------------------------------------------------------------------------------------

//===================================================================================================================================
#pragma mark XMPPBind

//-----------------------------------------------------------------------------------------------------------------------------------
+ (XMPPBind*)createFromElement:(NSXMLElement*)element {
	XMPPBind* result = (XMPPBind*)element;
	result->isa = [XMPPBind class];
	return result;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (XMPPBind*)init {
	if(self = [super initWithName:@"bind"]) {
        [self addNamespace:[NSXMLNode namespaceWithName:@"" stringValue:@"urn:ietf:params:xml:ns:xmpp-bind"]];
	}
	return self;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (XMPPBind*)initWithResource:(NSString*)bindResource {
	if([self init]) {
        [self addResource:bindResource];
	}
	return self;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSString*)resource {
    return [[self elementForName:@"resource"] stringValue];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)addResource:(NSString*)val {
    [self addChild:[NSXMLElement elementWithName:@"resource" stringValue:val]];
}

@end
