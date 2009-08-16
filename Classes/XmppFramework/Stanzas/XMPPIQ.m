//
//  XMPPIQ.m
//  webgnosus
//
//  Created by Troy Stribling on 3/29/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "XMPPIQ.h"
#import "XMPPQuery.h"
#import "XMPPRegisterQuery.h"
#import "XMPPAuthorizationQuery.h"
#import "XMPPClientVersionQuery.h"
#import "XMPPRosterQuery.h"
#import "XMPPBind.h"
#import "XMPPSession.h"
#import "XMPPCommand.h"
#import "NSXMLElementAdditions.h"

//-----------------------------------------------------------------------------------------------------------------------------------

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface XMPPIQ (PrivateAPI)

- (XMPPQuery*) createQueryFromElement;

@end


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation XMPPIQ

//-----------------------------------------------------------------------------------------------------------------------------------

//===================================================================================================================================
#pragma mark XMPPIQ

//-----------------------------------------------------------------------------------------------------------------------------------
+ (XMPPIQ*)createFromElement:(NSXMLElement*)element {
	XMPPIQ* result = (XMPPIQ *)element;
	result->isa = [XMPPIQ class];
	return result;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (XMPPIQ*)initWithType:(NSString*)iqType {
	if(self = (XMPPIQ*)[super initWithName:@"iq"]) {
        [self addType:iqType];
	}
	return self;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (XMPPIQ*)initWithType:(NSString*)iqType toJID:(NSString*)iqToJID {
	if([self initWithType:iqType]) {
        [self addToJID:iqToJID];
	}
	return self;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (XMPPQuery*)query {
    return [self createQueryFromElement];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)addQuery:(XMPPQuery*)child {
    [self addChild:child];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (XMPPSession*)session {
    return [XMPPSession createFromElement:[self elementForName:@"session"]];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)addSession:(XMPPSession*)child {
    [self addChild:child];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (XMPPBind*)bind {
    XMPPBind* iqBind = nil;
    NSXMLElement* bindElement = [self elementForName:@"bind"];
    if (bindElement) {
        iqBind = [XMPPBind createFromElement:bindElement];
    }
    return iqBind;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)addBind:(XMPPBind*)child {
    [self addChild:child];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (XMPPCommand*)command {
    XMPPCommand* iqCommand = nil;
    NSXMLElement* commandElement = [self elementForName:@"command"];
    if (commandElement) {
        iqCommand = [XMPPCommand createFromElement:commandElement];
    }
    return iqCommand;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)addCommand:(XMPPCommand*)child {
    [self addChild:child];
}

//===================================================================================================================================
#pragma mark XMPPIQ PrivateAPI

//-----------------------------------------------------------------------------------------------------------------------------------
- (XMPPQuery*)createQueryFromElement {
    XMPPQuery* iqQuery = nil;
    NSXMLElement* queryElement = [self elementForName:@"query"];
    NSString* queryXMLNS = [queryElement xmlns];
    if ([queryXMLNS isEqualToString:@"jabber:iq:register"]) {
        iqQuery = [XMPPRegisterQuery createFromElement:queryElement];
    } else if ([queryXMLNS isEqualToString:@"jabber:iq:auth"]) {
        iqQuery = [XMPPAuthorizationQuery createFromElement:queryElement];
    } else if ([queryXMLNS isEqualToString:@"jabber:iq:version"]) {
        iqQuery = [XMPPClientVersionQuery createFromElement:queryElement];
    } else if ([queryXMLNS isEqualToString:@"jabber:iq:roster"]) {
        iqQuery = [XMPPRosterQuery createFromElement:queryElement];
    }
    return iqQuery;
}

@end
