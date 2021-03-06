//
//  CommandFormViewController.m
//  webgnosus
//
//  Created by Troy Stribling on 11/5/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "CommandFormViewController.h"
#import "CommandFormView.h"
#import "MessageModel.h"
#import "AlertViewManager.h"
#import "XMPPClient.h"
#import "XMPPClientManager.h"
#import "XMPPError.h"
#import "XMPPCommand.h"
#import "XMPPIQ.h"
#import "XMPPxData.h"
#import "XMPPJID.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface CommandFormViewController (PrivateAPI)

- (void)saveMessage:(NSString*)data forNode:(NSString*)node;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation CommandFormViewController

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize formScrollView;
@synthesize cancelButton;
@synthesize sendButton;
@synthesize formView;
@synthesize form;
@synthesize account;

//===================================================================================================================================
#pragma mark CommandFormViewController PrivateAPI

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)saveMessage:(NSString*)data forNode:(NSString*)node {
    MessageModel* model = [[MessageModel alloc] init];
    model.messageText = data;
    model.accountPk = self.account.pk;
    model.toJid = [[self.form fromJID] full];
    model.fromJid = [self.account fullJID];
    model.createdAt = [NSDate dateWithTimeIntervalSinceNow:0];
    model.textType = MessageTextTypeCommandXData;
    model.itemId = @"-1";
    model.messageRead = YES;
    model.node = node;
    [model insert];
    [model release];
}

//===================================================================================================================================
#pragma mark CommandFormViewController

//-----------------------------------------------------------------------------------------------------------------------------------
+ (CommandFormViewController*)viewController:(XMPPIQ*)initForm forAccount:(AccountModel*)initAccount {
    return [[[CommandFormViewController alloc] initWithNibName:@"CommandFormViewController" bundle:nil forForm:initForm andAccount:initAccount] autorelease];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (IBAction)cancelButtonPressed:(id)sender {
    XMPPCommand* command = [self.form command];
    XMPPJID* toJID = [self.form fromJID];
    NSString* sessionID =[command sessionID];
    NSString* node = [command node];
    XMPPClient* client = [[XMPPClientManager instance] xmppClientForAccount:self.account];
    [XMPPCommand cancel:client commandNode:node JID:toJID andSessionID:sessionID];
    [self saveMessage:@"cancel" forNode:[command node]];
    [AlertViewManager showActivityIndicatorInView:self.view.window withTitle:@"Canceling"];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (IBAction)sendButtonPressed:(id)sender {
    XMPPxData* fields = [self.formView formFields];
    XMPPCommand* command = [self.form command];
    XMPPJID* toJID = [self.form fromJID];
    NSString* sessionID =[command sessionID];
    NSString* node = [command node];
    XMPPClient* client = [[XMPPClientManager instance] xmppClientForAccount:self.account];
    [XMPPCommand set:client commandNode:node withData:fields JID:toJID andSessionID:sessionID];
    [self saveMessage:[fields XMLString] forNode:[command node]];
    [AlertViewManager showActivityIndicatorInView:self.view.window withTitle:@"Waiting for Response"];
}

//===================================================================================================================================
#pragma mark XMPPClientDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)sender didReceiveCommandError:(XMPPIQ*)iq {
    [AlertViewManager dismissActivityIndicator];
    XMPPError* error = [iq error];
    NSString* msg = @"";
    if (error) {
        msg = [error text];
    } 
    [AlertViewManager showAlert:@"Command Error" withMessage:msg];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)sender didReceiveCommandResult:(XMPPIQ*)iq {
    [AlertViewManager dismissActivityIndicator];
    [self.view removeFromSuperview];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)sender didReceiveCommandForm:(XMPPIQ*)iq {
    [AlertViewManager dismissActivityIndicator];
    [self.view removeFromSuperview];
}

//===================================================================================================================================
#pragma mark UIViewController

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)nibBundle forForm:(XMPPIQ*)initForm andAccount:(AccountModel*)initAccount { 
	if (self = [super initWithNibName:nibName bundle:nibBundle]) { 
        self.form = initForm;
        self.account = initAccount;
        self.view.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
	} 
	return self; 
} 

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];	
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated {
    self.formView = [CommandFormView viewWithForm:self.form inParentView:self.formScrollView];
    [self.formScrollView setContentSize:self.formView.frame.size];
    [[XMPPClientManager instance] delegateTo:self forAccount:self.account];
    [self.formScrollView addSubview:self.formView];
	[super viewWillAppear:animated];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillDisappear:(BOOL)animated {
    [[XMPPClientManager instance] removeXMPPClientDelegate:self forAccount:self.account];
	[super viewWillDisappear:animated];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; 
}

//===================================================================================================================================
#pragma mark UITableViewController

//===================================================================================================================================
#pragma mark UITableViewDeligate

//===================================================================================================================================
#pragma mark NSObject

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)dealloc {
    [super dealloc];
}

@end

