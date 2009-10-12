//
//  ServiceViewController.h
//  webgnosus
//
//  Created by Troy Stribling on 10/11/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>

//-----------------------------------------------------------------------------------------------------------------------------------
@class AccountModel;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ServiceViewController : UITableViewController {
	UIBarButtonItem* editAccountsButton;
	UIBarButtonItem* changeServiceButton;
    NSMutableArray* services;
    NSString* parentNode;
    AccountModel* account;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UIBarButtonItem* editAccountsButton;
@property (nonatomic, retain) UIBarButtonItem* changeServiceButton;
@property (nonatomic, retain) NSMutableArray* services;
@property (nonatomic, retain) NSString* parentNode;
@property (nonatomic, retain) AccountModel* account;

//-----------------------------------------------------------------------------------------------------------------------------------

@end
