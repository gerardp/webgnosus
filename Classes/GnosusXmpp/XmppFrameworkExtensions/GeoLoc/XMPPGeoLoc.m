//
//  XMPPGeoLoc.m
//  webgnosus
//
//  Created by Troy Stribling on 3/29/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "XMPPGeoLoc.h"
#import "XMPPTimestamp.h"
#import "XMPPPubSub.h"
#import "XMPPIQ.h"
#import "XMPPPubSubGeoLocDelegate.h"
#import "XMPPClient.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface XMPPGeoLoc (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation XMPPGeoLoc

//-----------------------------------------------------------------------------------------------------------------------------------

//===================================================================================================================================
#pragma mark XMPPGeoLoc

//-----------------------------------------------------------------------------------------------------------------------------------
+ (XMPPGeoLoc*)createFromElement:(NSXMLElement*)element {
	XMPPGeoLoc* result = (XMPPGeoLoc*)element;
	result->isa = [XMPPGeoLoc class];
	return result;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (XMPPGeoLoc*)init {
	if(self = [super initWithName:@"geoloc"]) {
        [self addNamespace:[NSXMLNode namespaceWithName:@"" stringValue:@"http://jabber.org/protocol/geoloc"]];
	}
	return self;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (double)lat {
	return [[[self elementForName:@"lat"] stringValue] doubleValue];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)addLat:(double)val {
	[self addChild:[NSXMLElement elementWithName:@"lat" stringValue:[NSString stringWithFormat:@"%f", val]]];	
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (double)alt {
	return [[[self elementForName:@"alt"] stringValue] doubleValue];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)addAlt:(double)val {
	[self addChild:[NSXMLElement elementWithName:@"alt" stringValue:[NSString stringWithFormat:@"%f", val]]];	
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (double)lon {
	return [[[self elementForName:@"lon"] stringValue] doubleValue];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)addLon:(double)val {
	[self addChild:[NSXMLElement elementWithName:@"lon" stringValue:[NSString stringWithFormat:@"%f", val]]];	
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (double)accuracy {
	return [[[self elementForName:@"accuracy"] stringValue] doubleValue];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)addAccuracy:(double)val {
	[self addChild:[NSXMLElement elementWithName:@"accuracy" stringValue:[NSString stringWithFormat:@"%f", val]]];	
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (double)bearing {
	return [[[self elementForName:@"bearing"] stringValue] doubleValue];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)addBearing:(double)val {
	[self addChild:[NSXMLElement elementWithName:@"bearing" stringValue:[NSString stringWithFormat:@"%f", val]]];	
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSString*)locality {
    return [[self elementForName:@"locality"] stringValue];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)addLocality:(NSString*)val {
    [self addChild:[NSXMLElement elementWithName:@"locality" stringValue:val]];	
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSString*)country {
    return [[self elementForName:@"country"] stringValue];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)addCountry:(NSString*)val {
    [self addChild:[NSXMLElement elementWithName:@"contry" stringValue:val]];	
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSDate*)timestamp {
	return [XMPPTimestamp dateFromString:[[self elementForName:@"timestamp"] stringValue]];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)addTimestamp:(NSDate*)val {
	[self addChild:[NSXMLElement elementWithName:@"timestamp" stringValue:[XMPPTimestamp stringFromDate:val]]];	
}

//-----------------------------------------------------------------------------------------------------------------------------------
+ (void)publish:(XMPPClient*)client withData:(NSXMLElement*)data {
    XMPPIQ* iq = [XMPPPubSub buildPubSubIQWithJID:nil node:@"http://jabber.org/protocol/geoloc" andData:data];
    [client send:iq andDelegateResponse:[[XMPPPubSubGeoLocDelegate alloc] init]];
}

//===================================================================================================================================
#pragma mark XMPPGeoLoc PrivateAPI


//===================================================================================================================================
#pragma mark NSObject

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)dealloc {
    [super dealloc];
}

@end
