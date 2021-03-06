//
//  ServiceSearchViewController.h
//  webgnosus
//
//  Created by Troy Stribling on 10/11/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>

//-----------------------------------------------------------------------------------------------------------------------------------
@class AccountModel;
@class ServiceViewController;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ServiceSearchViewController : UIViewController <UITextFieldDelegate> {
	IBOutlet UITextField* addressTextField;
	IBOutlet UITextField* nodeTextField;
    ServiceViewController* rootServiceController;
    AccountModel* account;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UITextField* addressTextField;
@property (nonatomic, retain) UITextField* nodeTextField;
@property (nonatomic, retain) ServiceViewController* rootServiceController;
@property (nonatomic, retain) AccountModel* account;

//-----------------------------------------------------------------------------------------------------------------------------------


@end
