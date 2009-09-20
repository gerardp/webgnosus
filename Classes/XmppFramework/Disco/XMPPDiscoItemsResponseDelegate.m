//
//  XMPPDiscoItemsResponseDelegate.m
//  webgnosus
//
//  Created by Troy Stribling on 9/18/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "XMPPDiscoItemsResponseDelegate.h"
#import "XMPPDiscoInfoQuery.h"
#import "XMPPDiscoItem.h"
#import "XMPPResponse.h"
#import "XMPPJID.h"
#import "XMPPClient.h"
#import "XMPPPubSub.h"
#import "XMPPIQ.h"
#import "XMPPError.h"
#import "ServiceItemModel.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface XMPPDiscoItemsResponseDelegate (PrivateAPI)

- (void)didDiscoverUserPubSubNode:(XMPPDiscoItem*)item forService:(XMPPJID*)serviceJID andParentNode:(NSString*)node;
- (void)didFailToDiscoverUserPubSubNode:(XMPPClient*)client forIQ:(XMPPIQ*)iq;
- (NSString*)targetJIDPubSubRoot;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation XMPPDiscoItemsResponseDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize targetJID;

//===================================================================================================================================
#pragma mark XMPPDiscoItemsResponseDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)init:(XMPPJID*)initJID {
	if(self = [super init])  {
        self.targetJID = initJID;
	}
	return self;
}

//===================================================================================================================================
#pragma mark XMPPDiscoItemsResponseDelegate PrivateAPI

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSString*)targetJIDPubSubRoot {
    return [[[NSString alloc] initWithFormat:@"/home/%@/%@", [self.targetJID domain], [self.targetJID user]] autorelease];	
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)didDiscoverUserPubSubNode:(XMPPDiscoItem*)item forService:(XMPPJID*)serviceJID andParentNode:(NSString*)node {
    [ServiceItemModel insert:item forService:serviceJID andParentNode:node];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)didFailToDiscoverUserPubSubNode:(XMPPClient*)client forIQ:(XMPPIQ*)iq {
    if ([[[client myJID] full] isEqualToString:[self.targetJID full]]) {
        [XMPPPubSub create:client JID:[iq fromJID] node:[self targetJIDPubSubRoot]];
    }
}

//===================================================================================================================================
#pragma mark XMPPResponse Delegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)handleError:(XMPPClient*)client forStanza:(XMPPStanza*)stanza {
    XMPPIQ* iq = (XMPPIQ*)stanza;
    XMPPDiscoItemsQuery* query = (XMPPDiscoItemsQuery*)[iq query];
	NSString* node = [query node];
    XMPPError* error = [iq error];	
    if (error) {
        if ([node isEqualToString:[self targetJIDPubSubRoot]] && [[error condition] isEqualToString:@"item-not-found"]) {
            [self didFailToDiscoverUserPubSubNode:client forIQ:iq];        
        } 
    }    
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)handleResult:(XMPPClient*)client forStanza:(XMPPStanza*)stanza {
    XMPPDiscoItemsQuery* query = (XMPPDiscoItemsQuery*)[(XMPPIQ*)stanza query];
	NSString* node = [query node];
    NSArray* items = [query items];	
	XMPPJID* serviceJID = [stanza fromJID];
    if ([node isEqualToString:[self targetJIDPubSubRoot]]) {
        for(int i = 0; i < [items count]; i++) {
            XMPPDiscoItem* item = [XMPPDiscoItem createFromElement:(NSXMLElement *)[items objectAtIndex:i]];
            [self didDiscoverUserPubSubNode:item forService:serviceJID andParentNode:node];
        }
    } else if ([node isEqualToString:@"http://jabber.org/protocol/commands"] && [[[stanza fromJID] full] isEqualToString:[self.targetJID full]]) {
        for(int i = 0; i < [items count]; i++) {
            XMPPDiscoItem* item = [XMPPDiscoItem createFromElement:(NSXMLElement *)[items objectAtIndex:i]];
            [ServiceItemModel insert:item forService:serviceJID andParentNode:node];
        }
    } else {
        for(int i = 0; i < [items count]; i++) {
            XMPPDiscoItem* item = [XMPPDiscoItem createFromElement:(NSXMLElement *)[items objectAtIndex:i]];
            if ([item node] == nil) { 
                [XMPPDiscoInfoQuery get:client JID:[item JID] node:[item node] forTarget:self.targetJID];
                [ServiceItemModel insert:item forService:serviceJID andParentNode:nil];
            }
        }
    }
}

//===================================================================================================================================
#pragma mark NSObject

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)dealloc {
    [super dealloc];
}

@end
