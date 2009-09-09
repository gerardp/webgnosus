//
//  MessageCell.m
//  webgnosus
//
//  Created by Troy Stribling on 4/17/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "MessageCell.h"
#import "MessageModel.h"
#import "NSXMLElementAdditions.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface MessageCell (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation MessageCell

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize dateLabel;
@synthesize jidLabel;

//===================================================================================================================================
#pragma mark MessageCell

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)setJidAndTime:(MessageModel*)message {
    self.jidLabel.text = [message fromJid];
    NSRange dateAndTime = {0, 19};
    self.dateLabel.text = [[message.createdAt description] substringWithRange:dateAndTime];
}

//===================================================================================================================================
#pragma mark MessageCell PrivateAPI

//===================================================================================================================================
#pragma mark UITableViewCell

//===================================================================================================================================
#pragma mark NSObject

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)dealloc {
    [super dealloc];
}

@end
