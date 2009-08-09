//
//  XMPPPubSupOwner.m
//  webgnosus
//
//  Created by Troy Stribling on 8/8/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "XMPPPubSupOwner.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation XMPPPubSupOwner

//===================================================================================================================================
#pragma mark XMPPPubSupOwner

//-----------------------------------------------------------------------------------------------------------------------------------

//===================================================================================================================================
#pragma mark XMPPPubSupOwner

//-----------------------------------------------------------------------------------------------------------------------------------
+ (XMPPPubSupOwner*)createFromElement:(NSXMLElement*)element {
    XMPPPubSupOwner* result = (XMPPPubSupOwner*)element;
    result->isa = [XMPPPubSupOwner class];
    return result;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (XMPPPubSupOwner*)init {
	if(self = [super initWithName:@"pubsub"]) {
        [self addNamespace:[NSXMLNode namespaceWithName:@"" stringValue:@"http://jabber.org/protocol/pubsub#owner"]];
	}
	return self;
}

@end